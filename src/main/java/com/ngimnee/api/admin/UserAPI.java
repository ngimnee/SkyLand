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
    public ResponseEntity<Void> createUser(@RequestBody UserDTO userDTO) {
        userService.addOrUpdateUser(userDTO);
        return ResponseEntity.ok().build();
    }

    @PutMapping("/{id}")
    public ResponseEntity<Void> updateUser(@PathVariable Long id, @RequestBody UserDTO userDTO) {
        userDTO.setId(id);
        userService.addOrUpdateUser(userDTO);
        return ResponseEntity.ok().build();
    }

    @PutMapping
    public ResponseEntity<Void> updateRoleUser(@RequestBody UserDTO userDTO) {
        userService.updateRoleUser(userDTO);
        return ResponseEntity.ok().build();
    }

    @GetMapping("/detail")
    public ResponseEntity<UserDTO> getUserDetail(@RequestParam String userName) {
        return ResponseEntity.ok(userService.findOneByUserName(userName));
    }


    @DeleteMapping
    public ResponseEntity<Void> deleteUsers(@RequestBody Long[] ids) {
        if (ids != null &&ids.length > 0) {
            userService.deleteUser(ids);
        }
        return ResponseEntity.noContent().build();
    }

    @PutMapping("/change-password/{id}")
    public ResponseEntity<String> changePasswordUser(@PathVariable("id") long id,
                                                     @RequestBody PasswordDTO passwordDTO) {
        try {
            userService.updatePassword(id, passwordDTO);
            return ResponseEntity.ok(SystemConstant.UPDATE_SUCCESS);
        } catch (MyException e) {
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
}
