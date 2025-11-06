package com.ngimnee.api.admin;

import com.ngimnee.entity.OrderEntity;
import com.ngimnee.model.dto.AssignmentOrderDTO;
import com.ngimnee.model.dto.OrderDTO;
import com.ngimnee.model.request.CustomerSearchRequest;
import com.ngimnee.model.request.OrderSearchRequest;
import com.ngimnee.model.response.OrderSearchResponse;
import com.ngimnee.model.response.ResponseDTO;
import com.ngimnee.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

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

    @GetMapping("/{id}/staffs")
    public ResponseDTO loadStaffs(@PathVariable Long id) {
        ResponseDTO res = orderService.listStaffs(id);
        return res;
    }

    @PutMapping
    public ResponseEntity<AssignmentOrderDTO> addAssignmentOrder(@RequestBody AssignmentOrderDTO assignmentOrderDTO){
        return ResponseEntity.ok(orderService.addAssignmentOrder(assignmentOrderDTO));
    }

    @PostMapping
    public ResponseEntity<OrderDTO> updateOrder(@RequestBody OrderDTO orderDTO) {
        return ResponseEntity.ok(orderService.updateOrder(orderDTO));
    }

    @DeleteMapping("/{id}")
    public void deleteOrders(@PathVariable Long id) {
        orderService.deleteOrdersById(id);
    }
}
