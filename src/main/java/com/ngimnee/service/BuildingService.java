package com.ngimnee.service;

import com.ngimnee.model.dto.AssignmentBuildingDTO;
import com.ngimnee.model.dto.BuildingDTO;
import com.ngimnee.model.request.BuildingSearchRequest;
import com.ngimnee.model.response.BuildingSearchResponse;
import com.ngimnee.model.response.ResponseDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface BuildingService {
    ResponseDTO listStaff(Long buildingId);
    List<BuildingSearchResponse> findBuilding (BuildingSearchRequest buildingSearchRequest,  Pageable pageable);
    BuildingDTO deleteBuildings(Long[] ids);
    BuildingDTO addOrUpdateBuilding(BuildingDTO buildingDTO);
    BuildingDTO findById(Long id);
    int countTotalItem(List<BuildingSearchResponse> list);
    AssignmentBuildingDTO addAssignmentBuildingEntity(AssignmentBuildingDTO assignmentBuildingDTO);
}
