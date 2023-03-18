package com.cashrich.coinrich.controller;

import com.cashrich.coinrich.entity.SessionEntity;
import com.cashrich.coinrich.entity.UserEntity;
import com.cashrich.coinrich.repository.UserRepository;
import com.cashrich.coinrich.request.UserRequest;
import com.cashrich.coinrich.response.JsonResponse;
import com.cashrich.coinrich.service.HistoryService;
import com.cashrich.coinrich.service.SessionService;
import com.cashrich.coinrich.util.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Map;

@RestController
@RequestMapping("/v1/user")
public class UserController {

    @Autowired
    private Rsa rsa;

    @Autowired
    private Aes aes;

    @Autowired
    private Mapper mapper;

    @Autowired
    private Validator validator;

    @Autowired
    private Security security;

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private SessionService sessionService;

    @Autowired
    private HistoryService historyService;

    @Autowired
    private Hash hash;

    @PostMapping("/signup")
    public ResponseEntity<Object> signup(@RequestBody Map<String, String> body, @RequestHeader Map<String, String> header) throws Exception {
        if(!(header.containsKey("app_key") && header.get("app_key").equals(security.appKey))) {
            return new ResponseEntity<>(new JsonResponse("Invalid App key!", "2000"), HttpStatus.BAD_REQUEST);
        }
        if(!header.containsKey("msg_id")) {
            return new ResponseEntity<>(new JsonResponse("Message Id missing!", "2000"), HttpStatus.BAD_REQUEST);
        }
        UserRequest userRequest = mapper.mapToObject(rsa.decrypt(body.get("content")), UserRequest.class);
        String error = validator.validate(userRequest);
        if (error != null) {
            return new ResponseEntity<>(new JsonResponse(aes.encrypt(error, header.get("msg_id")), "2000"), HttpStatus.BAD_REQUEST);
        }
        if (userRepository.findByUsername(userRequest.getUsername()) != null) {
            return new ResponseEntity<>(new JsonResponse(aes.encrypt("Username already exists!", header.get("msg_id")), "2000"), HttpStatus.BAD_REQUEST);
        }
        if (!(userRequest.getPassword().matches(".*[A-Z].*") && userRequest.getPassword().matches(".*[a-z].*") && userRequest.getPassword().matches(".*\\d.*") && userRequest.getPassword().matches(".*\\W.*"))) {
            return new ResponseEntity<>(new JsonResponse(aes.encrypt("Invalid Password", header.get("msg_id")), "2000"), HttpStatus.BAD_REQUEST);
        }
        UserEntity userEntity = new UserEntity();
        userEntity.setUsername(userRequest.getUsername());
        userEntity.setPassword(hash.hashData(userRequest.getPassword()));
        userRepository.save(userEntity);
        return new ResponseEntity<>(new JsonResponse(aes.encrypt("Success", header.get("msg_id")), "1000"), HttpStatus.OK);
    }

    @PostMapping("/login")
    public ResponseEntity<Object> login(@RequestBody Map<String, String> body, @RequestHeader Map<String, String> header) throws Exception {
        if(!(header.containsKey("app_key") && header.get("app_key").equals(security.appKey))) {
            return new ResponseEntity<>(new JsonResponse("Invalid App key!", "2000"), HttpStatus.BAD_REQUEST);
        }
        if(!header.containsKey("msg_id")) {
            return new ResponseEntity<>(new JsonResponse("Message Id missing!", "2000"), HttpStatus.BAD_REQUEST);
        }
        UserRequest userRequest = mapper.mapToObject(rsa.decrypt(body.get("content")), UserRequest.class);
        String error = validator.validate(userRequest);
        if (error != null) {
            return new ResponseEntity<>(new JsonResponse(aes.encrypt(error, header.get("msg_id")), "2000"), HttpStatus.BAD_REQUEST);
        }
        UserEntity userEntity = userRepository.findByUsername(userRequest.getUsername());
        if(userEntity == null) {
            return new ResponseEntity<>(new JsonResponse(aes.encrypt("User not found!", header.get("msg_id")), "2000"), HttpStatus.BAD_REQUEST);
        }
        if(!hash.compare(userEntity.getPassword(), hash.hashData(userRequest.getPassword()))) {
            return new ResponseEntity<>(new JsonResponse(aes.encrypt("Incorrect password!", header.get("msg_id")), "2000"), HttpStatus.BAD_REQUEST);
        }
        SessionEntity sessionEntity = sessionService.createSession(userEntity.getId());
        historyService.create(userEntity.getId(), sessionEntity.getId(), "Login");
        return new ResponseEntity<>(new JsonResponse(aes.encrypt(sessionEntity.getToken(), header.get("msg_id")), "1000"), HttpStatus.OK);
    }

}
