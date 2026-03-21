package com.ngimnee.service;

import com.ngimnee.entity.BlogEntity;
import com.ngimnee.model.dto.BlogDTO;
import com.ngimnee.model.response.BlogResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.web.multipart.MultipartFile;

import java.util.Date;
import java.util.List;

public interface BlogService {
    Page<BlogResponse> getBlog(Date fromDate, Date toDate, Pageable pageable);
    int countTotalItem(List<BlogResponse> list);
    BlogDTO addOrUpdateBlog(BlogDTO blogDTO, MultipartFile avatar);
    BlogEntity deleteBlog(Long id);
    BlogDTO findById(Long id);
}
