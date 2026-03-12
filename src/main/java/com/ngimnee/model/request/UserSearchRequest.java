package com.ngimnee.model.request;

import com.ngimnee.model.dto.AbstractDTO;
import lombok.Data;

import java.util.List;

@Data
public class UserSearchRequest extends AbstractDTO {
    private String userName;
    private String fullName;
    private String email;
    private String phone;
    private Integer status;
    private List<String> roleCode;
    private List<Long> roleId;
    private Integer isActive;
}
