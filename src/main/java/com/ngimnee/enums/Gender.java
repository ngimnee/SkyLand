package com.ngimnee.enums;

public enum Gender {
    FEMALE(0, "Nữ"),
    MALE(1, "Nam"),
    OTHER(2, "Khác");

    private final int code;
    private final String label;

    Gender(int code, String label) {
        this.code = code;
        this.label = label;
    }

    public int getCode() {
        return code;
    }

    public String getLabel() {
        return label;
    }

    public static Gender fromCode(Integer code) {
        if (code == null) return null;
        for (Gender g : Gender.values()) {
            if (g.code == code) return g;
        }
        return null;
    }
}