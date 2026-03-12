package com.ngimnee.entity;

import lombok.Data;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.List;

@Data
@Entity
@Table(name = "role")
public class RoleEntity extends BaseEntity {

    private static final long serialVersionUID = -6525302831793188081L;
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name="name")
    private String name;

    @Column(name="code")
    private String code;

    @OneToMany(mappedBy = "role", fetch = FetchType.LAZY)
    private List<UserEntity> users = new ArrayList<>();

}
