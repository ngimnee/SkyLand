package com.ngimnee.repository;

import com.ngimnee.entity.OrderEntity;
import com.ngimnee.repository.custom.OrderRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface OrderRepository extends JpaRepository<OrderEntity, Long>, OrderRepositoryCustom {
    void deleteById(Long id);
}
