package com.ngimnee.converter;

import com.ngimnee.entity.CustomerEntity;
import com.ngimnee.model.dto.UserDTO;
import com.ngimnee.entity.UserEntity;
import com.ngimnee.model.response.CustomerSearchResponse;
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
        return result;
    }

    public UserEntity convertToEntity(UserDTO dto){
        UserEntity result = modelMapper.map(dto, UserEntity.class);
        return result;
    }

    public UserSearchResponse toUserSearchResponse(UserEntity userEntity) {
        UserSearchResponse res = modelMapper.map(userEntity, UserSearchResponse.class);
        return res;
    }

    public List<UserSearchResponse> convertToSearchResponse(List<UserDTO> dtoList) {
        modelMapper.getConfiguration().setPropertyCondition(context -> true);

        // Map từng DTO sang Response bằng Stream
        return dtoList.stream()
                .map(userDTO -> modelMapper.map(userDTO, UserSearchResponse.class))
                .collect(Collectors.toList());
    }


//    public List<UserSearchResponse> convertToSearchResponse(List<UserDTO> dto){
//        List<UserSearchResponse> result = new ArrayList<>();
//        for (UserDTO userDTO : dto) {
//            UserSearchResponse userSearchResponse = new UserSearchResponse();
//            modelMapper.getConfiguration().setPropertyCondition(context -> true);
//            modelMapper.map(userDTO, userSearchResponse);
//            result.add(userSearchResponse);
//        }
//        return result;
//    }
}
