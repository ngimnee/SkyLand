package com.ngimnee.service.impl;

import com.ngimnee.builder.CustomerSearchBuilder;
import com.ngimnee.converter.CustomerConverter;
import com.ngimnee.converter.CustomerSearchBuilderConverter;
import com.ngimnee.entity.CustomerEntity;
import com.ngimnee.entity.UserEntity;
import com.ngimnee.model.dto.AssignmentCustomerDTO;
import com.ngimnee.model.dto.CustomerDTO;
import com.ngimnee.model.request.CustomerSearchRequest;
import com.ngimnee.model.response.CustomerSearchResponse;
import com.ngimnee.model.response.ResponseDTO;
import com.ngimnee.model.response.StaffResponseDTO;
import com.ngimnee.repository.CustomerRepository;
import com.ngimnee.repository.UserRepository;
import com.ngimnee.service.CustomerService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
public class CustomerServiceImpl implements CustomerService {
    @Autowired
    private ModelMapper modelMapper;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private CustomerRepository customerRepository;
    @Autowired
    private CustomerSearchBuilderConverter customerSearchBuilderConverter;
    @Autowired
    private CustomerConverter customerConverter;


    @Override
    public ResponseDTO listStaffs(Long customerId) {
        CustomerEntity customerEntity = customerRepository.findById(customerId).get();
        List<UserEntity> staffs = userRepository.findByStatusAndRoles_Code(1, "STAFF");
        List<UserEntity> staffAssignment = customerEntity.getUsers();

        List<StaffResponseDTO>  staffResponseDTOS = new ArrayList<>();
        ResponseDTO responseDTO = new ResponseDTO();
        for (UserEntity user : staffs) {
            StaffResponseDTO staffResponseDTO = new StaffResponseDTO();
            staffResponseDTO.setStaffId(user.getId());
            staffResponseDTO.setFullName(user.getFullName());

            if(staffAssignment.contains(user)){
                staffResponseDTO.setChecked("checked");
            }
            else {
                staffResponseDTO.setChecked("");
            }
            staffResponseDTOS.add(staffResponseDTO);
        }
        responseDTO.setData(staffResponseDTOS);
        responseDTO.setMessage("success");
        return responseDTO;
    }

    @Override
    public List<CustomerSearchResponse> findCustomers(CustomerSearchRequest customerSearchRequest, Pageable pageable) {
        CustomerSearchBuilder customers  = customerSearchBuilderConverter.toCustomerSearchBuilder(customerSearchRequest);

        List<CustomerEntity> customerEntities = customerRepository.findCustomers(customers, pageable);
        List<CustomerSearchResponse> customerResponses = new ArrayList<>();

        for(CustomerEntity customerEntity : customerEntities){
            CustomerSearchResponse customerSearchResponse = customerConverter.toCustomerSearchResponse(customerEntity);
            customerResponses.add(customerSearchResponse);
        }
        return customerResponses;
    }

    @Override
    public AssignmentCustomerDTO addAssignment(AssignmentCustomerDTO assignmentCustomerDTO) {
        return null;
    }

    @Override
    public int countTotalItem(List<CustomerSearchResponse> list) {
        int res = 0;
        for (CustomerSearchResponse it : list) {
            res += customerRepository.countTotalItem(it);
        }
        return res;
    }

    @Override
    public CustomerDTO findById(Long id) {
        return null;
    }
}
