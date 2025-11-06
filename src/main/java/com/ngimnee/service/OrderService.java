package com.ngimnee.service;

import com.ngimnee.model.dto.AssignmentOrderDTO;
import com.ngimnee.model.dto.OrderDTO;
import com.ngimnee.model.request.OrderSearchRequest;
import com.ngimnee.model.response.OrderSearchResponse;
import com.ngimnee.model.response.ResponseDTO;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface OrderService {
    List<OrderSearchResponse> findOrders(OrderSearchRequest orderSearchRequest, Pageable pageable);
    OrderDTO findById(Long id);
    OrderDTO updateOrder(OrderDTO orderDTO);
    ResponseDTO listStaffs(Long orderId);
    AssignmentOrderDTO addAssignmentOrder(AssignmentOrderDTO assignmentOrderDTO);
    int countTotalItem(List<OrderSearchResponse> list);
    void deleteOrdersById(Long id);
}
