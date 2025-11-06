package com.ngimnee.service.impl;

import com.ngimnee.builder.OrderSearchBuilder;
import com.ngimnee.converter.OrderConverter;
import com.ngimnee.converter.OrderSearchBuilderConverter;
import com.ngimnee.entity.BuildingEntity;
import com.ngimnee.entity.OrderEntity;
import com.ngimnee.entity.UserEntity;
import com.ngimnee.model.dto.AssignmentOrderDTO;
import com.ngimnee.model.dto.OrderDTO;
import com.ngimnee.model.request.OrderSearchRequest;
import com.ngimnee.model.response.OrderSearchResponse;
import com.ngimnee.model.response.ResponseDTO;
import com.ngimnee.model.response.StaffResponseDTO;
import com.ngimnee.repository.BuildingRepository;
import com.ngimnee.repository.OrderRepository;
import com.ngimnee.repository.UserRepository;
import com.ngimnee.service.OrderService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.security.core.userdetails.User;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Service
public class OrderServiceImpl implements OrderService {
    @Autowired
    private OrderRepository orderRepository;
    @Autowired
    private OrderConverter orderConverter;
    @Autowired
    private OrderSearchBuilderConverter orderSearchBuilderConverter;
    @Autowired
    private ModelMapper modelMapper;
    @Autowired
    private UserRepository userRepository;
    @Autowired
    private BuildingRepository buildingRepository;

    public OrderServiceImpl(OrderRepository orderRepository, OrderConverter orderConverter) {
        this.orderRepository = orderRepository;
        this.orderConverter = orderConverter;
    }

    @Override
    public List<OrderSearchResponse> findOrders(OrderSearchRequest orderSearchRequest, Pageable pageable) {
        OrderSearchBuilder orderSearchBuilder = orderSearchBuilderConverter.toOrderSearchBuilder(orderSearchRequest);

        List<OrderEntity> orderEntities = orderRepository.findOrders(orderSearchBuilder, pageable);
        List<OrderSearchResponse> orderSearchResponses = new ArrayList<>();

        for (OrderEntity orderEntity : orderEntities) {
            OrderSearchResponse orderSearchResponse = orderConverter.toOrderSearchResponse(orderEntity);
            orderSearchResponses.add(orderSearchResponse);
        }
        return orderSearchResponses;
    }

    @Override
    public OrderDTO findById(Long id) {
        OrderEntity orderEntity = orderRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Order not found!"));
        OrderDTO orderDTO = modelMapper.map(orderEntity, OrderDTO.class);
    return orderDTO;
    }

    @Override
    public OrderDTO updateOrder(OrderDTO orderDTO) {
        OrderEntity orderEntity;
        Long id = orderDTO.getId();
        if (id != null) {
            orderEntity = orderRepository.findById(id)
                    .orElseThrow(() -> new NotFoundException("Order not found!"));
            orderConverter.updateEntityFromDTO(orderDTO, orderEntity);
        }
        else {
            orderEntity = orderConverter.toOrderEntity(orderDTO);
        }
        orderRepository.save(orderEntity);
        return orderDTO;
    }

    @Override
    public ResponseDTO listStaffs(Long orderId) {
        OrderEntity orderEntity = orderRepository.findById(orderId).get();
        List<UserEntity> allStaffs = userRepository.findByStatusAndRoles_Code(1, "STAFF");
        List<UserEntity> assignedStaffs = orderEntity.getUsers();
        List<StaffResponseDTO> staffs = new ArrayList<>();

        for(UserEntity user : allStaffs) {
            StaffResponseDTO staff = new StaffResponseDTO();
            staff.setStaffId(user.getId());
            staff.setFullName(user.getFullName());
            // Chỉ "checked" nếu nhân viên có trong danh sách quản lý
            if(assignedStaffs.contains(user)) {
                staff.setChecked("checked");
            } else {
                staff.setChecked("");
            }
            staffs.add(staff);
        }
        ResponseDTO responseDTO = new ResponseDTO();
        responseDTO.setData(staffs);
        responseDTO.setMessage("success");
        return responseDTO;
    }

    @Override
    public AssignmentOrderDTO addAssignmentOrder(AssignmentOrderDTO assignmentOrderDTO) {
        Long orderId = assignmentOrderDTO.getOrderId();
        OrderEntity orderEntity =  orderRepository.findById(orderId).get();
        List<UserEntity> users = userRepository.findByIdIn(assignmentOrderDTO.getStaffs());
        orderEntity.setUsers(users);
        orderRepository.save(orderEntity);
        return assignmentOrderDTO;
    }

    @Override
    public int countTotalItem(List<OrderSearchResponse> list) {
        int res = 0;
        for (OrderSearchResponse it : list) res += orderRepository.countTotalItem(it);
        return res;
    }

    @Override
    public void deleteOrdersById(Long id) {
        OrderEntity orderEntity =  orderRepository.findById(id)
                .orElseThrow(() -> new NotFoundException("Order not found!"));
        orderRepository.delete(orderEntity);
    }
}
