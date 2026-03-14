package com.ngimnee.utils;

import com.ngimnee.constant.SystemConstant;
import org.springframework.stereotype.Component;

import java.util.HashMap;
import java.util.Map;

@Component
public class MessageUtils {

	public Map<String, String> getMessage(String message) {
		Map<String, String> result = new HashMap<>();
		if (message.equals(SystemConstant.UPDATE_SUCCESS)) {
			result.put("message", "Update success");
			result.put("alert", "success");
		} else if (message.equals(SystemConstant.INSERT_SUCCESS)) {
			result.put("message", "Insert success");
			result.put("alert", "success");
		} else if (message.equals(SystemConstant.DELETE_SUCCESS)) {
			result.put("message", "Delete success");
			result.put("alert", "success");
		} else if (message.equals(SystemConstant.ERROR_SYSTEM)) {
			result.put("message", "Error system");
			result.put("alert", "danger");
		} else if (message.equals(SystemConstant.CHANGE_PASSWORD_FAIL)) {
            result.put("message", "Thay đổi mật khẩu thất bại");
            result.put("alert", "danger");
        } else if (message.equals(SystemConstant.PASSWORD_SAME_OLD)) {
            result.put("message", "Mật khẩu mới không được trùng mật khẩu cũ");
            result.put("alert", "warning");
        } else if (message.equals(SystemConstant.OLD_PASSWORD_INCORRECT)) {
            result.put("message", "Mẩu khẩu cũ không đúng.");
            result.put("alert", "warning");
        }
		return result;
	}
}
