package com.ngimnee.model.dto;

import lombok.Data;

import java.sql.Timestamp;

@Data
public class BlogDTO extends AbstractDTO {
    private Long id;
    private String title;
    private String content;
    private String status;
    private Timestamp scheduledTime;
    private Timestamp publishedTime;
    private String avatar;
    private int isActive = 1;
    private Long userId;
}
