package com.sven.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sven.modules.sys.entity.SysRoleEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 角色管理
 *
 * @author Sven i_xiangwei@163.com
 */
@Mapper
public interface SysRoleDao extends BaseMapper<SysRoleEntity> {

}
