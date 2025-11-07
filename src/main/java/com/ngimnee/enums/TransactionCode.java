package com.ngimnee.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum TransactionCode {
    CSKH("Chăm sóc khách hàng"),
    VIEW("Dẫn khách hàng đi xem");

    private final String codeName;
    TransactionCode(String codeName) {
        this.codeName = codeName;
    }

    public static Map<String, String> getCodes() {
        Map<String, String> code = new LinkedHashMap<>();
        for(TransactionCode it : TransactionCode.values()) {
            code.put(it.toString(), it.codeName);
        }
        return code;
    }
}
