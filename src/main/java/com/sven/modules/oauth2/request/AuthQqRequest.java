package com.sven.modules.oauth2.request;

import cn.hutool.core.util.StrUtil;
import cn.hutool.http.HttpRequest;
import cn.hutool.http.HttpResponse;
import cn.hutool.json.JSONObject;
import cn.hutool.json.JSONUtil;
import com.sven.modules.oauth2.config.AuthConfig;
import com.sven.modules.oauth2.exception.AuthException;
import com.sven.modules.oauth2.model.AuthSource;
import com.sven.modules.oauth2.model.AuthToken;
import com.sven.modules.oauth2.model.AuthUser;
import com.sven.modules.oauth2.model.AuthUserGender;
import com.sven.modules.oauth2.utils.GlobalAuthUtil;
import com.sven.modules.oauth2.utils.StringUtils;
import com.sven.modules.oauth2.utils.UrlBuilder;

import java.util.Map;

/**
 * qq登录
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @author yangkai.shen (https://xkcoding.com)
 * @version 1.0
 * @since 1.8
 */
public class AuthQqRequest extends BaseAuthRequest {
    public AuthQqRequest(AuthConfig config) {
        super(config, AuthSource.QQ);
    }

    @Override
    protected AuthToken getAccessToken(String code) {
        String accessTokenUrl = UrlBuilder.getQqAccessTokenUrl(config.getClientId(), config.getClientSecret(), code, config
                .getRedirectUri());
        HttpResponse response = HttpRequest.get(accessTokenUrl).execute();
        Map<String, String> accessTokenObject = GlobalAuthUtil.parseStringToMap(response.body());
        if (!accessTokenObject.containsKey("access_token")) {
            throw new AuthException("Unable to get token from qq using code [" + code + "]");
        }
        return AuthToken.builder()
                .accessToken(accessTokenObject.get("access_token"))
                .expireIn(Integer.valueOf(accessTokenObject.get("expires_in")))
                .refreshToken(accessTokenObject.get("refresh_token"))
                .build();
    }

    @Override
    protected AuthUser getUserInfo(AuthToken authToken) {
        String accessToken = authToken.getAccessToken();
        String openId = this.getOpenId(accessToken);
        HttpResponse response = HttpRequest.get(UrlBuilder.getQqUserInfoUrl(config.getClientId(), accessToken, openId))
                .execute();
        JSONObject object= JSONUtil.parseObj(response.body());
        if (object.getInt("ret") != 0) {
            throw new AuthException(object.getStr("msg"));
        }
        String avatar = object.getStr("figureurl_qq_2");
        if (StringUtils.isEmpty(avatar)) {
            avatar = object.getStr("figureurl_qq_1");
        }
        return AuthUser.builder()
                .username(object.getStr("nickname"))
                .nickname(object.getStr("nickname"))
                .avatar(avatar)
                .location(object.getStr("province") + "-" + object.getStr("city"))
                .uuid(openId)
                .gender(AuthUserGender.getRealGender(object.getStr("gender")))
                .token(authToken)
                .source(AuthSource.QQ)
                .build();
    }

    private String getOpenId(String accessToken) {
        HttpResponse response = HttpRequest.get(UrlBuilder.getQqOpenidUrl("https://graph.qq.com/oauth2.0/me", accessToken))
                .execute();
        if (response.isOk()) {
            String body = response.body();
            String removePrefix = StrUtil.replace(body, "callback(", "");
            String removeSuffix = StrUtil.replace(removePrefix, ");", "");
            String openId = StrUtil.trim(removeSuffix);
            JSONObject object = JSONUtil.parseObj(openId);
            if (object.containsKey("openid")) {
                return object.getStr("openid");
            }
            throw new AuthException("Invalid openId");
        }
        throw new AuthException("Invalid openId");
    }
}
