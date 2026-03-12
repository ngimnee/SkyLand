package com.ngimnee.model.dto;

import lombok.Data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Data
public class UserDTO extends AbstractDTO {
    private String userName;
    private String password;
    private String fullName;
    protected String phone;
    private String email;
    private String roleCode;
    private String roleName;
    private List<Long> orderIds;
    private List<String> orderCodes;
    private Map<String,String> roleDTOs = new HashMap<>();
    private Integer isActive;
}