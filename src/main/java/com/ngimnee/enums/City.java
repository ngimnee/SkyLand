package com.ngimnee.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum City {
    HA_NOI("Hà Nội"),
    HAI_PHONG("Hải Phòng"),
    QUANG_NINH("Hạ Long"),
    NINH_BINH("Ninh Bình"),

    HUE("Huế"),
    DA_NANG("Đà Nẵng"),

    BINH_DUONG("Bình Dương"),
    HO_CHI_MINH("Hồ Chí Minh");



    private final String cityName;
    City(String cityName) {
        this.cityName = cityName;
    }

    public static Map<String, String> getCity() {
        Map<String, String> cities = new LinkedHashMap<>();
        for(City it : City.values()) {
            cities.put(it.toString(), it.cityName);
        }
        return cities;
    }
}
