package com.ngimnee.repository;

import com.ngimnee.entity.BuildingEntity;
import com.ngimnee.repository.custom.BuildingRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface BuildingRepository extends JpaRepository<BuildingEntity, Long>, BuildingRepositoryCustom {
    void deleteById(Long id);
    void deleteByIdIn(Long[] id);
}
