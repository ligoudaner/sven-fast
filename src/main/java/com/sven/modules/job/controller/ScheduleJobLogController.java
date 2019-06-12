package com.sven.modules.job.controller;

import com.sven.common.utils.PageUtils;
import com.sven.common.utils.R;
import com.sven.modules.job.entity.ScheduleJobLogEntity;
import com.sven.modules.job.service.ScheduleJobLogService;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

/**
 * 定时任务日志
 *
 * @author Sven i_xiangwei@163.com
 */
@RestController
@RequestMapping("/sys/scheduleLog")
public class ScheduleJobLogController {
	@Autowired
	private ScheduleJobLogService scheduleJobLogService;

	/**
	 * 定时任务日志列表
	 */
	@GetMapping("/list")
	@RequiresPermissions("sys:schedule:log")
	public R list(@RequestParam Map<String, Object> params){
		PageUtils page = scheduleJobLogService.queryPage(params);

		return R.ok().put("page", page);
	}

	/**
	 * 定时任务日志信息
	 */
	@GetMapping("/info/{logId}")
	public R info(@PathVariable("logId") Long logId){
		ScheduleJobLogEntity log = scheduleJobLogService.getById(logId);

		return R.ok().put("log", log);
	}
}
