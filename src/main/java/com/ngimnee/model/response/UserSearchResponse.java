package com.ngimnee.model.response;

import com.ngimnee.enums.Gender;
import com.ngimnee.model.dto.AbstractDTO;
import lombok.Data;

import java.util.Date;
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
    private Date birthday;
    private Integer gender;

    public String getGenderName() {
        Gender g = Gender.fromCode(gender);
        return g != null ? g.getLabel() : "";
    }
}
