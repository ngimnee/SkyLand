package com.ngimnee.model.response;

import com.ngimnee.model.dto.AbstractDTO;

public class TransactionResponse extends AbstractDTO {
    private String code;
    private String note;

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
