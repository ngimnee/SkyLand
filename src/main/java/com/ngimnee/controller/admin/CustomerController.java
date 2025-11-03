package com.ngimnee.controller.admin;

import com.ngimnee.model.dto.CustomerDTO;
import com.ngimnee.model.request.CustomerSearchRequest;
import com.ngimnee.model.response.CustomerSearchResponse;
import com.ngimnee.security.utils.SecurityUtils;
import com.ngimnee.service.CustomerService;
import com.ngimnee.service.UserService;
import com.ngimnee.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class CustomerController {
    @Autowired
    private UserService userService;
    @Autowired
    private CustomerService customerService;

    @GetMapping("/admin/customer")
    public ModelAndView customerPage(@ModelAttribute CustomerSearchRequest customerSearchRequest,
                                     HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/list");
        mav.addObject("customerSearch", customerSearchRequest);

        mav.addObject("listStaff", userService.getStaffs());


        // Nếu là staff thì giới hạn dữ liệu theo ID
        if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")) {
            customerSearchRequest.setStaffId(SecurityUtils.getPrincipal().getId());
        }

        CustomerSearchResponse model = new CustomerSearchResponse();
        DisplayTagUtils.of(request, model);

        List<CustomerSearchResponse> resultList = customerService.findCustomers(customerSearchRequest,
                PageRequest.of(customerSearchRequest.getPage() - 1, customerSearchRequest.getMaxPageItems()));

        model.setListResult(resultList);
        model.setTotalItems(customerService.countTotalItem(resultList));

        mav.addObject("customerList", model);
        return mav;
    }

    @GetMapping("/admin/customer/edit/{id}")
    public ModelAndView editCustomer(@PathVariable("id") Long id,
                                     HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/edit");
        CustomerDTO customerDTO = customerService.findById(id);
        mav.addObject("editCustomer", customerDTO);
        mav.addObject("listStaffs", userService.getStaffs());
        return mav;
    }
}
