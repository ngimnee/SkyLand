package com.ngimnee.model.dto;

import lombok.Data;

@Data
public class BlogDTO extends AbstractDTO {
    private String title;
    private String content;
    private String status;
}
