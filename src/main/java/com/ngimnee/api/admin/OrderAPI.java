package com.ngimnee.api.admin;

import com.ngimnee.entity.OrderEntity;
import com.ngimnee.model.request.CustomerSearchRequest;
import com.ngimnee.model.request.OrderSearchRequest;
import com.ngimnee.model.response.CustomerSearchResponse;
import com.ngimnee.model.response.OrderSearchResponse;
import com.ngimnee.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/api/order")
public class OrderAPI {
    @Autowired
    private OrderService orderService;

    @GetMapping
    public List<OrderSearchResponse> getBuildings(@ModelAttribute OrderSearchRequest orderSearchRequest, Pageable pageable) {
        List<OrderSearchResponse> res = orderService.findOrders(orderSearchRequest, pageable);
        return res;
    }
}
