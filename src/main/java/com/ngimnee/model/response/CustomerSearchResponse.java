package com.ngimnee.model.response;

import com.ngimnee.model.dto.AbstractDTO;

public class CustomerSearchResponse extends AbstractDTO {
    private String fullName;
    private String phone;
    private String email;
    private String companyName;
    private Integer isActive;
    private String demand;
    private String status;
    private String createdDate;

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCompanyName() {
        return companyName;
    }

    public void setCompanyName(String companyName) {
        this.companyName = companyName;
    }

    public Integer getIsActive() {
        return isActive;
    }

    public void setIsActive(Integer isActive) {
        this.isActive = isActive;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public String getDemand() {
        return demand;
    }

    public void setDemand(String demand) {
        this.demand = demand;
    }

    public void setCreatedDate(String createdDate) {
        this.createdDate = createdDate;
    }
}
