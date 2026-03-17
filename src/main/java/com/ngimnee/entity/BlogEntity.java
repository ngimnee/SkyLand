package com.ngimnee.entity;

import lombok.Data;

import javax.persistence.*;
import java.sql.Timestamp;

@Entity
@Table(name = "blog")
@Data
public class BlogEntity extends BaseEntity {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Column(name = "title")
    private String title;

    @Column(name = "content", columnDefinition = "TEXT")
    private String content;

    @Column(name = "status")
    private String status;

    @Column(name = "scheduled_time")
    private Timestamp scheduledTime;

    @Column(name = "published_time")
    private Timestamp publishedTime;

    @Column(name = "avatar")
    private String avatar;

    @Column(name = "is_active")
    private int isActive;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "user_id")
    private UserEntity user;
}
