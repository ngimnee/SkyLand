package com.ngimnee.service.impl;

import com.ngimnee.entity.BlogEntity;
import com.ngimnee.model.response.BlogResponse;
import com.ngimnee.repository.BlogRepository;
import com.ngimnee.service.BlogService;
import lombok.RequiredArgsConstructor;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.modelmapper.ModelMapper;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class BlogServiceImpl implements BlogService {
    private final Logger logger = LogManager.getLogger(BlogServiceImpl.class);
    private final BlogRepository blogRepository;
    private final ModelMapper modelMapper;

    @Override
    public Page<BlogResponse> getBlog(String title, int pageSize, int pageNumber) {
        try {
            Pageable pageable = PageRequest.of(pageNumber, pageSize);
            Page<BlogEntity> blogs =blogRepository.findByStatusAndTitle("N", title, pageable);
            return blogs.map(blog -> modelMapper.map(blog, BlogResponse.class));
        } catch (Exception e) {
            logger.error("Xảy ra ngoại lệ khi lấy tin tức", e.getMessage());
            return Page.empty();
        }
    }

    @Override
    public void addOrUpdateBlog(Long id) {

    }

    @Override
    public BlogEntity deleteBlog(Long id) {
        BlogEntity blog = blogRepository.findById(id).orElseThrow(() -> new RuntimeException("Blog not found with id: " + id));
        blog.setStatus("N");
        blogRepository.save(blog);
        return blog;
    }
}
