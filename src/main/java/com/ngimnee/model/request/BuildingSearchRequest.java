package com.ngimnee.model.request;

import com.ngimnee.model.dto.AbstractDTO;
import lombok.Data;

import java.util.List;

@Data
public class BuildingSearchRequest extends AbstractDTO {
    private String name;
    private Long floorArea;
    private String city;
    private String district;
    private String ward;
    private String street;
    private Long numberOfBasement;
    private String direction;
    private Long level;
    private Long rentAreaFrom;
    private Long rentAreaTo;
    private Long rentPriceFrom;
    private Long rentPriceTo;
    private String managerName;
    private String managerPhone;
    private Long staffId;
    private List<String> typeCode;
    private String status;
    private String typeO;
    private Integer isActive = 1;
    private String legal;
}
