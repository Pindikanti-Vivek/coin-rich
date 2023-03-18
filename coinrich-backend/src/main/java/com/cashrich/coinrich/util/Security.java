package com.cashrich.coinrich.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

@Component
@PropertySource("classpath:keystore.properties")
public class Security {

    @Value("${privateKey}")
    public String privateKey;

    @Value("${appKey}")
    public String appKey;

    @Value("${jwtKey}")
    public String jwtKey;

    @Value("${apiKey}")
    public String apiKey;

}
