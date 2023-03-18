package com.cashrich.coinrich.util;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.crypto.Cipher;
import java.nio.charset.StandardCharsets;
import java.security.*;
import java.security.spec.PKCS8EncodedKeySpec;
import java.util.Base64;

@Service
public class Rsa {

    @Autowired
    private Security security;

    public String decrypt(String encryptedText) throws Exception {
        Cipher cipher = Cipher.getInstance("RSA");
        KeyFactory keyFactory = KeyFactory.getInstance("RSA");
        PrivateKey key = keyFactory.generatePrivate(new PKCS8EncodedKeySpec(Base64.getDecoder().decode(security.privateKey)));
        cipher.init(Cipher.DECRYPT_MODE, key);
        byte[] decryptedMessageBytes = cipher.doFinal(Base64.getDecoder().decode(encryptedText));
        return new String(decryptedMessageBytes, StandardCharsets.UTF_8);
    }
}
