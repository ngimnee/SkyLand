package com.ngimnee.controller.admin;

import com.ngimnee.enums.TransactionCode;
import com.ngimnee.model.dto.TransactionDTO;
import com.ngimnee.service.TransactionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;


@Controller
public class TransactionController {
    @Autowired
    private TransactionService transactionService;

    @GetMapping("/admin/customer/support/{customerId}")
    public ModelAndView supportPage(@PathVariable("customerId") Long customerId) {
        ModelAndView mav = new ModelAndView("admin/customer/support");

        List<TransactionDTO> supports = transactionService.findByCodeAndCustomerId("CSKH", customerId);
        List<TransactionDTO> views = transactionService.findByCodeAndCustomerId("VIEW", customerId);

        // Hiển thị riêng CSKH và VIEW, có thể add riêng
        mav.addObject("supports", supports);
        mav.addObject("views", views);

//        // Hoặc combine nếu muốn 1 bảng chung
//        List<TransactionDTO> transactionList = new ArrayList<>();
//        transactionList.addAll(supports);
//        transactionList.addAll(views);
//        mav.addObject("transactionList", transactionList);

        mav.addObject("codeList", TransactionCode.getCodes());
        mav.addObject("customerId", customerId);
        mav.addObject("transactionForm", new TransactionDTO());
        return mav;
    }


    @GetMapping("/admin/customer/support")
    public ModelAndView supportPage(HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/customer/support");
        return mav;
    }
}
