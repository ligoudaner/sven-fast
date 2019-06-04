package com.sven.modules.sys.dao;


import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sven.modules.sys.entity.SysLogEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 系统日志
 *
 * @author Sven i_xiangwei@163.com
 */
@Mapper
public interface SysLogDao extends BaseMapper<SysLogEntity> {

}
