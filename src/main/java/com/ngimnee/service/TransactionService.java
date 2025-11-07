package com.ngimnee.service;

import com.ngimnee.model.dto.TransactionDTO;

import java.util.List;

public interface TransactionService {
    List<TransactionDTO> findByCodeAndCustomerId(String code, Long customerId);
    TransactionDTO addOrUpdateTransaction(TransactionDTO transactionTypeDTO);
    TransactionDTO findById(Long id);
    void deleteTransaction(Long id);
}
