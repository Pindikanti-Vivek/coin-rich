package com.cashrich.coinrich.util;

import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.Date;

@Component
public class Jwt {

    @Autowired
    private Security security;

    public String generateToken(String userId) {
        return Jwts.builder().setSubject(userId).setIssuedAt(new Date(System.currentTimeMillis())).signWith(SignatureAlgorithm.HS512, security.jwtKey).compact();
    }

    public Boolean validateToken(String token, String userId) {
        return Jwts.parser().setSigningKey(security.jwtKey).parseClaimsJws(token).getBody().getSubject().equals(userId);
    }

}
