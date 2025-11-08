package com.ngimnee.converter;

import com.ngimnee.entity.RoleEntity;
import com.ngimnee.model.dto.UserDTO;
import com.ngimnee.entity.UserEntity;
import com.ngimnee.model.response.UserSearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.List;
import java.util.stream.Collectors;

@Component
public class UserConverter {
    @Autowired
    private ModelMapper modelMapper;

    public UserDTO convertToDTO(UserEntity entity){
        UserDTO result = modelMapper.map(entity, UserDTO.class);

        // Nếu user có role, gán roleName để hiển thị
        List<RoleEntity> roles = entity.getRoles();
        if (roles != null && !roles.isEmpty()) {
            result.setRoleName(roles.get(0).getName());
        }
        return result;
    }

    public UserEntity toEntity(UserDTO userDTO){
        UserEntity result = modelMapper.map(userDTO, UserEntity.class);
        return result;
    }

    public UserSearchResponse toUserSearchResponse(UserEntity userEntity) {
        UserSearchResponse res = modelMapper.map(userEntity, UserSearchResponse.class);
        return res;
    }

    public void updateEntityFromDTO(UserDTO userDTO, UserEntity userEntity) {
        modelMapper.getConfiguration().setPropertyCondition(context -> true);
        modelMapper.map(userDTO, userEntity);
    }

    public List<UserDTO> toDTOList(List<UserEntity> entities) {
        return entities.stream().map(this::convertToDTO)
                .collect(Collectors.toList());
    }
}
