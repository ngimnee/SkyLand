package com.ngimnee.api.admin;

import com.ngimnee.model.dto.TransactionDTO;
import com.ngimnee.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/transaction")
public class TransactionAPI {
    @Autowired
    private TransactionService transactionService;

    @GetMapping("/{id}")
    public ResponseEntity<TransactionDTO> getTransactions(@PathVariable Long id) {
        return ResponseEntity.ok(transactionService.findById(id));
    }

    @PostMapping
    public ResponseEntity<TransactionDTO> addOrUpdateTransaction(@RequestBody TransactionDTO transactionDTO) {
        return ResponseEntity.ok(transactionService.addOrUpdateTransaction(transactionDTO));
    }

    @DeleteMapping("/{id}")
    public void deleteTransaction(@PathVariable Long id) {
        transactionService.deleteTransaction(id);
    }
}
