package com.ngimnee.model.request;

import com.ngimnee.model.dto.AbstractDTO;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

@Data
public class BlogSearchRequest extends AbstractDTO {
    private String title;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date fromDate;

    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date toDate;

    private Integer isActive = 1;
}
