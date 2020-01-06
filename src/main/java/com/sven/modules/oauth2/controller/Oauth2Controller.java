package com.sven.modules.oauth2.controller;

import cn.hutool.json.JSONUtil;
import com.sven.common.utils.ConfigConstant;
import com.sven.common.utils.R;
import com.sven.common.websocket.SocketServer;
import com.sven.modules.oauth2.config.AuthConfig;
import com.sven.modules.oauth2.model.AuthResponse;
import com.sven.modules.oauth2.request.AuthQqRequest;
import com.sven.modules.oauth2.request.AuthRequest;
import com.sven.modules.oauth2.request.ResponseStatus;
import com.sven.modules.sys.service.SysConfigService;
import com.sven.modules.sys.service.SysUserTokenService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * @Description: 第三方登录
 * @Author: xiangwei
 * @CreateDate: 2019-06-14 10:06
 */
@RestController
@RequestMapping("/oauth2")
public class Oauth2Controller {

    @Autowired
    private SysConfigService sysConfigService;
    @Autowired
    private SysUserTokenService sysUserTokenService;


    /**
     * 获取qq授权登录页面地址
     * @return
     */
    @GetMapping("/getQqAuthorizeUrl")
    public R  getQqAuthorizeUrl(){
        AuthConfig config = sysConfigService.getConfigObject(ConfigConstant.QQ_OAUTH_CONFIG_KEY, AuthConfig.class);
        AuthRequest authRequest = new AuthQqRequest(config);
        long state=System.currentTimeMillis();
        return R.ok().put("qqAuthorizeUrl", authRequest.authorize(state)).put("state",state);
    }

    /**
     *qq授权之后回调
     */
    @GetMapping("/notify/qq")
    public void notifyQq(String code,String state) {
        AuthConfig config = sysConfigService.getConfigObject(ConfigConstant.QQ_OAUTH_CONFIG_KEY, AuthConfig.class);
        AuthRequest authRequest = new AuthQqRequest(config);
        AuthResponse authResponse=authRequest.login(code);
        if(authResponse.getCode()== ResponseStatus.SUCCESS.getCode()){
            //这里是将结果通过websocket返回给前端
            SocketServer.sendMessage(JSONUtil.toJsonStr(sysUserTokenService.createToken(1l)),state);
        }

    }
}
