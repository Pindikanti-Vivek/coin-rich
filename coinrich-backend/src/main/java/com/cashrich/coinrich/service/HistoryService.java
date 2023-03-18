package com.cashrich.coinrich.service;

import com.cashrich.coinrich.entity.HistoryEntity;
import com.cashrich.coinrich.repository.HistoryRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class HistoryService {

    @Autowired
    private HistoryRepository historyRepository;

    public HistoryEntity create(Integer userId, Integer sessionId, String api) {
        HistoryEntity historyEntity = new HistoryEntity();
        historyEntity.setUserId(userId);
        historyEntity.setSessionId(sessionId);
        historyEntity.setApi(api);
        return historyRepository.save(historyEntity);
    }
}
