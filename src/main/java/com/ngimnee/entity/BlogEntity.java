package com.ngimnee.entity;


import lombok.Data;

import javax.persistence.*;

@Entity
@Table(name = "blog")
@Data
public class BlogEntity extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title")
    private String title;

    @Column(name = "content")
    private String content;

    @Column(name = "status")
    private String status;
}
