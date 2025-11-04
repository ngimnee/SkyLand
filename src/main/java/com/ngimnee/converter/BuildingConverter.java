package com.ngimnee.converter;

import com.ngimnee.entity.*;
import com.ngimnee.enums.City;
import com.ngimnee.enums.District;
import com.ngimnee.model.dto.BuildingDTO;
import com.ngimnee.model.dto.CustomerDTO;
import com.ngimnee.model.response.BuildingSearchResponse;
import org.modelmapper.ModelMapper;
import org.modelmapper.PropertyMap;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

import static com.lowagie.text.Image.skip;

@Component
public class BuildingConverter {
    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private RentAreaConverter rentAreaConverter;

    public BuildingSearchResponse toBuildingSearchResponse(BuildingEntity buildingEntity) {
        BuildingSearchResponse res = modelMapper.map(buildingEntity, BuildingSearchResponse.class);
        List<RentAreaEntity> rentAreaEntities = buildingEntity.getRentAreas();

        String rentArea = rentAreaEntities.stream().map(it -> it.getValue().toString()).collect(Collectors.joining(", "));
        res.setRentArea(rentArea);

        String districtName = "";
        Map<String, String> districts;
        if (buildingEntity.getCity() != null && !buildingEntity.getCity().isEmpty()) {
            City city = City.valueOf(buildingEntity.getCity());
            districts = District.getDistrictsByCity(city);
            districtName = districts.get(buildingEntity.getDistrict());
        } else {
            districts = new LinkedHashMap<>();
        }

        String cityName = "";
        Map<String, String> cities = City.getCity();
        if(buildingEntity.getCity() != null && buildingEntity.getCity() != "") {
            cityName = cities.get(buildingEntity.getCity());
        }

        if(districtName != null && districtName != "" && cityName != null && cityName != "") {
            res.setAddress(buildingEntity.getStreet() + ", " + buildingEntity.getWard() + ", " + districtName + ", " + cityName);
        }

        return res;
    }

    public BuildingDTO toBuildingDTO(BuildingEntity buildingEntity) {
        return modelMapper.map(buildingEntity, BuildingDTO.class);
    }

    public BuildingEntity toEntity(BuildingDTO buildingDTO) {
        BuildingEntity buildingEntity = modelMapper.map(buildingDTO, BuildingEntity.class);
        buildingEntity.setTypeCode(removeAccent(buildingDTO.getTypeCode()));
        buildingEntity.setRentAreas(rentAreaConverter.toRentAreaEntityList(buildingDTO, buildingEntity));
        return buildingEntity;
    }

    public static String removeAccent(List<String> typeCodes)
    {
        return String.join(", ", typeCodes);
    }

    public void updateEntityFromDTO(BuildingDTO buildingDTO, BuildingEntity buildingEntity) {
        List<UserEntity> oldUsers = buildingEntity.getUsers();
        OrderEntity oldOrder = buildingEntity.getOrder();

        modelMapper.getConfiguration().setPropertyCondition(context -> true);
        modelMapper.map(buildingDTO, buildingEntity);

        // Khôi phục các quan hệ để tránh bị ghi đè null
        buildingEntity.setUsers(oldUsers);
        buildingEntity.setOrder(oldOrder);
    }

}
