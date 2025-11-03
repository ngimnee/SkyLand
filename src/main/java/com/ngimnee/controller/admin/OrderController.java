package com.ngimnee.controller.admin;

import com.ngimnee.model.request.OrderSearchRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
public class OrderController {
    @GetMapping("/admin/order")
    public ModelAndView orderPage(@ModelAttribute OrderSearchRequest orderSearchRequest,
                                      HttpServletRequest request) {
        ModelAndView mav = new ModelAndView();
        mav.addObject("orderSearch", orderSearchRequest);
        return mav;
    }
}
