package com.ngimnee.repository.custom;

import com.ngimnee.builder.CustomerSearchBuilder;
import com.ngimnee.entity.CustomerEntity;
import com.ngimnee.model.dto.CustomerDTO;
import com.ngimnee.model.response.CustomerSearchResponse;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface CustomerRepositoryCustom {
    List<CustomerEntity> findCustomers(CustomerSearchBuilder customerSearchBuilder, Pageable pageable);
    int countTotalItem(CustomerSearchResponse customerSearchResponse);
}
