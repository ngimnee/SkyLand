package com.ngimnee.repository;

import com.ngimnee.entity.UserEntity;
import com.ngimnee.repository.custom.UserRepositoryCustom;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity, Long> , UserRepositoryCustom {
    UserEntity findOneByUserNameAndIsActive(String name, int isActive);
    List<UserEntity> findByIsActiveAndRole_Code(Integer isActive, String roleCode);
    UserEntity findOneByUserName(String userName);
    List<UserEntity> findByRole_CodeIn(List<String> roleCodes);
    List<UserEntity> findByIdIn(List<Long> id);
}
