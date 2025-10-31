package com.ngimnee.converter;

import com.ngimnee.builder.BuildingSearchBuilder;
import com.ngimnee.model.request.BuildingSearchRequest;
import com.ngimnee.utils.SearchRequestUtil;
import org.springframework.stereotype.Component;

import java.util.List;

@Component
public class BuildingSearchBuilderConverter {
    public BuildingSearchBuilder toBuildingSearchBuilder(BuildingSearchRequest buildingSearchRequest, List<String> typeCode)
    {
        BuildingSearchBuilder buildingSearchBuilder = new BuildingSearchBuilder.Builder()
                .setName(SearchRequestUtil.getObject(buildingSearchRequest.getName(), String.class))
                .setFloorArea(SearchRequestUtil.getObject(buildingSearchRequest.getFloorArea(), Long.class))
                .setWard(SearchRequestUtil.getObject(buildingSearchRequest.getWard(), String.class))
                .setStreet(SearchRequestUtil.getObject(buildingSearchRequest.getStreet(), String.class))
                .setDistrict(SearchRequestUtil.getObject(buildingSearchRequest.getDistrict(), String.class))
                .setCity(SearchRequestUtil.getObject(buildingSearchRequest.getCity(), String.class))
                .setNumberOfBasement(SearchRequestUtil.getObject(buildingSearchRequest.getNumberOfBasement(), Integer.class))
                .setTypeCode(typeCode)
                .setManagerName(SearchRequestUtil.getObject(buildingSearchRequest.getManagerName(), String.class))
                .setManagerPhone(SearchRequestUtil.getObject(buildingSearchRequest.getManagerPhone(), String.class))
                .setRentPriceTo(SearchRequestUtil.getObject(buildingSearchRequest.getRentPriceTo(), Long.class))
                .setRentPriceFrom(SearchRequestUtil.getObject(buildingSearchRequest.getRentPriceFrom(), Long.class))
                .setRentAreaFrom(SearchRequestUtil.getObject(buildingSearchRequest.getRentAreaFrom(), Long.class))
                .setRentAreaTo(SearchRequestUtil.getObject(buildingSearchRequest.getRentAreaTo(), Long.class))
                .setStaffId(SearchRequestUtil.getObject(buildingSearchRequest.getStaffId(), Long.class))
                .setLevel(SearchRequestUtil.getObject(buildingSearchRequest.getLevel(), Long.class))
                .setDirection(SearchRequestUtil.getObject(buildingSearchRequest.getDirection(), String.class))
                .build();

        return buildingSearchBuilder;
    }
}
