package com.ngimnee.service.impl;

import com.ngimnee.converter.TransactionConverter;
import com.ngimnee.entity.TransactionEntity;
import com.ngimnee.model.dto.TransactionDTO;
import com.ngimnee.repository.TransactionRepository;
import com.ngimnee.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.acls.model.NotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
public class TransactionServiceImpl implements TransactionService {
    @Autowired
    private TransactionRepository transactionRepository;
    @Autowired
    private TransactionConverter transactionConverter;

    @Override
    public List<TransactionDTO> findByCodeAndCustomerId(String code, Long customerId) {
        List<TransactionDTO> res = new ArrayList<TransactionDTO>();
        List<TransactionEntity> list = transactionRepository.findByCodeAndCustomerId(code, customerId);
        for (TransactionEntity it : list) {
            res.add(transactionConverter.toTransactionDTO(it));
        }
        return res;
    }

    @Override
    public TransactionDTO addOrUpdateTransaction(TransactionDTO transactionDTO) {
        TransactionEntity transaction;
        if(transactionDTO.getId() != null) {
            transaction = transactionRepository.findById(transactionDTO.getId())
                    .orElseThrow(() -> new NotFoundException("Transaction not found!"));
            transactionConverter.updateEntityFromDTO(transactionDTO, transaction);
        } else {
            transaction = transactionConverter.toTransactionEntity(transactionDTO);
        }
        transactionRepository.save(transaction);
        return transactionConverter.toTransactionDTO(transaction);
    }

    @Override
    public TransactionDTO findById(Long id) {
        return transactionConverter.toTransactionDTO(transactionRepository.findById(id).get());
    }

    @Override
    public void deleteTransaction(Long id) {
        transactionRepository.deleteById(id);
    }
}
