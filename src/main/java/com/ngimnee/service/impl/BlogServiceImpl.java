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
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import java.util.Calendar;
import java.util.Date;
import java.util.List;

@Service
@RequiredArgsConstructor
public class BlogServiceImpl implements BlogService {
    private final Logger logger = LogManager.getLogger(BlogServiceImpl.class);
    private final BlogRepository blogRepository;
    private final ModelMapper modelMapper;

    @Override
    public Page<BlogResponse> getBlog(Date fromDate, Date toDate, Pageable pageable) {
        try {
            if (toDate != null) {
                Calendar calendar = Calendar.getInstance();
                calendar.setTime(toDate);
                calendar.set(Calendar.HOUR_OF_DAY, 23);
                calendar.set(Calendar.MINUTE, 59);
                calendar.set(Calendar.SECOND, 59);
                calendar.set(Calendar.MILLISECOND, 999);
                toDate = calendar.getTime();
            }
            if (fromDate != null && toDate == null) {
                toDate = new Date();
            }
            Page<BlogEntity> blogs =blogRepository.findByIsActiveAndTitle(1, fromDate, toDate, pageable);
            return blogs.map(blog -> modelMapper.map(blog, BlogResponse.class));
        } catch (Exception e) {
            logger.error("Xảy ra ngoại lệ khi lấy tin tức", e);
            return Page.empty();
        }
    }

    @Override
    public int countTotalItem(List<BlogResponse> list) {
        int res = 0;
        for (BlogResponse it : list) res += blogRepository.countTotalItem(it.getId());
        return res;
    }

    @Override
    public void addOrUpdateBlog(Long id) {

    }

    @Override
    public BlogEntity deleteBlog(Long id) {
        BlogEntity blog = blogRepository.findById(id).orElseThrow(() -> new RuntimeException("Blog not found with id: " + id));
        blog.setIsActive(0);
        blogRepository.save(blog);
        return blog;
    }
}
