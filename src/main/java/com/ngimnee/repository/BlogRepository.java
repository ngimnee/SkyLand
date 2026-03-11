package com.ngimnee.repository;

import com.ngimnee.entity.BlogEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface BlogRepository extends JpaRepository<BlogEntity, Long> {
    @Query("SELECT b FROM BlogEntity b WHERE b.status = :status AND b.title LIKE %:title%")
    Page<BlogEntity> findByStatusAndTitle(@Param("status") String status, @Param("title") String title, Pageable pageable);

    Optional<BlogEntity> findById(Long id);
}
