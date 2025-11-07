package com.ngimnee.repository.custom;

import com.ngimnee.builder.UserSearchBuilder;
import com.ngimnee.entity.UserEntity;
import com.ngimnee.model.request.UserSearchRequest;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.List;

public interface UserRepositoryCustom {
    List<UserEntity> findUsers(UserSearchBuilder userSearchBuilder, Pageable pageable);
	List<UserEntity> findByRole(String roleCode);
	List<UserEntity> getAllUsers(Pageable pageable);
	int countTotalItem();
}
