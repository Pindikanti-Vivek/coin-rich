package com.cashrich.coinrich.util;

import org.springframework.stereotype.Component;

import java.security.MessageDigest;
import java.util.Base64;

@Component
public class Hash {

    public String hashData(String data) throws Exception {
        MessageDigest messageDigest = MessageDigest.getInstance("SHA-512");
        messageDigest.update(data.getBytes());
        return Base64.getEncoder().encodeToString(messageDigest.digest());
    }

    public boolean compare(String data1, String data2) {
        return MessageDigest.isEqual(Base64.getDecoder().decode(data1), Base64.getDecoder().decode(data2));
    }


}
