package com.ngimnee.api.admin;

import com.ngimnee.model.dto.AssignmentBuildingDTO;
import com.ngimnee.model.dto.AssignmentCustomerDTO;
import com.ngimnee.model.dto.BuildingDTO;
import com.ngimnee.model.dto.CustomerDTO;
import com.ngimnee.model.request.CustomerSearchRequest;
import com.ngimnee.model.response.CustomerSearchResponse;
import com.ngimnee.model.response.ResponseDTO;
import com.ngimnee.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/customer")
@Transactional
public class CustomerAPI {
    @Autowired
    private CustomerService customerService;

    @GetMapping
    public List<CustomerSearchResponse> getCustomers(@ModelAttribute CustomerSearchRequest customerSearchRequest, Pageable pageable) {
        List<CustomerSearchResponse> res = customerService.findCustomers(customerSearchRequest, pageable);
        return res;
    }

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaffs(@PathVariable Long id){
        ResponseDTO result = customerService.listStaffs(id);
        return result;
    }

    @PutMapping
    public ResponseEntity<AssignmentCustomerDTO> updateAssignmentCustomer(@RequestBody AssignmentCustomerDTO assignmentCustomerDTO){
        return ResponseEntity.ok(customerService.addAssignment(assignmentCustomerDTO));
    }

    @PostMapping
    public ResponseEntity<CustomerDTO> addOrUpdateCustomer(@RequestBody CustomerDTO customerDTO) {
        return ResponseEntity.ok(customerService.addOrUpdateCustomer(customerDTO));
    }

    @DeleteMapping("/{ids}")
    public void deleteBuilding(@PathVariable Long[] ids) {
        customerService.deleteCustomers(ids);
    }
}
