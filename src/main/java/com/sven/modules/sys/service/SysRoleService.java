package com.sven.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sven.common.utils.PageUtils;
import com.sven.modules.sys.entity.SysRoleEntity;

import java.util.Map;
import java.util.Set;


/**
 * 角色
 *
 * @author Mark sunlightcs@gmail.com
 */
public interface SysRoleService extends IService<SysRoleEntity> {

	PageUtils queryPage(Map<String, Object> params);

	void saveRole(Set<Long> deptIdList, SysRoleEntity role, Long userId);

	void update(Set<Long> deptIdList, SysRoleEntity role,Long userId);

	void deleteBatch(Long[] roleIds);
}
