package com.sven.modules.sys.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sven.modules.sys.entity.SysUserTokenEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 系统用户Token
 *
 * @author Sven i_xiangwei@163.com
 */
@Mapper
public interface SysUserTokenDao extends BaseMapper<SysUserTokenEntity> {

    SysUserTokenEntity queryByToken(String token);

}
