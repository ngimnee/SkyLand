package com.ngimnee.model.dto;

import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Data
public class AbstractDTO<T> implements Serializable {
    private static final long serialVersionUID = 7213600440729202783L;

    private Long id;
    private Timestamp createdDate;
    private String createdBy;
    private Timestamp modifiedDate;
    private String modifiedBy;
    private int maxPageItems = 15;
    private int page = 1;
    private List<T> listResult = new ArrayList<>();
    private int totalItems = 0;
    private String tableId = "tableList";
    private Integer limit;
    private Integer totalPage;
    private Integer totalItem;
    private String searchValue;
}
