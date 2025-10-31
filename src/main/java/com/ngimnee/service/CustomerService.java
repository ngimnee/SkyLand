package com.ngimnee.service;

import com.ngimnee.model.dto.AssignmentCustomerDTO;
import com.ngimnee.model.dto.CustomerDTO;
import com.ngimnee.model.request.CustomerSearchRequest;
import com.ngimnee.model.response.CustomerSearchResponse;
import com.ngimnee.model.response.ResponseDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface CustomerService {
    ResponseDTO listStaffs(Long customerId);
    List<CustomerSearchResponse> findCustomers(CustomerSearchRequest customerSearchRequest, Pageable pageable);
    AssignmentCustomerDTO addAssignment(AssignmentCustomerDTO assignmentCustomerDTO);
    int countTotalItem(List<CustomerSearchResponse> list);
    CustomerDTO findById(Long id);

}
