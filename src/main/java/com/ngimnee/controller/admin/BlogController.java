package com.ngimnee.controller.admin;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

@Controller
public class BlogController {
    @GetMapping("/admin/blog")
    public ModelAndView blogPage(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/blog/list");
        return mav;
    }

    @GetMapping("/admin/blog/edit")
    public ModelAndView blogEditPage(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/blog/edit");
        return mav;
    }

    @GetMapping("/admin/blog/edit/{id}")
    public ModelAndView blogEditPage(@PathVariable("id") Long id,
                                     HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/blog/edit");
        return mav;
    }
}
