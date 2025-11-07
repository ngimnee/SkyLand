package com.ngimnee.repository;

import com.ngimnee.entity.TransactionEntity;
import com.ngimnee.repository.custom.TransactionRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface TransactionRepository extends JpaRepository<TransactionEntity, Long>, TransactionRepositoryCustom {
    List<TransactionEntity> findByCodeAndCustomerId(String code, Long customerId);
    void deleteById(Long id);
}
