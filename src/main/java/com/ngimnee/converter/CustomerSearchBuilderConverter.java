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
                .setDemand(SearchRequestUtil.getObject(customerSearchRequest.getDemand(), String.class))
                .setStatus(SearchRequestUtil.getObject(customerSearchRequest.getStatus(), String.class))
                .setIsActive(SearchRequestUtil.getObject(customerSearchRequest.getIsActive(), Integer.class))
                .setStaffId(SearchRequestUtil.getObject(customerSearchRequest.getStaffId(), Long.class))
                .build();

        return customerSearchBuilder;
    }
}
