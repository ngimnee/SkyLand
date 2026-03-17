package com.ngimnee.api.admin;

import com.ngimnee.entity.BlogEntity;
import com.ngimnee.model.response.BlogResponse;
import com.ngimnee.service.BlogService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.Date;

@RestController
@RequestMapping("/api/blog")
@RequiredArgsConstructor
public class BlogAPI {
    private final BlogService blogService;

    @GetMapping
    public Page<BlogResponse> getBlogs(@RequestParam("fromDate") Date fromDate,
                                       @RequestParam("toDate") Date toDate,
                                       Pageable pageable) {
        Page<BlogResponse> result = blogService.getBlog(fromDate, toDate, pageable);
        return result;
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BlogEntity> deleteBlog(@PathVariable Long id) {
        return ResponseEntity.ok(blogService.deleteBlog(id));
    }
}
