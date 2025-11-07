package com.ngimnee.builder;

public class UserSearchBuilder {
    private String userName;
    private String fullName;
    private String phone;
    private String email;
    private Integer status;
    private String roleCode;
    private Long roleId;

    public UserSearchBuilder(Builder builder) {
        this.userName = builder.userName;
        this.fullName = builder.fullName;
        this.phone = builder.phone;
        this.email = builder.email;
        this.status = builder.status;
        this.roleCode = builder.roleCode;
        this.roleId = builder.roleId;
    }

    public String getUserName() {
        return userName;
    }

    public String getFullName() {
        return fullName;
    }

    public String getPhone() {
        return phone;
    }

    public String getEmail() {
        return email;
    }

    public Integer getStatus() {
        return status;
    }

    public String getRoleCode() {
        return roleCode;
    }

    public Long getRoleId() {
        return roleId;
    }

    public static class Builder {
        private String userName;
        private String fullName;
        private String phone;
        private String email;
        private Integer status;
        private String roleCode;
        private Long roleId;

        public Builder setUserName(String userName) {
            this.userName = userName;
            return this;
        }

        public Builder setFullName(String fullName) {
            this.fullName = fullName;
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

        public Builder setStatus(Integer status) {
            this.status = status;
            return this;
        }

        public Builder setRoleCode(String roleCode) {
            this.roleCode = roleCode;
            return this;
        }

        public Builder setRoleId(Long roleId) {
            this.roleId = roleId;
            return this;
        }

        public UserSearchBuilder build() {
            return new UserSearchBuilder(this);
        }
    }
}
