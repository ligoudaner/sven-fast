package com.sven.modules.oauth2.authorization;

import com.sven.modules.oauth2.config.AuthConfig;
import com.sven.modules.oauth2.utils.UrlBuilder;

/**
 * QQ授权
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @since 1.8
 */
public class QqAuthorization implements Authorization {

    @Override
    public String getAuthorizeUrl(AuthConfig config,long state) {
        return UrlBuilder.getQqAuthorizeUrl(config.getClientId(), config.getRedirectUri(),state);
    }
}
