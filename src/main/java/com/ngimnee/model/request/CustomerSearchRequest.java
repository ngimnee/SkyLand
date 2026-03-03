package com.ngimnee.model.request;

import com.ngimnee.model.dto.AbstractDTO;
import lombok.Data;

@Data
public class CustomerSearchRequest extends AbstractDTO {
    private String fullName;
    private String phone;
    private String email;
    private String companyName;
    private String demand;
    private String status;
    private Integer isActive;
    private Long staffId;

}
