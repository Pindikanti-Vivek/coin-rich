package com.cashrich.coinrich.util;

import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.stereotype.Component;

@Component
public class Mapper {

    public <T> T mapToObject(String requestString, Class<T> classType) {
        try {
            ObjectMapper jsonMapper = new ObjectMapper();
            jsonMapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
            return jsonMapper.readValue(requestString, classType);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

}
