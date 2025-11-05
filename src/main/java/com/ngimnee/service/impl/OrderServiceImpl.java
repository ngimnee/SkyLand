package com.ngimnee.service.impl;

import com.ngimnee.builder.OrderSearchBuilder;
import com.ngimnee.converter.OrderConverter;
import com.ngimnee.converter.OrderSearchBuilderConverter;
import com.ngimnee.entity.OrderEntity;
import com.ngimnee.model.dto.OrderDTO;
import com.ngimnee.model.request.OrderSearchRequest;
import com.ngimnee.model.response.OrderSearchResponse;
import com.ngimnee.model.response.ResponseDTO;
import com.ngimnee.repository.OrderRepository;
import com.ngimnee.service.OrderService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

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
    public OrderDTO addOrUpdateOrder(OrderDTO orderDTO) {
        OrderEntity orderEntity;
        Long id = orderDTO.getId();
        if (id == null) {
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
        return null;
    }

    @Override
    public int countTotalItem(List<OrderSearchResponse> list) {
        return 0;
    }
}
