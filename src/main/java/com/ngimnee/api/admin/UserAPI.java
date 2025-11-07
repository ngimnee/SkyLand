package com.ngimnee.api.admin;

import com.ngimnee.constant.SystemConstant;
import com.ngimnee.exception.MyException;
import com.ngimnee.model.dto.PasswordDTO;
import com.ngimnee.model.dto.UserDTO;
import com.ngimnee.model.request.UserSearchRequest;
import com.ngimnee.model.response.UserSearchResponse;
import com.ngimnee.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/user")
public class UserAPI {
    @Autowired
    private UserService userService;

    @GetMapping
    public List<UserSearchResponse> getUsers(@ModelAttribute UserSearchRequest userSearchRequest, Pageable pageable) {
        List<UserSearchResponse> res = userService.getUsers(userSearchRequest, pageable);
        return res;
    }

    @PostMapping
    public ResponseEntity<UserDTO> createOrUpdateUser(@RequestBody UserDTO newUser) {
        if (newUser.getId() != null) {
            return ResponseEntity.ok(userService.updateUser(newUser.getId(), newUser));
        } else {
            return ResponseEntity.ok(userService.createUser(newUser));
        }
    }

    @PostMapping("/{id}")
    public ResponseEntity<UserDTO> updateUsers(@PathVariable("id") long id,
                                               @RequestBody UserDTO userDTO) {
        return ResponseEntity.ok(userService.updateUser(id, userDTO));
    }

    @PutMapping("/change-password/{id}")
    public ResponseEntity<String> changePasswordUser(@PathVariable("id") long id,
                                                     @RequestBody PasswordDTO passwordDTO) {
        try {
            userService.updatePassword(id, passwordDTO);
            return ResponseEntity.ok(SystemConstant.UPDATE_SUCCESS);
        } catch (MyException e) {
            //LOGGER.error(e.getMessage());
            return ResponseEntity.ok(e.getMessage());
        }
    }

    @PutMapping("/password/{id}/reset")
    public ResponseEntity<UserDTO> resetPassword(@PathVariable("id") long id) {
        return ResponseEntity.ok(userService.resetPassword(id));
    }

    @PutMapping("/profile/{username}")
    public ResponseEntity<UserDTO> updateProfileOfUser(@PathVariable("username") String username,
                                                       @RequestBody UserDTO userDTO) {
        return ResponseEntity.ok(userService.updateProfileOfUser(username, userDTO));
    }

    @DeleteMapping
    public ResponseEntity<Void> deleteUsers(@RequestBody Long[] ids) {
        if (ids != null &&ids.length > 0) {
            userService.deleteUser(ids);
        }
        return ResponseEntity.noContent().build();
    }
}
