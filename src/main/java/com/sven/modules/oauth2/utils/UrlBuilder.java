package com.sven.modules.oauth2.utils;

import com.sven.modules.oauth2.consts.ApiUrl;

import java.text.MessageFormat;

/**
 * Url构建工具类
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @since 1.0
 */
public class UrlBuilder {
    private static final String QQ_ACCESS_TOKEN_PATTERN = "{0}?client_id={1}&client_secret={2}&grant_type=authorization_code&code={3}&redirect_uri={4}";
    private static final String QQ_USER_INFO_PATTERN = "{0}?oauth_consumer_key={1}&access_token={2}&openid={3}";
    private static final String QQ_AUTHORIZE_PATTERN = "{0}?client_id={1}&response_type=code&redirect_uri={2}&state={3}";
    private static final String QQ_OPENID_PATTERN = "{0}?access_token={1}";
    /**
     * 获取qq token的接口地址
     *
     * @param clientId     qq 应用的App Key
     * @param clientSecret qq 应用的App Secret
     * @param code         qq 授权前的code，用来换token
     * @param redirectUri  待跳转的页面
     * @return full url
     */
    public static String getQqAccessTokenUrl(String clientId, String clientSecret, String code, String redirectUri) {
        return MessageFormat.format(QQ_ACCESS_TOKEN_PATTERN, ApiUrl.QQ.accessToken(), clientId, clientSecret, code, redirectUri);
    }

    /**
     * 获取qq用户详情的接口地址
     *
     * @param clientId qq 应用的clientId
     * @param token    qq 应用的token
     * @param openId   qq 应用的openId
     * @return full url
     */
    public static String getQqUserInfoUrl(String clientId, String token, String openId) {
        return MessageFormat.format(QQ_USER_INFO_PATTERN, ApiUrl.QQ.userInfo(), clientId, token, openId);
    }

    /**
     * 获取qq授权地址
     *
     * @param clientId    qq 应用的Client ID
     * @param redirectUrl qq 应用授权成功后的回调地址
     * @return full url
     */
    public static String getQqAuthorizeUrl(String clientId, String redirectUrl,long state) {
        return MessageFormat.format(QQ_AUTHORIZE_PATTERN, ApiUrl.QQ.authorize(), clientId, redirectUrl, state);
    }

    /**
     * 获取qq授权地址
     *
     * @param url   获取qqopenid的api接口地址
     * @param token qq 应用授权的token
     * @return full url
     */
    public static String getQqOpenidUrl(String url, String token) {
        return MessageFormat.format(QQ_OPENID_PATTERN, url, token);
    }
}
