package com.ngimnee.model.dto;

import lombok.Data;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Data
public class BuildingDTO extends AbstractDTO{
    private Long id;
    private String name;
    private String street;
    private String ward;
    private String district;
    private String city;
    private String floor;
    private Long numberOfBasement;
    private Long floorArea;
    private String level;
    private List<String> typeCode;
    private String overtimeFee;
    private String electricityFee;
    private String deposit;
    private String payment;
    private String rentTime;
    private String decorationTime;
    private String rentPriceDescription;
    private String carFee;
    private String motoFee;
    private String motorbikeFee;
    private String structure;
    private String direction;
    private String note;
    private String rentArea;
    private String status = "N";
    private String managerName;
    private String managerPhone;
    private Long rentPrice;
    private String serviceFee;
    private double brokerageFee;
    private String image;
    private String imageBase64;
    private String imageName;
    private String avatar;
    private Long orderId;
    private String orderCode;

    private Map<String,String> buildingDTOs = new HashMap<>();
}