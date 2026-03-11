package com.ngimnee.model.dto;

import lombok.Data;

import java.util.List;

@Data
public class CustomerDTO extends AbstractDTO{
    private String fullName;
    private String managementStaff;
    private String customerPhone;
    private String email;
    private String demand;
    private String status;
    private String companyName;
    private Integer isActive;
    private List<Long> orderIds;
    private List<String> orderCodes;
}
