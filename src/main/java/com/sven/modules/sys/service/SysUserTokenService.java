package com.sven.modules.sys.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.sven.common.utils.R;
import com.sven.modules.sys.entity.SysUserTokenEntity;

/**
 * 用户Token
 *
 * @author Sven i_xiangwei@163.com
 */
public interface SysUserTokenService extends IService<SysUserTokenEntity> {

	/**
	 * 生成token
	 * @param userId  用户ID
	 */
	R createToken(long userId);

	/**
	 * 退出，修改token值
	 * @param userId  用户ID
	 */
	void logout(long userId);

}
