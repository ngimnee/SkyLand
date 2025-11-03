package com.ngimnee.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum StatusOrder {
    DANG_XU_LY("Đang xử lý"),
    HOAN_THANH("Hoàn thành"),
    HUY("Đã hủy");

    private final String statusName;
    StatusOrder(String statusName) {
        this.statusName = statusName;
    }

    public static Map<String, String> getStatus() {
        Map<String, String> status = new LinkedHashMap<>();
        for(StatusOrder it : StatusOrder.values()) {
            status.put(it.toString(), it.statusName);
        }
        return status;
    }
}
