package com.ngimnee.converter;

import com.ngimnee.builder.CustomerSearchBuilder;
import com.ngimnee.model.request.CustomerSearchRequest;
import com.ngimnee.utils.SearchRequestUtil;
import org.springframework.stereotype.Component;

@Component
public class CustomerSearchBuilderConverter {
    public CustomerSearchBuilder toCustomerSearchBuilder(CustomerSearchRequest customerSearchRequest) {
        CustomerSearchBuilder customerSearchBuilder = new CustomerSearchBuilder.Builder()
                .setFullName(SearchRequestUtil.getObject(customerSearchRequest.getFullName(), String.class))
                .setPhone(SearchRequestUtil.getObject(customerSearchRequest.getPhone(), String.class))
                .setEmail(SearchRequestUtil.getObject(customerSearchRequest.getEmail(), String.class))
                .setCompanyName(SearchRequestUtil.getObject(customerSearchRequest.getCompanyName(), String.class))
                .setIsActive(SearchRequestUtil.getObject(customerSearchRequest.getIsActive(), Integer.class))
                .build();

        return customerSearchBuilder;
    }
}
