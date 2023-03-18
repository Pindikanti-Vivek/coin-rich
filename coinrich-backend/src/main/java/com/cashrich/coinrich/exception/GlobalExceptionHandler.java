package com.cashrich.coinrich.exception;

import com.cashrich.coinrich.response.JsonResponse;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

@ControllerAdvice
public class GlobalExceptionHandler {

    @ExceptionHandler(Exception.class)
    public ResponseEntity<Object> handleException(Exception e) {
        e.printStackTrace();
        return new ResponseEntity<>(new JsonResponse("Server Error", "2000"), HttpStatus.BAD_REQUEST);
    }

}
