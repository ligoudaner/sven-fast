package com.sven.common.aspect;


import cn.hutool.core.util.StrUtil;
import com.sven.common.annotation.DataFilter;
import com.sven.common.exception.RRException;
import com.sven.common.utils.Constant;
import com.sven.common.utils.ShiroUtils;
import com.sven.modules.sys.entity.SysUserEntity;
import com.sven.modules.sys.service.SysDeptService;
import com.sven.modules.sys.service.SysRoleDeptService;
import com.sven.modules.sys.service.SysUserRoleService;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Before;
import org.aspectj.lang.annotation.Pointcut;
import org.aspectj.lang.reflect.MethodSignature;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * 数据过滤，切面处理类
 *
 * @author Sven i_xiangwei@163.com
 */
@Aspect
@Component
public class DataFilterAspect {
    @Autowired
    private SysDeptService sysDeptService;
    @Autowired
    private SysUserRoleService sysUserRoleService;
    @Autowired
    private SysRoleDeptService sysRoleDeptService;

    @Pointcut("@annotation(com.sven.common.annotation.DataFilter)")
    public void dataFilterCut() {

    }

    @Before("dataFilterCut()")
    public void dataFilter(JoinPoint point) throws Throwable {
        Object params = point.getArgs()[0];
        if(params != null){
            SysUserEntity user = ShiroUtils.getUserEntity();
            //如果不是超级管理员，则进行数据过滤
            if(user.getUserId() != Constant.SUPER_ADMIN){
                if(params instanceof Map){
                    Map map= (Map) params;
                    map.put(Constant.SQL_FILTER, getSQLFilter(user, point,String.class));
                }else if(params instanceof Set){
                    Set<Long> deptIdList = (Set<Long>) params;
                    deptIdList.addAll(getSQLFilter(user, point,Set.class));
                }else{
                    throw new RRException("数据权限接口，只能是Map或Set类型参数");
                }

            }

            return ;
        }

        throw new RRException("数据权限接口，不能为NULL");
    }

    /**
     * 获取数据过滤的SQL
     */
    private <T>T getSQLFilter(SysUserEntity user, JoinPoint point,Class<T> returnClazz){
        MethodSignature signature = (MethodSignature) point.getSignature();
        DataFilter dataFilter = signature.getMethod().getAnnotation(DataFilter.class);
        //获取表的别名
        String tableAlias = dataFilter.tableAlias();
        if(StrUtil.isNotBlank(tableAlias)){
            tableAlias +=  ".";
        }

        //部门ID列表
        Set<Long> deptIdList = new HashSet<>();

        //用户角色对应的部门ID列表
        List<Long> roleIdList = sysUserRoleService.queryRoleIdList(user.getUserId());
        if(roleIdList.size() > 0){
            List<Long> userDeptIdList = sysRoleDeptService.queryDeptIdList(roleIdList.toArray(new Long[roleIdList.size()]));
            deptIdList.addAll(userDeptIdList);
//            deptIdList.removeAll(roleIdList);
        }
        //用户子部门ID列表
        if(dataFilter.subDept()){
            List<Long> subDeptIdList = sysDeptService.getSubDeptIdList(user.getDeptId());
            deptIdList.addAll(subDeptIdList);
        }
        if(returnClazz == Set.class){
            return (T)deptIdList;
        }
        StringBuilder sqlFilter = new StringBuilder();
        sqlFilter.append(" (");

        if(deptIdList.size() > 0){
            sqlFilter.append(tableAlias).append(dataFilter.deptId()).append(" in(").append(StrUtil.join(",",deptIdList)).append(")");
        }

        //没有本部门数据权限，也能查询本人数据
        if(dataFilter.user()){
            if(deptIdList.size() > 0){
                sqlFilter.append(" or ");
            }
            sqlFilter.append(tableAlias).append(dataFilter.userId()).append("=").append(user.getUserId());
        }

        sqlFilter.append(")");

        if(sqlFilter.toString().trim().equals("()")){
            return null;
        }

        return (T) sqlFilter.toString();
    }
}
