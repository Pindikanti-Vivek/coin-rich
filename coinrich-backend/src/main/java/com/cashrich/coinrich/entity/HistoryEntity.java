package com.cashrich.coinrich.entity;

import lombok.Data;

import javax.persistence.*;
import java.sql.Timestamp;
import java.util.Date;

@Entity
@Data
@Table(name = "history")
public class HistoryEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;
    private Integer userId;
    private Integer sessionId;
    private String api;
    private String timestamp;

    @PrePersist
    protected void prePersist() {
        this.timestamp = new Timestamp(new Date().getTime()).toString();
    }

}
