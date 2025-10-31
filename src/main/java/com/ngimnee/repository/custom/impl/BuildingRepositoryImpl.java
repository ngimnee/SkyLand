package com.ngimnee.repository.custom.impl;

import com.ngimnee.builder.BuildingSearchBuilder;
import com.ngimnee.entity.BuildingEntity;
import com.ngimnee.model.response.BuildingSearchResponse;
import com.ngimnee.repository.custom.BuildingRepositoryCustom;
import com.ngimnee.utils.NumberUtils;
import com.ngimnee.utils.StringUtils;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;

@Repository
public class BuildingRepositoryImpl implements BuildingRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    public static void joinTable(BuildingSearchBuilder buildingSearchBuilder, StringBuilder sql) {
        Long staffId = buildingSearchBuilder.getStaffId();
        if(NumberUtils.isNumber(staffId)) {
            sql.append(" INNER JOIN assignmentbuilding ab ON b.id = ab.buildingid ");
        }
    }

    public static void queryNormal(BuildingSearchBuilder buildingSearchBuilder, StringBuilder where) {
        try {
            Field[] fields = BuildingSearchBuilder.class.getDeclaredFields();

            for (Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();

                if (!fieldName.equals("staffId") && !fieldName.equals("typeCode") && !fieldName.startsWith("rentArea")
                        && !fieldName.startsWith("rentPrice")) {
                    Object valueObject = item.get(buildingSearchBuilder);

                    if (valueObject != null) {
                        String value = item.get(buildingSearchBuilder).toString();

                        if (StringUtils.check(value)) {
                            if (NumberUtils.isLong(value) || NumberUtils.isInteger(value)) {
                                where.append(" AND b." + fieldName + " = " + value);
                            } else {
                                where.append(" AND b." + fieldName + " like '%" + value + "%' ");
                            }
                        }
                    }
                }
            }

            if (buildingSearchBuilder.getTypeCode() != null && !buildingSearchBuilder.getTypeCode().isEmpty()) {
                where.append(" AND (");
                int i = 0;
                for (String typeCode : buildingSearchBuilder.getTypeCode()) {
                    if (i > 0) where.append(" OR ");
                    where.append(" b.type LIKE '%" + typeCode + "%' ");
                    i++;
                }
                where.append(") ");
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
    }

    public static void querySpecial(BuildingSearchBuilder buildingSearchBuilder, StringBuilder where) {
        Long staffId = buildingSearchBuilder.getStaffId();
        if (NumberUtils.isNumber(staffId)) {
            where.append(" AND ab.staffid = " + staffId);
        }
        Long rentAreaTo = buildingSearchBuilder.getRentAreaTo();
        Long rentAreaFrom = buildingSearchBuilder.getRentAreaFrom();

        if (NumberUtils.isNumber(rentAreaFrom) || NumberUtils.isNumber(rentAreaTo)) {
            where.append(" AND EXISTS (SELECT * FROM rentarea ra where b.id = ra.buildingid ");
            if (NumberUtils.isNumber(rentAreaFrom)) {
                where.append(" AND ra.value >= " + rentAreaFrom);
            }
            if (NumberUtils.isNumber(rentAreaTo)) {
                where.append(" AND ra.value <= " + rentAreaTo);
            }
            where.append(") ");
        }

        Long rentPriceTo = buildingSearchBuilder.getRentPriceTo();
        Long rentPriceFrom = buildingSearchBuilder.getRentPriceFrom();
        if (NumberUtils.isNumber(rentPriceFrom) || NumberUtils.isNumber(rentPriceTo)) {
            if (NumberUtils.isNumber(rentPriceFrom)) {
                where.append(" AND b.rentPrice >= " + rentPriceFrom);
            }
            if (NumberUtils.isNumber(rentPriceTo)) {
                where.append(" AND b.rentPrice <= " + rentPriceTo);
            }
        }
    }

    public static void groupByQuery(BuildingSearchBuilder buildingSearchBuilder, StringBuilder where)
    {
        where.append(" GROUP BY b.id ");
        if(buildingSearchBuilder.getStaffId() != null) {
            where.append(" , ab.id; ");
        }
    }

    @Override
    public List<BuildingEntity> findBuilding(BuildingSearchBuilder buildingSearchBuilder, Pageable pageable)
    {
        StringBuilder sql = new StringBuilder(" SELECT * FROM building b ");
        StringBuilder where = new StringBuilder(" WHERE 1 = 1 ");

        joinTable(buildingSearchBuilder, sql);
        queryNormal(buildingSearchBuilder, where);
        querySpecial(buildingSearchBuilder, where);

        groupByQuery(buildingSearchBuilder, where);
        sql.append(where);

        Query query = entityManager.createNativeQuery(sql.toString(), BuildingEntity.class);
        return query.getResultList();
    }

    @Override
    public int countTotalItem(BuildingSearchResponse buildingSearchResponse) {
        String sql = buildQueryFilter(buildingSearchResponse.getId());
        Query query = entityManager.createNativeQuery(sql);
        return query.getResultList().size();
    }

    private String buildQueryFilter(Long id) {
        String sql = "SELECT * FROM building b WHERE b.id = " + id;
        return sql;
    }
}
