package com.ngimnee.api.admin;

import com.ngimnee.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/customer")
@Transactional
public class CustomerAPI {
    @Autowired
    private CustomerService customerService;
}
