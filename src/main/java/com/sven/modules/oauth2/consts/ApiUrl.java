package com.sven.modules.oauth2.consts;

import com.sven.modules.oauth2.exception.AuthException;
import com.sven.modules.oauth2.request.ResponseStatus;

/**
 * 各api需要的url， 用枚举类分平台类型管理
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @since 1.0
 */
public enum ApiUrl {

    /**
     * QQ
     */
    QQ {
        @Override
        public String authorize() {
            return "https://graph.qq.com/oauth2.0/authorize";
        }

        @Override
        public String accessToken() {
            return "https://graph.qq.com/oauth2.0/token";
        }

        @Override
        public String userInfo() {
            return "https://graph.qq.com/user/get_user_info";
        }

        @Override
        public String revoke() {
            throw new AuthException(ResponseStatus.UNSUPPORTED);
        }

        @Override
        public String refresh() {
            throw new AuthException(ResponseStatus.UNSUPPORTED);
        }
    };

    /**
     * 授权的api
     *
     * @return url
     */
    public abstract String authorize();

    /**
     * 获取accessToken的api
     *
     * @return url
     */
    public abstract String accessToken();

    /**
     * 获取用户信息的api
     *
     * @return url
     */
    public abstract String userInfo();

    /**
     * 取消授权的api
     *
     * @return url
     */
    public abstract String revoke();

    /**
     * 刷新授权的api
     *
     * @return url
     */
    public abstract String refresh();

}
