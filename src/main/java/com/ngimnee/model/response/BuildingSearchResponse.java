package com.ngimnee.model.response;

import com.ngimnee.model.dto.AbstractDTO;
import lombok.Data;

@Data
public class BuildingSearchResponse extends AbstractDTO {
	private Long id;
    private String floor;
	private String name;
	private String address;
	private Long numberOfBasement;
	private String managerName;
	private String managerPhone;
	private Long floorArea;
	private String rentArea;
    private String emptyArea;
    private Long rentPrice;
    private String serviceFee;
    private Double brokerageFee;
    private String status;
    private String legal;
}
