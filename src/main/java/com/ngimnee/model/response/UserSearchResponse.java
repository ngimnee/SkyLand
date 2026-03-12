package com.ngimnee.model.response;

import com.ngimnee.model.dto.AbstractDTO;
import lombok.Data;

import java.util.List;

@Data
public class UserSearchResponse extends AbstractDTO {
    private String userName;
    private String fullName;
    private String email;
    private String phone;
    private Integer status;
    private List<String> roleCode;
    private Long roleId;
    private String roleName;
    private Integer isActive;
}
