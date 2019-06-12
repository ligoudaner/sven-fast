package com.sven.modules.sys.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.sven.common.annotation.DataFilter;
import com.sven.common.exception.RRException;
import com.sven.common.utils.Constant;
import com.sven.common.utils.PageUtils;
import com.sven.common.utils.Query;
import com.sven.modules.sys.dao.SysRoleDao;
import com.sven.modules.sys.entity.SysDeptEntity;
import com.sven.modules.sys.entity.SysRoleEntity;
import com.sven.modules.sys.service.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

/**
 * 角色
 *
 * @author Mark sunlightcs@gmail.com
 */
@Service("sysRoleService")
public class SysRoleServiceImpl extends ServiceImpl<SysRoleDao, SysRoleEntity> implements SysRoleService {
	@Autowired
	private SysRoleMenuService sysRoleMenuService;
	@Autowired
	private SysRoleDeptService sysRoleDeptService;
	@Autowired
	private SysUserRoleService sysUserRoleService;
	@Autowired
	private SysDeptService sysDeptService;
	@Autowired
	private SysUserService sysUserService;

	@Override
	@DataFilter(subDept = true, user = false)
	public PageUtils queryPage(Map<String, Object> params) {
		String roleName = (String)params.get("roleName");

		IPage<SysRoleEntity> page = this.page(
				new Query<SysRoleEntity>().getPage(params),
				new QueryWrapper<SysRoleEntity>()
						.like(StrUtil.isNotBlank(roleName),"role_name", roleName)
						.apply(params.get(Constant.SQL_FILTER) != null, (String)params.get(Constant.SQL_FILTER))
		);

		for(SysRoleEntity sysRoleEntity : page.getRecords()){
			SysDeptEntity sysDeptEntity = sysDeptService.getById(sysRoleEntity.getDeptId());
			if(sysDeptEntity != null){
				sysRoleEntity.setDeptName(sysDeptEntity.getName());
			}
		}

		return new PageUtils(page);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	@DataFilter(subDept = true, user = false)
	public void saveRole(Set<Long> deptIdList,SysRoleEntity role,Long userId) {
		role.setCreateTime(new Date());
		this.save(role);
		//检查权限是否越权
		checkPrems(deptIdList,role,userId);
		//保存角色与菜单关系
		sysRoleMenuService.saveOrUpdate(role.getRoleId(), role.getMenuIdList());

		//保存角色与部门关系
		sysRoleDeptService.saveOrUpdate(role.getRoleId(), role.getDeptIdList());
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	@DataFilter(subDept = true, user = false)
	public void update(Set<Long> deptIdList,SysRoleEntity role,Long userId) {
		this.updateById(role);
		//检查权限是否越权
		checkPrems(deptIdList,role,userId);
		//更新角色与菜单关系
		sysRoleMenuService.saveOrUpdate(role.getRoleId(), role.getMenuIdList());

		//保存角色与部门关系
		sysRoleDeptService.saveOrUpdate(role.getRoleId(), role.getDeptIdList());
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public void deleteBatch(Long[] roleIds) {
		//删除角色
		this.removeByIds(Arrays.asList(roleIds));

		//删除角色与菜单关联
		sysRoleMenuService.deleteBatch(roleIds);

		//删除角色与部门关联
		sysRoleDeptService.deleteBatch(roleIds);

		//删除角色与用户关联
		sysUserRoleService.deleteBatch(roleIds);
	}

	/**
	 * 检查权限是否越权
	 */
	private void checkPrems(Set<Long> deptIdList, SysRoleEntity role, Long userId){
		//如果不是超级管理员，则需要判断角色的权限是否超过自己的权限
		if(userId == Constant.SUPER_ADMIN){
			return ;
		}

		if(!deptIdList.containsAll(Arrays.asList(role.getDeptId()))){
			throw new RRException("角色所属部门，已超出你的权限范围");
		}
		//查询用户所拥有的菜单列表
		List<Long> menuIdList = sysUserService.queryAllMenuId(userId);
		//判断是否越权
		if(!menuIdList.containsAll(role.getMenuIdList())){
			throw new RRException("功能权限，已超出你的权限范围");
		}
		if(!deptIdList.containsAll(role.getDeptIdList())){
			throw new RRException("数据权限，已超出你的权限范围");
		}
	}
}
