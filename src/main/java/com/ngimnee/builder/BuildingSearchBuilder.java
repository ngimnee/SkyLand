package com.ngimnee.builder;

import java.util.ArrayList;
import java.util.List;

public class BuildingSearchBuilder {
    private Long id;
    private String name;
    private Long floorArea;
    private String ward;
    private String street;
    private String district;
    private String city;
    private Integer numberOfBasement;
    private List<String> typeCode = new ArrayList<>();
    private Long rentAreaFrom;
    private Long rentAreaTo;
    private Long rentPriceFrom;
    private Long rentPriceTo;
    private Long level;
    private String direction;
    private Long staffId;
    private String managerName;
    private String managerPhone;
    private String status;

    public BuildingSearchBuilder(Builder builder) {
        this.id = builder.id;
        this.name = builder.name;
        this.floorArea = builder.floorArea;
        this.ward = builder.ward;
        this.street = builder.street;
        this.district = builder.district;
        this.city = builder.city;
        this.numberOfBasement = builder.numberOfBasement;
        this.typeCode = builder.typeCode;
        this.rentAreaFrom = builder.rentAreaFrom;
        this.rentAreaTo = builder.rentAreaTo;
        this.rentPriceFrom = builder.rentPriceFrom;
        this.rentPriceTo = builder.rentPriceTo;
        this.level = builder.level;
        this.direction = builder.direction;
        this.staffId = builder.staffId;
        this.managerName = builder.managerName;
        this.managerPhone = builder.managerPhone;
        this.status = builder.status;
    }

    public Long getId() {
        return id;
    }
    public String getName() {
        return name;
    }
    public Long getFloorArea() {
        return floorArea;
    }
    public String getWard() {
        return ward;
    }
    public String getStreet() {
        return street;
    }
    public String getDistrict() {
        return district;
    }
    public String getCity() {
        return city;
    }
    public Integer getNumberOfBasement() {
        return numberOfBasement;
    }
    public List<String> getTypeCode() {
        return typeCode;
    }
    public Long getRentAreaFrom() {
        return rentAreaFrom;
    }
    public Long getRentAreaTo() {
        return rentAreaTo;
    }
    public Long getRentPriceFrom() {
        return rentPriceFrom;
    }
    public Long getRentPriceTo() {
        return rentPriceTo;
    }
    public Long getStaffId() {
        return staffId;
    }
    public String getManagerName() {
        return managerName;
    }
    public String getManagerPhone() {
        return managerPhone;
    }
    public String getStatus() {
        return status;
    }

    public static class Builder {
        private Long id;
        private String name;
        private Long floorArea;
        private String ward;
        private String street;
        private String district;
        private String city;
        private Integer numberOfBasement;
        private List<String> typeCode = new ArrayList<>();
        private Long rentAreaFrom;
        private Long rentAreaTo;
        private Long rentPriceFrom;
        private Long rentPriceTo;
        private Long level;
        private String direction;
        private Long staffId;
        private String managerName;
        private String managerPhone;
        private String status;

        public Builder setId(Long id) {
            this.id = id;
            return this;
        }
        public Builder setName(String name) {
            this.name = name;
            return this;
        }
        public Builder setFloorArea(Long floorArea) {
            this.floorArea = floorArea;
            return this;
        }
        public Builder setWard(String ward) {
            this.ward = ward;
            return this;
        }
        public Builder setStreet(String street) {
            this.street = street;
            return this;
        }
        public Builder setDistrict(String district) {
            this.district = district;
            return this;
        }
        public Builder setCity(String city) {
            this.city = city;
            return this;
        }
        public Builder setNumberOfBasement(Integer numberOfBasement) {
            this.numberOfBasement = numberOfBasement;
            return this;
        }
        public Builder setTypeCode(List<String> typeCode) {
            this.typeCode = typeCode;
            return this;
        }
        public Builder setRentAreaFrom(Long rentAreaFrom) {
            this.rentAreaFrom = rentAreaFrom;
            return this;
        }
        public Builder setRentAreaTo(Long rentAreaTo) {
            this.rentAreaTo = rentAreaTo;
            return this;
        }
        public Builder setRentPriceFrom(Long rentPriceFrom) {
            this.rentPriceFrom = rentPriceFrom;
            return this;
        }
        public Builder setRentPriceTo(Long rentPriceTo) {
            this.rentPriceTo = rentPriceTo;
            return this;
        }
        public Builder setLevel(Long level) {
            this.level = level;
            return this;
        }
        public Builder setDirection(String direction) {
            this.direction = direction;
            return this;
        }
        public Builder setStaffId(Long staffId) {
            this.staffId = staffId;
            return this;
        }
        public Builder setManagerName(String managerName) {
            this.managerName = managerName;
            return this;
        }
        public Builder setManagerPhone(String managerPhone) {
            this.managerPhone = managerPhone;
            return this;
        }

        public Builder setStatus(String status) {
            this.status = status;
            return this;
        }

        public BuildingSearchBuilder build() {
            return new BuildingSearchBuilder(this);
        }
    }
}
