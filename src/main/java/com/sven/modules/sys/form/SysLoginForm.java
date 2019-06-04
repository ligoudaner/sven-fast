package com.sven.modules.sys.form;

import lombok.Data;

/**
 * 登录表单
 *
 * @author Sven i_xiangwei@163.com
 */
@Data
public class SysLoginForm {
    private String username;
    private String password;
    private String captcha;
    private String uuid;


}
