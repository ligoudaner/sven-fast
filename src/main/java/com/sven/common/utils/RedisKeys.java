package com.sven.common.utils;

/**
 * Redis所有Keys
 *
 * @author Sven i_xiangwei@163.com
 */
public class RedisKeys {

    public static String getSysConfigKey(String key){
        return "sys:config:" + key;
    }
}
