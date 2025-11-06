package com.ngimnee.builder;

public class OrderSearchBuilder {
    private Long id;
    private String code;
    private Long customerId;
    private String amount;
    private String paymentmethod;
    private String note;
    private String status;
    private String name;
    private String phone;
    private String email;
    private  String address;
    private Long staffId;
    private Long buildingId;

    public OrderSearchBuilder(Builder builder) {
        this.id = builder.id;
        this.code = builder.code;
        this.customerId = builder.customerId;
        this.amount = builder.amount;
        this.paymentmethod = builder.paymentmethod;
        this.note = builder.note;
        this.status = builder.status;
        this.name = builder.name;
        this.phone = builder.phone;
        this.email = builder.email;
        this.address = builder.address;
        this.staffId = builder.staffId;
        this.buildingId = buildingId;
    }

    public Long getId() {
        return id;
    }

    public String getCode() {
        return code;
    }

    public Long getCustomerId() {
        return customerId;
    }

    public String getAmount() {
        return amount;
    }

    public String getPaymentmethod() {
        return paymentmethod;
    }

    public String getNote() {
        return note;
    }

    public String getStatus() {
        return status;
    }

    public String getName() {
        return name;
    }

    public String getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    public String getAddress() {
        return address;
    }

    public Long getStaffId() {
        return staffId;
    }

    public Long getBuildingId() {
        return buildingId;
    }

    public static class Builder {
        private Long id;
        private String code;
        private Long customerId;
        private String amount;
        private String paymentmethod;
        private String note;
        private String status;
        private String name;
        private String phone;
        private String email;
        private  String address;
        private Long staffId;
        private Long buildingId;

        public Builder setId(Long id) {
            this.id = id;
            return this;
        }

        public Builder setCode(String code) {
            this.code = code;
            return this;
        }

        public Builder setCustomerId(Long customerId) {
            this.customerId = customerId;
            return this;
        }

        public Builder setAmount(String amount) {
            this.amount = amount;
            return this;
        }

        public Builder setPaymentmethod(String paymentmethod) {
            this.paymentmethod = paymentmethod;
            return this;
        }

        public Builder setNote(String note) {
            this.note = note;
            return this;
        }

        public Builder setStatus(String status) {
            this.status = status;
            return this;
        }

        public Builder setName(String name) {
            this.name = name;
            return this;
        }

        public Builder setPhone(String phone) {
            this.phone = phone;
            return this;
        }

        public Builder setEmail(String email) {
            this.email = email;
            return this;
        }

        public Builder setAddress(String address) {
            this.address = address;
            return this;
        }

        public Builder setStaffId(Long staffId) {
            this.staffId = staffId;
            return this;
        }

        public Builder setBuildingId(Long buildingId) {
            this.buildingId = buildingId;
            return this;
        }

        public OrderSearchBuilder build() {
            return new OrderSearchBuilder(this);
        }
    }
}
