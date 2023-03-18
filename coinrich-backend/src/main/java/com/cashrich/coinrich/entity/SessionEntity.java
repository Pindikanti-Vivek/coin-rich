package com.cashrich.coinrich.entity;

import lombok.Data;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;

@Entity
@Data
@Table(name = "session")
public class SessionEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Integer userId;
    private String token;
    private String creationTime;

    @PrePersist
    protected void prePersist() {
        this.creationTime = new Timestamp(new Date().getTime()).toString();
    }

    @PreUpdate
    protected void preUpdate() {
        this.creationTime = new Timestamp(new Date().getTime()).toString();
    }

}
