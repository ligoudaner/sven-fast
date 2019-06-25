package com.sven.modules.oauth2.authorization;

import com.sven.modules.oauth2.exception.AuthException;
import com.sven.modules.oauth2.model.AuthSource;
import com.sven.modules.oauth2.request.ResponseStatus;

import java.util.HashMap;
import java.util.Map;

/**
 * 授权工厂类，负责创建指定平台的授权类获取授权地址
 * <p>
 * 使用策略模式 + 工厂模式 避免大量的if else（swatch）操作
 *
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @since 1.8
 */
public class AuthorizationFactory {

    private static Map<String, Authorization> authorizationMap = new HashMap<>();
    private static boolean loader = false;

    private AuthorizationFactory() {

    }

    /**
     * 根据第三方平台，获取具体的授权工具
     *
     * @param source 平台
     * @return 具体的Authorization
     */
    public static Authorization getAuthorize(AuthSource source) {
        if (null == source) {
            throw new AuthException(ResponseStatus.NO_AUTH_SOURCE);
        }
        registerAllAuthorize();

        Authorization authorization = authorizationMap.get(source.toString());
        if (null == authorization) {
            throw new AuthException(ResponseStatus.UNIDENTIFIED_PLATFORM);
        }
        return authorization;
    }

    /**
     * 将所有Authorize的实现类注册到authorizeMap中，
     * 每次增加新的平台都需要在这儿添加注册代码
     */
    private static void registerAllAuthorize() {
        if (loader) {
            return;
        }
        AuthorizationFactory.register(AuthSource.QQ, new QqAuthorization());
        loader = true;
    }

    private static void register(AuthSource authSource, Authorization authorization) {
        authorizationMap.put(authSource.toString(), authorization);
    }
}
