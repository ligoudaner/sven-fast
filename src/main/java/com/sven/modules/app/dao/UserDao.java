package com.sven.modules.app.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sven.modules.app.entity.UserEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 用户
 *
 * @author Sven i_xiangwei@163.com
 */
@Mapper
public interface UserDao extends BaseMapper<UserEntity> {

}
