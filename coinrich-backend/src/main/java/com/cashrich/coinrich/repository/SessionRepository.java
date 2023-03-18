package com.cashrich.coinrich.repository;

import com.cashrich.coinrich.entity.SessionEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SessionRepository extends JpaRepository<SessionEntity, Integer> {

    SessionEntity findByToken(String token);

    SessionEntity findByUserId(int userId);

}