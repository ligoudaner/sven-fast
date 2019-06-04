package com.sven.modules.sys.form;

import lombok.Data;

/**
 * 密码表单
 *
 * @author Sven i_xiangwei@163.com
 */
@Data
public class PasswordForm {
    /**
     * 原密码
     */
    private String password;
    /**
     * 新密码
     */
    private String newPassword;

}
