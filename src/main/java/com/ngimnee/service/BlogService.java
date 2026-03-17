package com.ngimnee.service;

import com.ngimnee.entity.BlogEntity;
import com.ngimnee.model.response.BlogResponse;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;

import java.util.Date;
import java.util.List;

public interface BlogService {
    Page<BlogResponse> getBlog(Date fromDate, Date toDate, Pageable pageable);
    int countTotalItem(List<BlogResponse> list);
    void addOrUpdateBlog(Long id);
    BlogEntity deleteBlog(Long id);
}
