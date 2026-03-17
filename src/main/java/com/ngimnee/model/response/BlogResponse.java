package com.ngimnee.model.response;

import com.ngimnee.model.dto.AbstractDTO;
import lombok.Data;

import java.sql.Timestamp;
import java.util.Date;

@Data
public class BlogResponse extends AbstractDTO {
    private Long id;
    private String title;
    private String content;
    private Timestamp publishedTime;
}
