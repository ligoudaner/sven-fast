package com.sven.modules.job.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.sven.modules.job.entity.ScheduleJobLogEntity;
import org.apache.ibatis.annotations.Mapper;

/**
 * 定时任务日志
 *
 * @author Sven i_xiangwei@163.com
 */
@Mapper
public interface ScheduleJobLogDao extends BaseMapper<ScheduleJobLogEntity> {

}
