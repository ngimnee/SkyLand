package com.ngimnee.config;

import lombok.Getter;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

@Getter
@Component
public class PasswordConfig {
    @Value("${user.password.default}")
    private String passwordDefault;
}