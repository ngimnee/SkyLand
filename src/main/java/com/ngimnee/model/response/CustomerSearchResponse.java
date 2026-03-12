package com.ngimnee.model.response;

import com.ngimnee.model.dto.AbstractDTO;
import lombok.Data;

@Data
public class CustomerSearchResponse extends AbstractDTO {
    private String fullName;
    private String phone;
    private String email;
    private String companyName;
    private Integer isActive;
    private String demand;
    private String status;
}
