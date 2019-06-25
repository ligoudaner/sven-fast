package com.sven.modules.oauth2.request;

import lombok.Data;
import com.sven.modules.oauth2.authorization.AuthorizationFactory;
import com.sven.modules.oauth2.config.AuthConfig;
import com.sven.modules.oauth2.exception.AuthException;
import com.sven.modules.oauth2.model.AuthResponse;
import com.sven.modules.oauth2.model.AuthSource;
import com.sven.modules.oauth2.model.AuthToken;
import com.sven.modules.oauth2.model.AuthUser;
import com.sven.modules.oauth2.utils.AuthConfigChecker;

/**
 * @author yadong.zhang (yadong.zhang0415(a)gmail.com)
 * @version 1.0
 * @since 1.8
 */
@Data
public abstract class BaseAuthRequest implements AuthRequest {
    protected AuthConfig config;
    protected AuthSource source;

    public BaseAuthRequest(AuthConfig config, AuthSource source) {
        this.config = config;
        this.source = source;
        if (!AuthConfigChecker.isSupportedAuth(config)) {
            throw new AuthException(ResponseStatus.PARAMETER_INCOMPLETE);
        }
    }

    protected abstract AuthToken getAccessToken(String code);

    protected abstract AuthUser getUserInfo(AuthToken authToken);

    @Override
    public AuthResponse login(String code) {
        try {
            AuthToken authToken = this.getAccessToken(code);
            AuthUser user = this.getUserInfo(authToken);
            return AuthResponse.builder().code(ResponseStatus.SUCCESS.getCode()).data(user).build();
        } catch (Exception e) {
            return this.responseError(e);
        }
    }

    private AuthResponse responseError(Exception e) {
        int errorCode = ResponseStatus.FAILURE.getCode();
        if (e instanceof AuthException) {
            errorCode = ((AuthException) e).getErrorCode();
        }
        return AuthResponse.builder().code(errorCode).msg(e.getMessage()).build();
    }

    @Override
    public String authorize(long state) {
        return AuthorizationFactory.getAuthorize(source).getAuthorizeUrl(config,state);
    }
}
