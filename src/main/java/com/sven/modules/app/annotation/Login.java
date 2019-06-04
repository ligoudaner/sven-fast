package com.sven.modules.app.annotation;

import java.lang.annotation.*;

/**
 * app登录效验
 *
 * @author Sven i_xiangwei@163.com
 */
@Target(ElementType.METHOD)
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface Login {
}
