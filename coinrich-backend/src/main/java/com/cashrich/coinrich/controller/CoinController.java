package com.cashrich.coinrich.controller;

import com.cashrich.coinrich.entity.SessionEntity;
import com.cashrich.coinrich.repository.SessionRepository;
import com.cashrich.coinrich.response.JsonResponse;
import com.cashrich.coinrich.service.HistoryService;
import com.cashrich.coinrich.service.SessionService;
import com.cashrich.coinrich.util.Aes;
import com.cashrich.coinrich.util.Security;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.*;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.client.RestTemplate;

import java.util.Map;

@RestController
@RequestMapping("v1/coin")
public class CoinController {

    @Autowired
    private Security security;

    @Autowired
    private Aes aes;

    @Autowired
    private SessionRepository sessionRepository;

    @Autowired
    private SessionService sessionService;

    @Autowired
    private HistoryService historyService;

    @GetMapping("/quotes")
    public ResponseEntity<Object> getQuotes(@RequestParam String symbols, @RequestHeader Map<String, String> header) throws Exception {
        if(!(header.containsKey("app_key") && header.get("app_key").equals(security.appKey))) {
            return new ResponseEntity<>(new JsonResponse("Invalid App key!", "2000"), HttpStatus.BAD_REQUEST);
        }
        if(!header.containsKey("msg_id")) {
            return new ResponseEntity<>(new JsonResponse("Message Id missing!", "2000"), HttpStatus.BAD_REQUEST);
        }
        if(!header.containsKey("token")) {
            return new ResponseEntity<>(new JsonResponse(aes.encrypt("Token missing!", header.get("msg_id")), "2000"), HttpStatus.BAD_REQUEST);
        }
        SessionEntity sessionEntity = sessionRepository.findByToken(header.get("token"));
        if(sessionEntity == null) {
            return new ResponseEntity<>(new JsonResponse(aes.encrypt("Session not found/expired!", header.get("msg_id")), "2000"), HttpStatus.BAD_REQUEST);
        }
        if(!sessionService.checkExpiry(sessionEntity.getCreationTime())) {
            return new ResponseEntity<>(new JsonResponse(aes.encrypt("Session expired!", header.get("msg_id")), "2000"), HttpStatus.BAD_REQUEST);
        }
        sessionEntity = sessionService.createSession(sessionEntity.getUserId());
        historyService.create(sessionEntity.getUserId(), sessionEntity.getId(), "Quotes");
        RestTemplate restTemplate = new RestTemplate();
        HttpHeaders headers = new HttpHeaders();
        headers.set("X-CMC_PRO_API_KEY", security.apiKey);
        HttpEntity<Void> requestEntity = new HttpEntity<>(headers);
        ResponseEntity<String> response = restTemplate.exchange("https://pro-api.coinmarketcap.com/v1/cryptocurrency/quotes/latest?symbol=" + symbols, HttpMethod.GET, requestEntity, String.class);
        return new ResponseEntity<>(new JsonResponse(aes.encrypt(response.getBody(), header.get("msg_id")), "1000"), HttpStatus.OK);
    }

}
