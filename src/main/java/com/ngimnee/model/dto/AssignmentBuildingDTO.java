package com.ngimnee.model.dto;

import lombok.Data;

import java.util.List;

@Data
public class AssignmentBuildingDTO extends AbstractDTO {
    private Long buildingId;
    private List<Long> staffs;
}
