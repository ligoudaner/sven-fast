package com.sven.common.utils;

import java.util.HashMap;


/**
 * Map工具类
 *
 * @author Sven i_xiangwei@163.com
 */
public class MapUtils extends HashMap<String, Object> {

    @Override
    public MapUtils put(String key, Object value) {
        super.put(key, value);
        return this;
    }
}
