package com.ngimnee.converter;

import com.ngimnee.builder.UserSearchBuilder;
import com.ngimnee.model.request.UserSearchRequest;
import com.ngimnee.utils.SearchRequestUtil;
import org.springframework.stereotype.Component;

@Component
public class UserSearchBuilderConverter {
    public UserSearchBuilder toUserSearchBuilder(UserSearchRequest userSearchRequest) {
        UserSearchBuilder userSearchBuilder = new UserSearchBuilder.Builder()
                .setUserName(SearchRequestUtil.getObject(userSearchRequest.getUserName(), String.class))
                .setFullName(SearchRequestUtil.getObject(userSearchRequest.getFullName(), String.class))
                .setPhone(SearchRequestUtil.getObject(userSearchRequest.getPhone(), String.class))
                .setEmail(SearchRequestUtil.getObject(userSearchRequest.getEmail(), String.class))
                .setStatus(SearchRequestUtil.getObject(userSearchRequest.getStatus(), Integer.class))
                .setRoleCode(SearchRequestUtil.getObject(userSearchRequest.getRoleCode(), String.class))
                .setRoleId(SearchRequestUtil.getObject(userSearchRequest.getRoleId(), Long.class))
                .build();

        return userSearchBuilder;
    }
}
