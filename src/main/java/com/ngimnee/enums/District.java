package com.ngimnee.enums;

import java.util.LinkedHashMap;
import java.util.Map;

public enum District {
    // Hà Nội
    BA_DINH("Quận Ba Đình", City.HA_NOI),
    HOAN_KIEM("Quận Hoàn Kiếm", City.HA_NOI),
    DONG_DA("Quận Đống Đa", City.HA_NOI),
    HAI_BA_TRUNG("Quận Hai Bà Trưng", City.HA_NOI),
    THANH_XUAN("Quận Thanh Xuân", City.HA_NOI),
    CAU_GIAY("Quận Cầu Giấy", City.HA_NOI),
    TAY_HO("Quận Tây Hồ", City.HA_NOI),
    HA_DONG("Quận Hà Đông", City.HA_NOI),
    LONG_BIEN("Quận Long Biên", City.HA_NOI),
    HOANG_MAI("Quận Hoàng Mai", City.HA_NOI),
    NAM_TU_LIEM("Quận Nam Từ Liêm", City.HA_NOI),
    BAC_TU_LIEM("Quận Bắc Từ Liêm", City.HA_NOI),

    // Quảng Ninh
    HA_LONG("Thành phố Hạ Long", City.QUANG_NINH),
    CAM_PHA("Thành phố Cẩm Phả", City.QUANG_NINH),
    UONG_BI("Thành phố Uông Bí", City.QUANG_NINH),
    MONG_CAI("Thành phố Móng Cái", City.QUANG_NINH),

    // Hải Phòng
    HONG_BANG("Quận Hồng Bàng", City.HAI_PHONG),
    NGO_QUYEN("Quận Ngô Quyền", City.HAI_PHONG),
    LE_CHAN("Quận Lê Chân", City.HAI_PHONG),
    HAI_AN("Quận Hải An", City.HAI_PHONG),
    KIEN_AN("Quận Kiến An", City.HAI_PHONG),
    DO_SON("Quận Đồ Sơn", City.HAI_PHONG),

    // Ninh Bình
    NINH_BINH("Thành phố Ninh Bình", City.NINH_BINH),
    TAM_DIEP("Thành phố Tam Điệp", City.NINH_BINH),

    // Huế
    HUE("Thành phố Huế", City.HUE),

    // Đà Nẵng
    HAI_CHAU("Quận Hải Châu", City.DA_NANG),
    THANH_KHE("Quận Thanh Khê", City.DA_NANG),
    SON_TRA("Quận Sơn Trà", City.DA_NANG),
    LIEN_CHIEU("Quận Liên Chiểu", City.DA_NANG),
    CAM_LE("Quận Cẩm Lệ", City.DA_NANG),
    NGU_HANH_SON("Quận Ngũ Hành Sơn", City.DA_NANG),

    // Bình Dương
    THU_DAU_MOT("Thành phố Thủ Dầu Một", City.BINH_DUONG),
    DI_AN("Thành phố Dĩ An", City.BINH_DUONG),
    THUAN_AN("Thành phố Thuận An", City.BINH_DUONG),

    // TP Hồ Chí Minh
    QUAN_1("Quận 1", City.HO_CHI_MINH),
    QUAN_2("Quận 2", City.HO_CHI_MINH),
    QUAN_3("Quận 3", City.HO_CHI_MINH),
    QUAN_4("Quận 4", City.HO_CHI_MINH),
    QUAN_5("Quận 5", City.HO_CHI_MINH),
    QUAN_7("Quận 7", City.HO_CHI_MINH),
    QUAN_10("Quận 10", City.HO_CHI_MINH),
    QUAN_11("Quận 11", City.HO_CHI_MINH),
    TAN_PHU("Quận Tân Phú", City.HO_CHI_MINH),
    BINH_TAN("Quận Bình Tân", City.HO_CHI_MINH),
    BINH_THANH("Quận Bình Thạnh", City.HO_CHI_MINH),
    GO_VAP("Quận Gò Vấp", City.HO_CHI_MINH),
    TAN_BINH("Quận Tân Bình", City.HO_CHI_MINH),
    PHU_NHUAN("Quận Phú Nhuận", City.HO_CHI_MINH),
    THU_DUC("Thành phố Thủ Đức", City.HO_CHI_MINH);



    private final String districtName;
    private final City cityName;

    District(String districtName, City cityName) {
        this.districtName = districtName;
        this.cityName = cityName;
    }

    public static Map<String, String> getDistrictsByCity(City city) {
        Map<String, String> districts = new LinkedHashMap<>();    //LinkedHashMap: giữ nguyên không sắp xếp
        for  (District it : District.values()) {
            if(it.cityName.equals(city)) {
                districts.put(it.name(), it.districtName);
            }
        }
        return districts;
    }
}
