package com.ngimnee.repository.custom;

import com.ngimnee.builder.OrderSearchBuilder;
import com.ngimnee.entity.OrderEntity;
import com.ngimnee.model.response.OrderSearchResponse;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface OrderRepositoryCustom {
    List<OrderEntity> findOrders(OrderSearchBuilder orderSearchBuilder, Pageable pageable);
    int countTotalItem(OrderSearchResponse orderSearchResponse);
}
