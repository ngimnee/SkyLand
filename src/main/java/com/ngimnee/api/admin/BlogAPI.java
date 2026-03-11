package com.ngimnee.api.admin;

import com.ngimnee.entity.BlogEntity;
import com.ngimnee.model.response.BlogResponse;
import com.ngimnee.service.BlogService;
import lombok.RequiredArgsConstructor;
import org.springframework.data.domain.Page;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/blog")
@RequiredArgsConstructor
public class BlogAPI {
    private final BlogService blogService;

    @GetMapping
    public Page<BlogResponse> getBlogs(@RequestParam("title") String title,
                                       @RequestParam(value = "pageSize", defaultValue = "12") int pageSize,
                                       @RequestParam(value = "pageNumber", defaultValue = "0") int pageNumber) {
        Page<BlogResponse> result = blogService.getBlog(title, pageSize, pageNumber);
        return result;
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<BlogEntity> deleteBlog(@PathVariable Long id) {
        return ResponseEntity.ok(blogService.deleteBlog(id));
    }
}
