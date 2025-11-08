package com.ngimnee.controller.admin;

import com.ngimnee.constant.SystemConstant;
import com.ngimnee.model.dto.UserDTO;
import com.ngimnee.model.request.UserSearchRequest;
import com.ngimnee.model.response.UserSearchResponse;
import com.ngimnee.security.utils.SecurityUtils;
import com.ngimnee.service.RoleService;
import com.ngimnee.service.UserService;
import com.ngimnee.utils.DisplayTagUtils;
import com.ngimnee.utils.MessageUtils;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller(value = "usersControllerOfAdmin")
public class UserController {
    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;
    @Autowired
    private MessageUtils messageUtil;

    @RequestMapping(value = "/admin/user", method = RequestMethod.GET)
    public ModelAndView getUsers(@ModelAttribute(SystemConstant.MODEL) UserSearchRequest userSearchRequest,
                                 HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/user/list");
        mav.addObject(SystemConstant.MODEL, userSearchRequest);

        // Nếu là staff thì chỉ được xem user có role USER
        if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")) {
            userSearchRequest.setRoleCode(Collections.singletonList("USER"));
        }
        if (!request.getParameterMap().containsKey("status")) {
            userSearchRequest.setStatus(1);
        }

        UserSearchResponse model = new UserSearchResponse();
        DisplayTagUtils.of(request, model);

        List<UserSearchResponse> users = userService.getUsers(userSearchRequest, PageRequest.of(model.getPage() - 1, model.getMaxPageItems()));

        model.setListResult(users);
        model.setTotalItems(userService.countTotalItems());
        mav.addObject("MODEL", userSearchRequest);
        mav.addObject(SystemConstant.MODEL, model);
        initMessageResponse(mav, request);
        return mav;
    }

    @GetMapping("/admin/user/edit")
    public ModelAndView addOrUpdateUser(@RequestParam(value = "id", required = false) Long id,
                                        HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/user/edit");
        UserDTO user = new UserDTO();

        // Kiểm tra (id) -> thêm/sửa
        if (id != null) {
            user = userService.findUserById(id);
            if (isStaffTryingToEditNonUser(user)) {
                return getAccessDeniedRedirect(mav);
            }
        } else {
            if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")) {
                user.setRoleCode("USER");
            }
        }

        // Load danh sách role để chọn (MANAGER thấy hết, STAFF chỉ thấy USER)
        Map<String, String> allRoles = roleService.getRoles();
        if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")) {
            Map<String, String> userRoleOnly = new HashMap<>();
            userRoleOnly.put("USER", allRoles.get("USER"));
            user.setRoleDTOs(userRoleOnly);
        } else {
            user.setRoleDTOs(allRoles);
        }

        mav.addObject(SystemConstant.MODEL, user);
        initMessageResponse(mav, request);
        return mav;
    }

    // Chỉ cập nhật vai trò/quyền (ROLE) của tài khoản
    @GetMapping("/admin/user/update")
    public ModelAndView updateRoleUser(@RequestParam(value="userName", required = false) String userName,
                                       HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/user/update");
        UserDTO user;
        if (userName != null && !userName.trim().isEmpty()) {
            user = userService.findOneByUserName(userName);
            if (user == null) {
                mav.setViewName("redirect:/admin/user?message=userNotFound");
                return mav;
            }
        } else {
            user = new UserDTO();
        }
        user.setRoleDTOs(roleService.getRoles());

        List<UserDTO> userList = userService.findUsersByRole();
        initMessageResponse(mav, request);
        mav.addObject("userList", userList);
        mav.addObject(SystemConstant.MODEL, user);
        return mav;
    }

    @RequestMapping(value = "/admin/profile/{username}", method = RequestMethod.GET)
    public ModelAndView updateProfile(@PathVariable("username") String username, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/user/profile");
        UserDTO model = userService.findOneByUserName(username);
        model.setRoleDTOs(roleService.getRoles());
        mav.addObject(SystemConstant.MODEL, model);
        initMessageResponse(mav, request);
        return mav;
    }

    @RequestMapping(value = "/admin/profile/password", method = RequestMethod.GET)
    public ModelAndView updatePassword(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/user/password");
        UserDTO model = userService.findOneByUserName(SecurityUtils.getPrincipal().getUsername());
        mav.addObject(SystemConstant.MODEL, model);
        initMessageResponse(mav, request);
        return mav;
    }

    private void initMessageResponse(ModelAndView mav, HttpServletRequest request) {
        String message = request.getParameter("message");
        if (StringUtils.isNotEmpty(message)) {
            Map<String, String> messageMap = messageUtil.getMessage(message);
            mav.addObject(SystemConstant.ALERT, messageMap.get(SystemConstant.ALERT));
            mav.addObject(SystemConstant.MESSAGE_RESPONSE, messageMap.get(SystemConstant.MESSAGE_RESPONSE));
        }
    }

    private boolean isStaffTryingToEditNonUser(UserDTO user) {
        return SecurityUtils.getAuthorities().contains("ROLE_STAFF")
                && user.getRoleCode() != null
                && !"USER".equals(user.getRoleCode());
    }

    private ModelAndView getAccessDeniedRedirect(ModelAndView mav) {
        mav.addObject("messageResponse", "Bạn không có quyền sửa tài khoản này!");
        mav.addObject("alert", "danger");
        mav.setViewName("redirect:/admin/user");
        return mav;
    }
}
