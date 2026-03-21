package com.ngimnee.controller.admin;

import com.ngimnee.constant.SystemConstant;
import com.ngimnee.model.dto.BlogDTO;
import com.ngimnee.model.request.BlogSearchRequest;
import com.ngimnee.model.request.BuildingSearchRequest;
import com.ngimnee.model.response.BlogResponse;
import com.ngimnee.model.response.BuildingSearchResponse;
import com.ngimnee.service.BlogService;
import com.ngimnee.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class BlogController {
    @Autowired
    private BlogService blogService;

    @GetMapping("/admin/blog")
    public ModelAndView blogPage(@ModelAttribute("blogSearchRequest") BlogSearchRequest blogSearchRequest, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/blog/list");

        BlogResponse model = new BlogResponse();
        DisplayTagUtils.of(request, model);
        List<BlogResponse> resultList = blogService.getBlog(blogSearchRequest.getFromDate(), blogSearchRequest.getToDate(),
                PageRequest.of(blogSearchRequest.getPage() - 1, blogSearchRequest.getMaxPageItems())).getContent();

        model.setListResult(resultList);
        model.setTotalItems(blogService.countTotalItem(resultList));
        mav.addObject(SystemConstant.MODEL, model);
        return mav;
    }

    @GetMapping("/admin/blog/edit")
    public ModelAndView blogEditPage(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/blog/edit");
        return mav;
    }

    @GetMapping("/admin/blog/edit/{id}")
    public ModelAndView blogEditPage(@PathVariable("id") Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/blog/edit");
        BlogDTO blogDTO = blogService.findById(id);
        mav.addObject("editBlog", blogDTO);
        return mav;
    }
}
