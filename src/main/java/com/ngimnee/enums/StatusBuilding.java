package com.ngimnee.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum StatusBuilding {
    //CONSTRUCTING("Đang xây dựng"),
    AVAILABLE("Chưa bán, có sẵn"),
    DEPOSITED("Đặt cọc"),
    SOLD("Đã bán");

    private final String statusName;
    StatusBuilding(String statusName) {
        this.statusName = statusName;
    }

    public static Map<String, String> getStatus() {
        Map<String, String> status = new LinkedHashMap<>();
        for(StatusBuilding it : StatusBuilding.values()) {
            status.put(it.toString(), it.statusName);
        }
        return status;
    }
}
