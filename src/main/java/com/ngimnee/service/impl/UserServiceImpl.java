package com.ngimnee.service.impl;

import com.ngimnee.builder.UserSearchBuilder;
import com.ngimnee.constant.SystemConstant;
import com.ngimnee.converter.UserConverter;
import com.ngimnee.converter.UserSearchBuilderConverter;
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
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.stream.Collectors;
import java.util.stream.Stream;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private RoleRepository roleRepository;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private UserConverter userConverter;
    @Autowired
    private UserSearchBuilderConverter userSearchBuilderConverter;

    @Override
    public UserDTO findOneByUserNameAndStatus(String name, int status) {
        return userConverter.convertToDTO(userRepository.findOneByUserNameAndStatus(name, status));
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
    public List<UserDTO> getAllUsers(Pageable pageable) {
        List<UserEntity> userEntities = userRepository.getAllUsers(pageable);
        List<UserDTO> results = new ArrayList<>();
        for (UserEntity userEntity : userEntities) {
            UserDTO userDTO = userConverter.convertToDTO(userEntity);
            userDTO.setRoleCode(userEntity.getRoles().get(0).getCode());
            results.add(userDTO);
        }
        return results;
    }

    @Override
    public int countTotalItems() {
        return userRepository.countTotalItem();
    }

    @Override
    public Map<Long, String> getStaffs() {
        Map<Long, String> listStaffs = new HashMap<>();
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1, "STAFF");
        for (UserEntity it : staffs) {
            listStaffs.put(it.getId(), it.getFullName());
        }
        return listStaffs;
    }


    @Override
    public int getTotalItems(String searchValue) {
        int totalItem = 0;
        if (StringUtils.isNotBlank(searchValue)) {
            totalItem = (int) userRepository.countByUserNameContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndStatusNot(searchValue, searchValue, 0);
        } else {
            totalItem = (int) userRepository.countByStatusNot(0);
        }
        return totalItem;
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
        List<RoleEntity> roles = entity.getRoles();
        UserDTO dto = userConverter.convertToDTO(entity);
        roles.forEach(item -> {
            dto.setRoleCode(item.getCode());
        });
        return dto;
    }

    @Override
    @Transactional
    public UserDTO createUser(UserDTO newUser) {
        UserEntity userEntity =userConverter.convertToEntity(newUser);

        RoleEntity role = roleRepository.findOneByCode(newUser.getRoleCode());
        if (role == null) {
            throw new RuntimeException("Invalid role code: " + newUser.getRoleCode());
        }

        userEntity.setRoles(Collections.singletonList(role));
        userEntity.setStatus(1);
        userEntity.setPassword(passwordEncoder.encode(SystemConstant.PASSWORD_DEFAULT));

        return userConverter.convertToDTO(userRepository.save(userEntity));
    }


    @Override
    @Transactional
    public UserDTO updateUser(Long id, UserDTO updateUser) {
        // 1️⃣ Tìm user cũ
        UserEntity oldUser = userRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("User not found with id = " + id));

        // 2️⃣ Map các field không null từ DTO sang Entity (sử dụng ModelMapper)
        userConverter.convertToEntity(updateUser);

        // 3️⃣ Giữ nguyên các giá trị quan trọng
        oldUser.setUserName(oldUser.getUserName());
        oldUser.setPassword(oldUser.getPassword());

        // 4️⃣ Cập nhật vai trò nếu có
        if (updateUser.getRoleCode() != null) {
            RoleEntity role = roleRepository.findOneByCode(updateUser.getRoleCode());
            if (role == null) {
                throw new RuntimeException("Invalid role code: " + updateUser.getRoleCode());
            }
            oldUser.setRoles(Collections.singletonList(role));
        }

        // 5️⃣ Lưu lại và trả về DTO
        UserEntity savedUser = userRepository.save(oldUser);
        return userConverter.convertToDTO(savedUser);
    }



    @Override
    @Transactional
    public void updatePassword(long id, PasswordDTO passwordDTO) throws MyException {
        UserEntity user = userRepository.findById(id).get();
        if (passwordEncoder.matches(passwordDTO.getOldPassword(), user.getPassword())
                && passwordDTO.getNewPassword().equals(passwordDTO.getConfirmPassword())) {
            user.setPassword(passwordEncoder.encode(passwordDTO.getNewPassword()));
            userRepository.save(user);
        } else {
            throw new MyException(SystemConstant.CHANGE_PASSWORD_FAIL);
        }
    }

    @Override
    @Transactional
    public UserDTO resetPassword(long id) {
        UserEntity userEntity = userRepository.findById(id).get();
        userEntity.setPassword(passwordEncoder.encode(SystemConstant.PASSWORD_DEFAULT));
        return userConverter.convertToDTO(userRepository.save(userEntity));
    }

    @Override
    @Transactional
    public UserDTO updateProfileOfUser(String username, UserDTO updateUser) {
        UserEntity oldUser = userRepository.findOneByUserName(username);
        oldUser.setFullName(updateUser.getFullName());
        return userConverter.convertToDTO(userRepository.save(oldUser));
    }

    @Override
    @Transactional
    public void deleteUser(Long[] ids) {
        List<UserEntity> users = userRepository.findAllById(Arrays.asList(ids));
        for (UserEntity user : users) {
            user.setStatus(0);
        }
        userRepository.saveAll(users);
        for (Long item : ids) {
            UserEntity userEntity = userRepository.findById(item).get();
            userEntity.setStatus(0);
            userRepository.save(userEntity);
        }
    }



//    @Override
//    public List<UserDTO> getUsers(String searchValue, Pageable pageable) {
//        Page<UserEntity> users = null;
//        if (StringUtils.isNotBlank(searchValue)) {
//            users = userRepository.findByUserNameContainingIgnoreCaseOrFullNameContainingIgnoreCaseAndStatusNot(searchValue, searchValue, 0, pageable);
//        } else {
//            users = userRepository.findByStatusNot(0, pageable);
//        }
//        List<UserEntity> newsEntities = users.getContent();
//        List<UserDTO> result = new ArrayList<>();
//        for (UserEntity userEntity : newsEntities) {
//            UserDTO userDTO = userConverter.convertToDTO(userEntity);
//            userDTO.setRoleCode(userEntity.getRoles().get(0).getCode());
//            result.add(userDTO);
//        }
//        return result;
//    }
}
