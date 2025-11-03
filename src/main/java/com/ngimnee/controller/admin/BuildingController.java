package com.ngimnee.controller.admin;

import com.ngimnee.enums.City;
import com.ngimnee.enums.District;
import com.ngimnee.enums.StatusBuilding;
import com.ngimnee.enums.TypeCode;
import com.ngimnee.model.dto.BuildingDTO;
import com.ngimnee.model.request.BuildingSearchRequest;
import com.ngimnee.model.response.BuildingSearchResponse;
import com.ngimnee.security.utils.SecurityUtils;
import com.ngimnee.service.BuildingService;
import com.ngimnee.service.UserService;
import com.ngimnee.utils.DisplayTagUtils;
import com.ngimnee.utils.DistrictsByCityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.PageRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

@Controller
public class BuildingController {
    @Autowired
    private BuildingService buildingService;

    @Autowired
    private UserService userService;

    @GetMapping(value = "/admin/building")
    public ModelAndView listBuilding(@ModelAttribute BuildingSearchRequest buildingSearchRequest,
                                     HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/list");
        mav.addObject("buildingSearch", buildingSearchRequest);

        mav.addObject("listStaff", userService.getStaffs());
        mav.addObject("status", StatusBuilding.getStatus());
        mav.addObject("city", City.getCity());
        if (buildingSearchRequest.getCity() != null && !buildingSearchRequest.getCity().isEmpty()) {
            BuildingDTO dto = new BuildingDTO();
            dto.setCity(buildingSearchRequest.getCity());
            mav.addObject("district", DistrictsByCityUtils.getDistrictsByCity(dto));
        } else {
            mav.addObject("district", DistrictsByCityUtils.getEmptyDistrict());
        }
        mav.addObject("typeCode", TypeCode.getTypeCode());

        // Nếu là staff thì giới hạn dữ liệu theo ID
        if (SecurityUtils.getAuthorities().contains("ROLE_STAFF")) {
            buildingSearchRequest.setStaffId(SecurityUtils.getPrincipal().getId());
        }

        BuildingSearchResponse model = new BuildingSearchResponse();
        DisplayTagUtils.of(request, model);

        List<BuildingSearchResponse> resultList = buildingService.findBuilding(buildingSearchRequest,
                        PageRequest.of(buildingSearchRequest.getPage() - 1, buildingSearchRequest.getMaxPageItems()));

        model.setListResult(resultList);
        model.setTotalItems(buildingService.countTotalItem(resultList));

        mav.addObject("buildingList", model);
        return mav;
    }


    @GetMapping(value = "/admin/building/edit")
    public ModelAndView editBuilding(@ModelAttribute BuildingDTO buildingDTO,
                                     HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/edit");
        mav.addObject("editBuilding", buildingDTO);

        mav.addObject("listStaff", userService.getStaffs());
        mav.addObject("city", City.getCity());
        mav.addObject("district", DistrictsByCityUtils.getDistrictsByCity(buildingDTO));
        mav.addObject("typeCode", TypeCode.getTypeCode());

        return mav;
    }

    @GetMapping(value = "/admin/building/edit/{id}")
    public ModelAndView editBuilding(@PathVariable("id") Long id, HttpServletRequest request) {
        ModelAndView mav = new ModelAndView("admin/building/edit");
        BuildingDTO buildingDTO = buildingService.findById(id);
        mav.addObject("editBuilding", buildingDTO);

        mav.addObject("listStaff", userService.getStaffs());
        mav.addObject("city", City.getCity());
        mav.addObject("district", DistrictsByCityUtils.getDistrictsByCity(buildingDTO));
        mav.addObject("typeCode", TypeCode.getTypeCode());
        return mav;
    }

    @GetMapping("/admin/building/districts")
    @ResponseBody
    public Map<String, String> getDistrictsByCity(@RequestParam("city") String cityName) {
        City city = City.valueOf(cityName);
        return District.getDistrictsByCity(city);
    }
}
