package com.ngimnee.model.dto;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;

@Data
public class OrderDTO extends AbstractDTO<OrderDTO> {
    private String code;
    private String amount;
    private String note;
    private String paymentMethod;
    private String name;
    private String phone;
    private String email;
    private String address;
    private String status;
    private Long customerId;
    private List<Long> buildingIds = new ArrayList<>();
    private List<Long> staffIds = new ArrayList<>();
    private Integer isActive;
}
