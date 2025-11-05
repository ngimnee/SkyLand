package com.ngimnee.converter;

import com.ngimnee.builder.OrderSearchBuilder;
import com.ngimnee.model.request.OrderSearchRequest;
import com.ngimnee.utils.SearchRequestUtil;
import org.springframework.stereotype.Component;

@Component
public class OrderSearchBuilderConverter {
    public OrderSearchBuilder toOrderSearchBuilder(OrderSearchRequest orderSearchRequest) {
        OrderSearchBuilder orderSearchBuilder = new OrderSearchBuilder.Builder()
                .setCode(SearchRequestUtil.getObject(orderSearchRequest.getCode(), String.class))
                .setCustomerId(SearchRequestUtil.getObject(orderSearchRequest.getCustomerId(), Long.class))
                .setName(SearchRequestUtil.getObject(orderSearchRequest.getName(), String.class))
                .setPhone(SearchRequestUtil.getObject(orderSearchRequest.getPhone(), String.class))
                .setEmail(SearchRequestUtil.getObject(orderSearchRequest.getEmail(), String.class))
                .setAddress(SearchRequestUtil.getObject(orderSearchRequest.getAddress(), String.class))
                .setStatus(SearchRequestUtil.getObject(orderSearchRequest.getStatus(), String.class))
                .build();

        return orderSearchBuilder;
    }
}
