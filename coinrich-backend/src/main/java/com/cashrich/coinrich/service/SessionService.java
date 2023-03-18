package com.cashrich.coinrich.service;

import com.cashrich.coinrich.entity.SessionEntity;
import com.cashrich.coinrich.repository.SessionRepository;
import com.cashrich.coinrich.util.Jwt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.sql.Timestamp;
import java.util.Date;

@Service
public class SessionService {

    @Autowired
    private Jwt jwt;

    @Autowired
    private SessionRepository sessionRepository;

    public SessionEntity createSession(Integer userId) {
        SessionEntity sessionEntity = sessionRepository.findByUserId(userId);
        if(sessionEntity == null) {
            sessionEntity = new SessionEntity();
            sessionEntity.setUserId(userId);
            sessionEntity.setToken(jwt.generateToken(userId.toString()));
        }
        sessionEntity.setCreationTime(new Timestamp(new Date().getTime()).toString());
        return sessionRepository.save(sessionEntity);
    }

    public boolean checkExpiry(String creationTime) {
        return ((new Date().getTime() - Timestamp.valueOf(creationTime).getTime())/1000) < 180;
    }
}
