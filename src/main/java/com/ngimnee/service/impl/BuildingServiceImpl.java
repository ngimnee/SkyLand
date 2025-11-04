package com.ngimnee.service.impl;

import com.ngimnee.builder.BuildingSearchBuilder;
import com.ngimnee.converter.BuildingSearchBuilderConverter;
import com.ngimnee.converter.BuildingConverter;
import com.ngimnee.entity.BuildingEntity;
import com.ngimnee.entity.RentAreaEntity;
import com.ngimnee.entity.UserEntity;
import com.ngimnee.model.dto.AssignmentBuildingDTO;
import com.ngimnee.model.dto.BuildingDTO;
import com.ngimnee.model.request.BuildingSearchRequest;
import com.ngimnee.model.response.BuildingSearchResponse;
import com.ngimnee.model.response.ResponseDTO;
import com.ngimnee.model.response.StaffResponseDTO;
import com.ngimnee.repository.BuildingRepository;
import com.ngimnee.repository.UserRepository;
import com.ngimnee.service.BuildingService;
import com.ngimnee.utils.UploadFileUtils;
import org.apache.tomcat.util.codec.binary.Base64;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class BuildingServiceImpl implements BuildingService {
    @Autowired
    private BuildingConverter buildingConverter;

    @Autowired
    private BuildingSearchBuilderConverter buildingSearchBuilderConverter;

    @Autowired
    private BuildingRepository buildingRepository;

    @Autowired
    private ModelMapper modelMapper;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UploadFileUtils uploadFileUtils;

    @Override
    public ResponseDTO listStaff(Long buildingId) {
        BuildingEntity building = buildingRepository.findById(buildingId).get();
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1, "STAFF");
        List<UserEntity> staffAssignment = building.getUsers();
        List<StaffResponseDTO>  staffResponseDTOS = new ArrayList<>();
        ResponseDTO responseDTO = new ResponseDTO();

        for(UserEntity it : staffs){
            StaffResponseDTO staffResponseDTO = new StaffResponseDTO();
            staffResponseDTO.setFullName(it.getFullName());
            staffResponseDTO.setStaffId(it.getId());
            if(staffAssignment.contains(it)){
                staffResponseDTO.setChecked("checked");
            }
            else {
                staffResponseDTO.setChecked("");
            }
            staffResponseDTOS.add(staffResponseDTO);
        }
        responseDTO.setData(staffResponseDTOS);
        responseDTO.setMessage("success");
        return responseDTO;
    }

    @Override
    public List<BuildingSearchResponse> findBuilding(BuildingSearchRequest buildingSearchRequest, Pageable pageable) {
        List<String> typeCode = buildingSearchRequest.getTypeCode();
        BuildingSearchBuilder buildingSearchBuilder = buildingSearchBuilderConverter.toBuildingSearchBuilder(buildingSearchRequest, typeCode);

        List<BuildingEntity> buildingEntities = buildingRepository.findBuilding(buildingSearchBuilder, pageable);
        List<BuildingSearchResponse> res = new ArrayList<>();

        for(BuildingEntity item : buildingEntities)
        {
            BuildingSearchResponse building = buildingConverter.toBuildingSearchResponse(item);
            res.add(building);
        }

        return res;

    }

    @Override
    public BuildingDTO deleteBuildings(Long[] ids) {
        BuildingEntity buildingEntities = buildingRepository.findById(ids[0]).get();
        buildingRepository.deleteByIdIn(ids);
//        buildingRepository.delete(buildingEntities);
        return buildingConverter.toBuildingDTO(buildingEntities);
    }

    @Override
    public BuildingDTO addOrUpdateBuilding(BuildingDTO buildingDTO) {
        BuildingEntity building;

        if(buildingDTO.getId() != null) {
            building = buildingRepository.findById(buildingDTO.getId())
                    .orElseThrow(() -> new NotFoundException("Building not found!"));

            buildingConverter.updateEntityFromDTO(buildingDTO, building);
        }
        else {
            building = buildingConverter.toEntity(buildingDTO);
        }

        saveThumbnail(buildingDTO, building);
        BuildingEntity result = buildingRepository.save(building);
        return buildingConverter.toBuildingDTO(result);
    }

    private void saveThumbnail(BuildingDTO buildingDTO, BuildingEntity buildingEntity) {
        String path = "/building/" +  buildingDTO.getImageName();

        if (buildingDTO.getImageBase64() != null) {
            if (buildingEntity.getImage() != null) {
                if (!path.equals(buildingEntity.getImage())) {
                    File imageFile = new File(("E://SkyLand/pics" + buildingEntity.getImage()));
                    imageFile.delete();
                }
            }
            byte[] bytes = Base64.decodeBase64(buildingDTO.getImageBase64().getBytes());
            uploadFileUtils.writeOrUpdate(path, bytes);
            buildingEntity.setImage(path);
        }
    }

    @Override
    public BuildingDTO findById(Long id) {
        BuildingEntity buildingEntity = buildingRepository.findById(id)
                    .orElseThrow(() -> new NotFoundException("Building not found!"));
        BuildingDTO res = modelMapper.map(buildingEntity, BuildingDTO.class);

        List<RentAreaEntity> rentAreaEntities = buildingEntity.getRentAreas();
        String rentArea = rentAreaEntities.stream().map(it->it.getValue().toString()).collect(Collectors.joining(","));

        res.setRentArea(rentArea);
        res.setTypeCode(toTypeCodeList(buildingEntity.getTypeCode()));

        return res;
    }

    public List<String> toTypeCodeList(String typeCodes)
    {
        if (typeCodes == null || typeCodes.trim().isEmpty()) {
            return new ArrayList<>(); // hoặc Collections.emptyList();
        }
        String[] arr = typeCodes.trim().split(",");
        return Arrays.asList(arr);
    }

    @Override
    public int countTotalItem(List<BuildingSearchResponse> list) {
        int res = 0;
        for (BuildingSearchResponse it : list) res += buildingRepository.countTotalItem(it);
        return res;
    }

    @Override
    public AssignmentBuildingDTO addAssignmentBuildingEntity(AssignmentBuildingDTO assignmentBuildingDTO) {
         BuildingEntity buildingEntity = buildingRepository.findById(assignmentBuildingDTO.getBuildingId()).get();
         List<UserEntity> users = userRepository.findByIdIn(assignmentBuildingDTO.getStaffs());
         buildingEntity.setUsers(users);
         buildingRepository.save(buildingEntity);
         return assignmentBuildingDTO;
    }
}
