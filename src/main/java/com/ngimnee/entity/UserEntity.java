package com.ngimnee.entity;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Entity
@Getter
@Setter
@Table(name = "user")
public class UserEntity extends BaseEntity {
    private static final long serialVersionUID = -4988455421375043688L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "username", nullable = false, unique = true)
    private String userName;

    @Column(name = "password", nullable = false)
    private String password;

    @Column(name = "fullname", nullable = false)
    private String fullName;

    @Column(name = "status")
    private Integer status;

    @Column(name = "phone")
    private String phone;

    @Column(name = "email", unique = true)
    private String email;

    @Column(name = "is_active", columnDefinition = "TINYINT(1) DEFAULT 1")
    private Integer isActive = 1;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "role_id", nullable = false)
    private RoleEntity role;

    @ManyToMany(mappedBy = "users", fetch = FetchType.LAZY)
    private List<BuildingEntity> buildings = new ArrayList<>();

    @ManyToMany(mappedBy = "users", fetch = FetchType.LAZY)
    private List<CustomerEntity> customers = new ArrayList<>();

    @ManyToMany(mappedBy = "users", fetch = FetchType.LAZY)
    private List<OrderEntity> orders = new ArrayList<>();
}
