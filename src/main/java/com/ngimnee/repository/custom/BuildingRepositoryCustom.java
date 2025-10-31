package com.ngimnee.repository.custom;

import com.ngimnee.builder.BuildingSearchBuilder;
import com.ngimnee.entity.BuildingEntity;
import com.ngimnee.model.response.BuildingSearchResponse;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface BuildingRepositoryCustom {
    List<BuildingEntity> findBuilding(BuildingSearchBuilder buildingSearchBuilder,  Pageable pageable);
    int countTotalItem(BuildingSearchResponse buildingSearchResponse);
}
