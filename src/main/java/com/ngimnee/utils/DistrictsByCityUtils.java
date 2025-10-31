package com.ngimnee.utils;

import com.ngimnee.enums.City;
import com.ngimnee.enums.District;
import com.ngimnee.model.dto.BuildingDTO;
import java.util.LinkedHashMap;
import java.util.Map;

public class DistrictsByCityUtils {
    public static Map<String, String> getDistrictsByCity(BuildingDTO buildingDTO) {
        City selectedCity = null;
        try {
            selectedCity = City.valueOf(buildingDTO.getCity());
        } catch (Exception e) {
            selectedCity = null;
        }

        if (selectedCity != null) {
            return District.getDistrictsByCity(selectedCity);
        } else {
            return new LinkedHashMap<>();
        }
    }

    // Hàm dùng cho trang danh sách (chưa chọn city nên trả về rỗng)
    public static Map<String, String> getEmptyDistrict() {
        return new LinkedHashMap<>();
    }
}
