package com.sven.modules.oss.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sven.common.utils.PageUtils;
import com.sven.modules.oss.entity.SysOssEntity;

import java.util.Map;

/**
 * 文件上传
 *
 * @author Sven i_xiangwei@163.com
 */
public interface SysOssService extends IService<SysOssEntity> {

	PageUtils queryPage(Map<String, Object> params);
}
