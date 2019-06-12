package com.sven.common.aspect;

import cn.hutool.json.JSONUtil;
import com.sven.common.annotation.SysLog;
import com.sven.common.utils.HttpContextUtils;
import com.sven.common.utils.IPUtils;
import com.sven.modules.sys.entity.SysLogEntity;
import com.sven.modules.sys.entity.SysUserEntity;
import com.sven.modules.sys.service.SysLogService;
import org.apache.shiro.SecurityUtils;
import org.aspectj.lang.JoinPoint;
import org.aspectj.lang.annotation.*;
import org.aspectj.lang.reflect.MethodSignature;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.NamedThreadLocal;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.stereotype.Component;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Method;
import java.text.SimpleDateFormat;
import java.util.Date;


/**
 * 系统日志，切面处理类
 *
 * @author Sven i_xiangwei@163.com
 */
@Aspect
@Component
public class SysLogAspect {
	private static final Logger logger= LoggerFactory.getLogger(SysLogAspect.class);
	private static final ThreadLocal<Date>beginTimeThreadLocal=new NamedThreadLocal<>("ThreadLocal beginTime");
	private static final ThreadLocal<SysLogEntity>logThreadLocal=new NamedThreadLocal<>("ThreadLocal log");
	@Autowired(required = false)
	private HttpServletRequest request;
	@Autowired
	private ThreadPoolTaskExecutor threadPoolTaskExecutor;
	@Autowired
	private SysLogService sysLogService;

	// 定义Pointcut，Pointcut的名称 就是simplePointcut，此方法不能有返回值，该方法只是一个标示
	// @annotation 指定自定义注解
	@Pointcut("@annotation(com.sven.common.annotation.SysLog)")
	public void logPointCut() {

	}

	@Before("logPointCut()")
	public void beFore(JoinPoint point){
		Date beginTime=new Date();
		beginTimeThreadLocal.set(beginTime);
		//debug模式下 显式打印开始时间用于调试
		if (logger.isDebugEnabled()) {
			logger.debug("开始计时: {}  URI: {}", new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS")
					.format(beginTime), request.getRequestURI());
		}
	}

	/**
	 * 后置通知 用于拦截Controller层操作
	 *
	 * @param joinPoint 切点
	 */
	@After("logPointCut()")
	public void doAfter(JoinPoint joinPoint){
		// debu模式下打印JVM信息。
		long beginTime = beginTimeThreadLocal.get().getTime();//得到线程绑定的局部变量（开始时间）
		long endTime = System.currentTimeMillis();    //2、结束时间
		if (logger.isDebugEnabled()) {
			logger.debug("计时结束：{}  URI: {}  耗时： {}   最大内存: {}m  已分配内存: {}m  已分配内存中的剩余空间: {}m  最大可用内存: {}m",
					new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.SSS").format(endTime),
					request.getRequestURI(),
					beginTime-endTime,
					Runtime.getRuntime().maxMemory() / 1024 / 1024,
					Runtime.getRuntime().totalMemory() / 1024 / 1024,
					Runtime.getRuntime().freeMemory() / 1024 / 1024,
					(Runtime.getRuntime().maxMemory() - Runtime.getRuntime().totalMemory() + Runtime.getRuntime().freeMemory()) / 1024 / 1024);
		}
		MethodSignature signature = (MethodSignature) joinPoint.getSignature();
		Method method = signature.getMethod();

		SysLogEntity sysLog = new SysLogEntity();
		SysLog syslog = method.getAnnotation(SysLog.class);
		if(syslog != null){
			//注解上的描述
			sysLog.setOperation(syslog.value());
		}

		//请求的方法名
		String className = joinPoint.getTarget().getClass().getName();
		String methodName = signature.getName();
		sysLog.setMethod(className + "." + methodName + "()");
		sysLog.setType("info");
		//请求的参数
		Object[] args = joinPoint.getArgs();
		try{
			String params = JSONUtil.toJsonStr(args);
			sysLog.setParams(params);
		}catch (Exception e){

		}
		//获取request
		HttpServletRequest request = HttpContextUtils.getHttpServletRequest();
		//设置IP地址
		sysLog.setIp(IPUtils.getIpAddr(request));

		//用户名
		String username = ((SysUserEntity) SecurityUtils.getSubject().getPrincipal()).getUsername();
		sysLog.setUsername(username);

		sysLog.setTime(endTime-beginTime);
		sysLog.setCreateDate(new Date());
		//保存系统日志
		threadPoolTaskExecutor.execute(new SaveLogThread(sysLog,sysLogService));
		logThreadLocal.set(sysLog);
	}

	@AfterThrowing(pointcut = "logPointCut()",throwing = "e")
	public void doAfterThrowing(JoinPoint joinPoint,Throwable e){
		SysLogEntity log=logThreadLocal.get();
		if(log!=null){
			log.setType("error");
			log.setException(e.toString());
			new UpdateLogThread(log,sysLogService).start();
		}
	}

	/**
	 * @Description: 保存日志线程
	 * @Author:     xiangwei
	 * @CreateDate: 2018/11/23 15:34
	 */
	private static class SaveLogThread implements Runnable{
		private SysLogEntity log;
		private SysLogService sysLogService;
		public SaveLogThread(SysLogEntity log,SysLogService sysLogService){
			this.log=log;
			this.sysLogService=sysLogService;
		}
		@Override
		public void run() {
			sysLogService.save(log);
		}
	}
	private static class UpdateLogThread extends Thread{
		private SysLogEntity log;
		private SysLogService sysLogService;
		public UpdateLogThread(SysLogEntity log,SysLogService sysLogService){
			super(UpdateLogThread.class.getSimpleName());
			this.log=log;
			this.sysLogService=sysLogService;
		}
		@Override
		public void run(){
			this.sysLogService.updateById(log);
		}
	}
}
