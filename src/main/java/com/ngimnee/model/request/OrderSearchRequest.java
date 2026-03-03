package com.ngimnee.model.request;

import com.ngimnee.model.dto.AbstractDTO;
import lombok.Data;

@Data
public class OrderSearchRequest extends AbstractDTO {
    private Long id;
    private String code;
    private Long customerId;
    private String name;
    private String phone;
    private String email;
    private String address;
    private String status;
    private Long staffId;
}
