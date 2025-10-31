package com.ngimnee.repository;

import com.ngimnee.entity.CustomerEntity;
import com.ngimnee.repository.custom.CustomerRepositoryCustom;
import org.springframework.data.jpa.repository.JpaRepository;

public interface CustomerRepository extends JpaRepository<CustomerEntity, Long>, CustomerRepositoryCustom {
}
