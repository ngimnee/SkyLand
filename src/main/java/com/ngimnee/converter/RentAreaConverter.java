package com.ngimnee.converter;

import com.ngimnee.entity.BuildingEntity;
import com.ngimnee.entity.RentAreaEntity;
import com.ngimnee.model.dto.BuildingDTO;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;


@Component
public class RentAreaConverter {
    public RentAreaEntity toRentAreaEntity(Long value, BuildingEntity buildingEntity)
    {
        RentAreaEntity res = new RentAreaEntity();
        res.setBuilding(buildingEntity);
        res.setValue(value);
        return res;
    }

    public List<RentAreaEntity> toRentAreaEntityList(BuildingDTO buildingDTO, BuildingEntity buildingEntity)
    {
        String[] rentAreas = buildingDTO.getRentArea().trim().split(",");
        List<RentAreaEntity> rentAreaEntityList = new ArrayList<>();

        for(String val : rentAreas) rentAreaEntityList.add(toRentAreaEntity(Long.valueOf(val.trim()), buildingEntity));
        return rentAreaEntityList;
    }
}
