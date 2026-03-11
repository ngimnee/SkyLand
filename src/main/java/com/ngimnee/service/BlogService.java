package com.ngimnee.service;

import com.ngimnee.entity.BlogEntity;
import com.ngimnee.model.response.BlogResponse;
import org.springframework.data.domain.Page;

public interface BlogService {
    Page<BlogResponse> getBlog(String title, int pageSize, int pageNumber);
    void addOrUpdateBlog(Long id);
    BlogEntity deleteBlog(Long id);
}
