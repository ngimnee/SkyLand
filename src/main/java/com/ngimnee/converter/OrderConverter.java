package com.ngimnee.converter;

import com.ngimnee.entity.BuildingEntity;
import com.ngimnee.entity.OrderEntity;
import com.ngimnee.model.dto.OrderDTO;
import com.ngimnee.model.response.OrderSearchResponse;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.stream.Collectors;

@Component
public class OrderConverter {
    @Autowired
    private ModelMapper modelMapper;

    public OrderSearchResponse toOrderSearchResponse(OrderEntity orderEntity) {
        OrderSearchResponse res = modelMapper.map(orderEntity, OrderSearchResponse.class);

        if (orderEntity.getBuildings() != null && !orderEntity.getBuildings().isEmpty()) {
            String buildingNames = orderEntity.getBuildings().stream()
                    .map(BuildingEntity::getName)
                    .collect(Collectors.joining(", "));
            res.setBuildingName(buildingNames);
        }
        return res;
    }

    public OrderEntity toOrderEntity(OrderDTO orderDTO) {
        OrderEntity customerEntity = modelMapper.map(orderDTO, OrderEntity.class);
        return customerEntity;
    }

    public OrderDTO toOrderDTO(OrderEntity orderEntity) {
        OrderDTO customerDTO = modelMapper.map(orderEntity, OrderDTO.class);
        return customerDTO;
    }

    public void updateEntityFromDTO(OrderDTO orderDTO, OrderEntity orderEntity) {
        modelMapper.getConfiguration().setPropertyCondition(context -> true);
        modelMapper.map(orderDTO, orderEntity);
    }
}
