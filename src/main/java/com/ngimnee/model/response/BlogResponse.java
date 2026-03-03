package com.ngimnee.model.response;

import com.ngimnee.model.dto.AbstractDTO;
import lombok.Data;

@Data
public class BlogResponse extends AbstractDTO {
    private Long id;
    private String title;
    private String content;
}
