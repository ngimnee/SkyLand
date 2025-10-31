package com.ngimnee.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum TypeCode {
    TANG_TRET("Tầng trệt"),
    NGUYEN_CAN("Nguyên căn"),
    NOI_THAT("Nội thất"),
    VILLA("Villa"),
    CAN_HO("Căn hộ"),
    CHUNG_CU("Chung cư");

    private final String typeCodeName;
    TypeCode(String typeCodeName) {
        this.typeCodeName = typeCodeName;
    }

    public static Map<String, String> getTypeCode() {
        Map<String, String> typeCodes = new LinkedHashMap<>();
        for(TypeCode it : TypeCode.values()) {
            typeCodes.put(it.toString(), it.typeCodeName);
        }
        return typeCodes;
    }
}
