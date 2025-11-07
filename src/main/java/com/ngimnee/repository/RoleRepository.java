package com.ngimnee.repository;

import com.ngimnee.entity.RoleEntity;
import com.ngimnee.repository.custom.RoleRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface RoleRepository extends JpaRepository<RoleEntity,Long>, RoleRepositoryCustom {
    RoleEntity findOneByCode(String code);
    List<RoleEntity> findAll();
}
