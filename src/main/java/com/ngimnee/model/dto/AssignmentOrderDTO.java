package com.ngimnee.model.dto;

import java.util.List;

public class AssignmentOrderDTO extends OrderDTO {
    private Long orderId;
    private List<Long> staffs;

    public Long getOrderId() {
        return orderId;
    }

    public void setOrderId(Long orderId) {
        this.orderId = orderId;
    }

    public List<Long> getStaffs() {
        return staffs;
    }

    public void setStaffs(List<Long> staffs) {
        this.staffs = staffs;
    }
}
