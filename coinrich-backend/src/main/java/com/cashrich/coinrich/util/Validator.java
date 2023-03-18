package com.cashrich.coinrich.util;

import org.springframework.stereotype.Service;

import java.util.Iterator;
import java.util.Set;
import javax.validation.ConstraintViolation;
import javax.validation.Validation;
import javax.validation.ValidatorFactory;

@Service
public class Validator {

    public String validate(Object request) {
        ValidatorFactory factory = Validation.buildDefaultValidatorFactory();
        javax.validation.Validator validator = factory.getValidator();
        Set<ConstraintViolation<Object>> violations = validator.validate(request);
        if (!violations.isEmpty()) {
            Iterator<ConstraintViolation<Object>> cv = violations.iterator();
            ConstraintViolation<Object> cvo = cv.next();
            return cvo.getMessage();
        }
        return null;
    }
}
