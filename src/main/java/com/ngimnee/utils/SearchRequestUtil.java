package com.ngimnee.utils;

import java.util.List;

public class SearchRequestUtil {

    @SuppressWarnings("unchecked")
    public static <T> T getObject(Object key, Class<T> tClass) {
        if (key == null) return null;

        Object value = key;

        // Nếu key là List (hoặc SingletonList) thì lấy phần tử đầu tiên
        if (key instanceof List<?>) {
            List<?> list = (List<?>) key;
            if (!list.isEmpty()) {
                value = list.get(0);
            } else {
                return null;
            }
        }

        String typeName = tClass.getTypeName();

        if (typeName.equals("java.lang.Long")) {
            value = !"".equals(value.toString()) ? Long.valueOf(value.toString()) : null;
        }
        else if (typeName.equals("java.lang.Integer")) {
            value = !"".equals(value.toString()) ? Integer.valueOf(value.toString()) : null;
        }
        else if (typeName.equals("java.lang.String")) {
            value = !"".equals(value.toString()) ? value.toString() : null;
        }
        else if (List.class.isAssignableFrom(tClass)) {
            // Nếu muốn trả về List thì luôn đảm bảo value là List
            if (!(value instanceof List<?>)) {
                value = List.of(value);
            }
        }

        return (T) value;
    }
}
