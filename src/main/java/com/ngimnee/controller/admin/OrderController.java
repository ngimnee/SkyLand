package com.ngimnee.controller.admin;

import com.ngimnee.model.dto.OrderDTO;
import com.ngimnee.model.request.OrderSearchRequest;
import com.ngimnee.model.response.OrderSearchResponse;
import com.ngimnee.security.utils.SecurityUtils;
import com.ngimnee.service.OrderService;
import com.ngimnee.service.UserService;
import com.ngimnee.utils.DisplayTagUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
public class OrderController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private UserService userService;

    @GetMapping("/admin/order")
    public ModelAndView orderPage(@ModelAttribute OrderSearchRequest orderSearchRequest,
                                      HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/order/list");
        mav.addObject("orderSearch", orderSearchRequest);
        mav.addObject("listStaff", userService.getStaffs());
        if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")) {
            orderSearchRequest.setId(SecurityUtils.getPrincipal().getId());
        }

        OrderSearchResponse model =  new OrderSearchResponse();
        DisplayTagUtils.of(request, model);

        List<OrderSearchResponse> resultList = orderService.findOrders(orderSearchRequest,
                PageRequest.of(orderSearchRequest.getPage() - 1, orderSearchRequest.getMaxPageItems()));
        model.setListResult(resultList);
        model.setTotalItems(orderService.countTotalItem(resultList));

        mav.addObject("orderSearch", model);
        return mav;
    }

    @GetMapping("/admin/edit")
    public ModelAndView editOrder(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("web/building");
        return mav;
    }

    @GetMapping("/admin/edit/{id}")
    public ModelAndView editOrder(@PathVariable("id") Long id,
                                  HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/order/edit");
        OrderDTO orderDTO = orderService.findById(id);
        mav.addObject("editOrder", orderDTO);
        return mav;
    }
}
