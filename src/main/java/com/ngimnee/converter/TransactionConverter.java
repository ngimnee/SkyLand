package com.ngimnee.converter;

import com.ngimnee.entity.TransactionEntity;
import com.ngimnee.model.dto.TransactionDTO;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class TransactionConverter {
    @Autowired
    private ModelMapper modelMapper;

    public TransactionDTO toTransactionDTO(TransactionEntity transactionEntity) {
        return modelMapper.map(transactionEntity, TransactionDTO.class);
    }

    public TransactionEntity toTransactionEntity(TransactionDTO transactionDTO) {
        return modelMapper.map(transactionDTO, TransactionEntity.class);
    }

    public void updateEntityFromDTO(TransactionDTO transactionDTO, TransactionEntity transactionEntity) {
        modelMapper.getConfiguration().setPropertyCondition(context -> true);
        modelMapper.map(transactionDTO, transactionEntity);
    }
}
