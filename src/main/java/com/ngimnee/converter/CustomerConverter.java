package com.ngimnee.converter;

import com.ngimnee.entity.CustomerEntity;
import com.ngimnee.model.dto.CustomerDTO;
import com.ngimnee.model.response.CustomerSearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class CustomerConverter {
    @Autowired
    private ModelMapper modelMapper;

    public CustomerSearchResponse toCustomerSearchResponse(CustomerEntity customerEntity) {
        CustomerSearchResponse res = modelMapper.map(customerEntity, CustomerSearchResponse.class);
        return res;
    }

    public CustomerEntity toCustomerEntity(CustomerDTO customerDTO) {
        CustomerEntity customerEntity = modelMapper.map(customerDTO, CustomerEntity.class);
        return customerEntity;
    }

    public CustomerDTO toCustomerDTO(CustomerEntity customerEntity) {
        CustomerDTO customerDTO = modelMapper.map(customerEntity, CustomerDTO.class);
        return customerDTO;
    }

    public void updateEntityFromDTO(CustomerDTO customerDTO, CustomerEntity entity) {
        modelMapper.getConfiguration().setPropertyCondition(context -> true);
        modelMapper.map(customerDTO, entity);
    }
}
