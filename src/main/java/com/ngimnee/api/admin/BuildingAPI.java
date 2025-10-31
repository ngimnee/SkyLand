package com.ngimnee.api.admin;

import com.ngimnee.model.dto.AssignmentBuildingDTO;
import com.ngimnee.model.dto.BuildingDTO;
import com.ngimnee.model.request.BuildingSearchRequest;
import com.ngimnee.model.response.BuildingSearchResponse;
import com.ngimnee.model.response.ResponseDTO;
import com.ngimnee.service.BuildingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/building")
@Transactional
public class BuildingAPI {
    @Autowired
    private BuildingService buildingService;

    @GetMapping
    public List<BuildingSearchResponse> getBuildings(@ModelAttribute BuildingSearchRequest buildingSearchRequest, Pageable pageable) {
        List<BuildingSearchResponse> res = buildingService.findBuilding(buildingSearchRequest, pageable);
        return res;
    }

    @PostMapping
    public ResponseEntity<BuildingDTO> addOrUpdateBuilding(@RequestBody BuildingDTO buildingDTO) {
        return ResponseEntity.ok(buildingService.addOrUpdateBuilding(buildingDTO));
    }

    @DeleteMapping("/{ids}")
    public ResponseEntity<BuildingDTO> deleteBuilding(@PathVariable Long[] ids) {
        return ResponseEntity.ok(buildingService.deleteBuildings(ids));
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaffs(@PathVariable Long id){
        ResponseDTO result = buildingService.listStaff(id);
        return result;
    }

    @PutMapping
    public ResponseEntity<AssignmentBuildingDTO> updateAssignmentBuilding(@RequestBody AssignmentBuildingDTO assignmentBuildingDTO){
        return ResponseEntity.ok(buildingService.addAssignmentBuildingEntity(assignmentBuildingDTO));
    }
}
