package com.ngimnee.service.impl;

import com.ngimnee.builder.UserSearchBuilder;
import com.ngimnee.config.PasswordConfig;
import com.ngimnee.constant.SystemConstant;
import com.ngimnee.converter.user.UserConverter;
import com.ngimnee.converter.user.UserSearchBuilderConverter;
import com.ngimnee.model.dto.PasswordDTO;
import com.ngimnee.model.dto.UserDTO;
import com.ngimnee.entity.RoleEntity;
import com.ngimnee.entity.UserEntity;
import com.ngimnee.exception.MyException;
import com.ngimnee.model.request.UserSearchRequest;
import com.ngimnee.model.response.UserSearchResponse;
import com.ngimnee.repository.RoleRepository;
import com.ngimnee.repository.UserRepository;
import com.ngimnee.security.utils.SecurityUtils;
import com.ngimnee.service.UserService;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private PasswordConfig passwordConfig;
    @Autowired
    private UserConverter userConverter;
    @Autowired
    private UserSearchBuilderConverter userSearchBuilderConverter;

    @Override
    public UserDTO findOneByUserNameAndIsActive(String name, int isActive) {
        return userConverter.convertToDTO(userRepository.findOneByUserNameAndIsActive(name, isActive));
    }

    @Override
    public List<UserSearchResponse> getUsers(UserSearchRequest userSearchRequest, Pageable pageable) {
        UserSearchBuilder userSearchBuilder = userSearchBuilderConverter.toUserSearchBuilder(userSearchRequest);
        List<UserEntity> userEntities = userRepository.findUsers(userSearchBuilder, pageable);
        List<UserSearchResponse> userResponses = new ArrayList<>();

        for (UserEntity userEntity : userEntities) {
            UserSearchResponse userSearchResponse = userConverter.toUserSearchResponse(userEntity);
            userResponses.add(userSearchResponse);
        }
        return userResponses;
    }

    @Override
    public int countTotalItems() {
        return userRepository.countTotalItem();
    }

    @Override
    public Map<Long, String> getStaffs() {
        Map<Long, String> listStaffs = new HashMap<>();
        List<UserEntity> staffs = userRepository.findByIsActiveAndRole_Code(1, "STAFF");
        for (UserEntity it : staffs) {
            listStaffs.put(it.getId(), it.getFullName());
        }
        return listStaffs;
    }

    @Override
    public UserDTO findOneByUserName(String userName) {
        UserEntity userEntity = userRepository.findOneByUserName(userName);
        UserDTO userDTO = userConverter.convertToDTO(userEntity);
        return userDTO;
    }

    @Override
    public UserDTO findUserById(long id) {
        UserEntity entity = userRepository.findById(id).get();
        UserDTO dto = userConverter.convertToDTO(entity);
        if(entity.getRole() != null){
            dto.setRoleCode(entity.getRole().getCode());
        }
        return dto;
    }

    @Override
    public List<UserDTO> findUsersByRole() {
        List<String> roles = List.of("STAFF", "MANAGER");
        List<UserEntity> entities = userRepository.findByRole_CodeIn(roles);
        return userConverter.toDTOList(entities);
    }


    @Override
    public void addOrUpdateUser(UserDTO userDTO) {
        UserEntity userEntity;
        if (userDTO.getId() != null) {
            userEntity = userRepository.findById(userDTO.getId())
                    .orElseThrow(() -> new NotFoundException("User not found"));

            String username = userEntity.getUserName();
            String password = userEntity.getPassword();

            userConverter.updateEntityFromDTO(userDTO, userEntity);
            userEntity.setUserName(username);
            userEntity.setPassword(password);
        }
        else {
            userEntity = userConverter.toEntity(userDTO);
            userEntity.setPassword(encryptPassword(userDTO.getPassword()));
            userEntity.setIsActive(1);
        }

        RoleEntity userRole = null;
        if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")) {
            userRole = roleRepository.findOneByCode("USER");
        } else {
            if (StringUtils.isNotBlank(userDTO.getRoleCode())) {
                userRole = roleRepository.findOneByCode(userDTO.getRoleCode());
            }
        }
        if (userRole != null) {
            userEntity.setRole(userRole);
        }
        userRepository.save(userEntity);
    }

    @Override
    public void updateRoleUser(UserDTO userDTO) {
        UserEntity userEntity = userRepository.findOneByUserName(userDTO.getUserName());
        if (userEntity == null) {
            throw new NotFoundException("User not found.");
        }

        if (StringUtils.isNotBlank(userDTO.getRoleCode())) {
            RoleEntity role = roleRepository.findOneByCode(userDTO.getRoleCode());
            if (role != null) {
                userEntity.setRole(role);
            }
        }
        userRepository.save(userEntity);
    }

    @Override
    @Transactional
    public void updatePassword(long id, PasswordDTO passwordDTO) throws MyException {
        UserEntity user = userRepository.findById(id)
                .orElseThrow(() -> new MyException("User not found"));

        if (!passwordEncoder.matches(passwordDTO.getOldPassword(), user.getPassword())) {
            throw new MyException(SystemConstant.OLD_PASSWORD_INCORRECT);
        }
        if (!passwordDTO.getNewPassword().equals(passwordDTO.getConfirmPassword())) {
            throw new MyException(SystemConstant.CHANGE_PASSWORD_FAIL);
        }
        if (passwordEncoder.matches(passwordDTO.getNewPassword(), user.getPassword())) {
            throw new MyException(SystemConstant.PASSWORD_SAME_OLD);
        }
        user.setPassword(passwordEncoder.encode(passwordDTO.getNewPassword()));
        userRepository.save(user);
    }

    @Override
    @Transactional
    public UserDTO resetPassword(long id) {
        UserEntity userEntity = userRepository.findById(id).get();
        String defaultPassword = passwordConfig.getPasswordDefault();
        userEntity.setPassword(passwordEncoder.encode(defaultPassword));

        UserDTO userDTO = userConverter.convertToDTO(userRepository.save(userEntity));
        userDTO.setDefaultPassword(defaultPassword);
        return userDTO;
    }

    @Override
    @Transactional
    public UserDTO updateProfileOfUser(String username, UserDTO updateUser) {
        UserEntity oldUser = userRepository.findOneByUserName(username);
        oldUser.setFullName(updateUser.getFullName());
        oldUser.setPhone(updateUser.getPhone());
        oldUser.setEmail(updateUser.getEmail());
        oldUser.setGender(updateUser.getGender());
        oldUser.setBirthday(updateUser.getBirthday());
        return userConverter.convertToDTO(userRepository.save(oldUser));
    }

    @Override
    @Transactional
    public void deleteUser(Long[] ids) {
        List<UserEntity> users = userRepository.findAllById(Arrays.asList(ids));
        for (UserEntity user : users) {
            user.setIsActive(0);
        }
        userRepository.saveAll(users);
        for (Long item : ids) {
            UserEntity userEntity = userRepository.findById(item).get();
            userEntity.setIsActive(0);
            userRepository.save(userEntity);
        }
    }

    public String encryptPassword(String password) {
        if (StringUtils.isNotBlank(password)) {
            return passwordEncoder.encode(password);
        }
        return password;
    }

}
