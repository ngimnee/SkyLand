package com.ngimnee.service;

import com.ngimnee.model.dto.PasswordDTO;
import com.ngimnee.model.dto.UserDTO;
import com.ngimnee.exception.MyException;
import com.ngimnee.model.request.UserSearchRequest;
import com.ngimnee.model.response.UserSearchResponse;
import org.springframework.data.domain.Pageable;

import java.util.List;
import java.util.Map;

public interface UserService {
    UserDTO findOneByUserNameAndStatus(String name, int status);
    List<UserSearchResponse> getUsers(UserSearchRequest userSearchRequest, Pageable pageable);
    UserDTO findOneByUserName(String userName);
    UserDTO findUserById(long id);
    List<UserDTO> findUsersByRole();
    void addOrUpdateUser(UserDTO userDTO);
    void updateRoleUser(UserDTO userDTO);
    void updatePassword(long id, PasswordDTO userDTO) throws MyException;
    UserDTO resetPassword(long id);
    UserDTO updateProfileOfUser(String id, UserDTO userDTO);
    void deleteUser(Long[] ids);
    int countTotalItems();
    Map<Long, String> getStaffs();
}
