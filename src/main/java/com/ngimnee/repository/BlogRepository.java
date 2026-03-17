package com.ngimnee.repository;

import com.ngimnee.entity.BlogEntity;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.Optional;

@Repository
public interface BlogRepository extends JpaRepository<BlogEntity, Long> {
    @Query("SELECT b FROM BlogEntity b " +
            "WHERE b.status = 'Y' " +
            "AND b.isActive = :isActive " +
            "AND (:fromDate IS NULL OR b.publishedTime >= :fromDate) " +
            "AND (:toDate IS NULL OR b.publishedTime <= :toDate) " +
            "ORDER BY b.createdDate DESC")
    Page<BlogEntity> findByIsActiveAndTitle(@Param("isActive") Integer isActive, @Param("fromDate") Date fromDate, @Param("toDate") Date toDate, Pageable pageable);

    Optional<BlogEntity> findById(Long id);

    @Query(value = "SELECT COUNT(*) FROM blog WHERE is_active = 1 AND id = :id", nativeQuery = true)
    int countTotalItem(@Param("id") Long id);
}
