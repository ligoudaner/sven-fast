package com.sven.modules.job.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sven.common.utils.PageUtils;
import com.sven.modules.job.entity.ScheduleJobLogEntity;

import java.util.Map;

/**
 * 定时任务日志
 *
 * @author Sven i_xiangwei@163.com
 */
public interface ScheduleJobLogService extends IService<ScheduleJobLogEntity> {

	PageUtils queryPage(Map<String, Object> params);

}
