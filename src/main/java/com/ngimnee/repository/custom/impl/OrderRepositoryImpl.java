package com.ngimnee.repository.custom.impl;

import com.ngimnee.builder.OrderSearchBuilder;
import com.ngimnee.entity.OrderEntity;
import com.ngimnee.model.response.OrderSearchResponse;
import com.ngimnee.repository.custom.OrderRepositoryCustom;
import com.ngimnee.utils.NumberUtils;
import com.ngimnee.utils.StringUtils;
import org.springframework.data.domain.Pageable;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;
import java.lang.reflect.Field;
import java.util.List;

public class OrderRepositoryImpl implements OrderRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<OrderEntity> findOrders(OrderSearchBuilder orderSearchBuilder, Pageable pageable) {
        StringBuilder sql = new StringBuilder("SELECT * FROM orders ");
        StringBuilder where =  new StringBuilder(" WHERE 1 = 1 ");

        joinTable(orderSearchBuilder, sql);
        queryNormal(orderSearchBuilder, where);
        querySpecial(orderSearchBuilder, where);
        groupByQuery(orderSearchBuilder, where);
        sql.append(where);

        Query query = entityManager.createNativeQuery(sql.toString(), OrderEntity.class);
        return query.getResultList();
    }

    public static void joinTable(OrderSearchBuilder orderSearchBuilder, StringBuilder sql) {
        Long staffId = orderSearchBuilder.getStaffId();
        if(NumberUtils.isNumber(staffId)){
            sql.append(" INNER JOIN assignmentorder ao ON orders.id = ao.orderid ");
        }
//        sql.append(" INNER JOIN building b ON orders.id = b.orderid ");
    }

    public static void queryNormal(OrderSearchBuilder orderSearchBuilder, StringBuilder where) {
        try {
            Field[] fields = OrderSearchBuilder.class.getDeclaredFields();

            for (Field field : fields) {
                field.setAccessible(true);
                String fieldName = field.getName();


                if (!fieldName.equals("staffId")) {
                    Object valueObject = field.get(orderSearchBuilder);
                    if(valueObject != null){
                        String value = valueObject.toString();
                        if(StringUtils.check(value)){
//                            where.append(" AND ( ");
                            if (NumberUtils.isLong(value) || NumberUtils.isInteger(value)) {
                                where.append(" AND orders." + fieldName + " = " + value);
                            }
                            else {
                                where.append(" AND orders." + fieldName + " LIKE '%" + value + "%' ");
                            }
                        }
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void querySpecial(OrderSearchBuilder orderSearchBuilder, StringBuilder where) {
        Long staffId = orderSearchBuilder.getStaffId();
        if(NumberUtils.isNumber(staffId)){
            where.append(" AND ao.staffid = " + staffId);
        }

//        try {
//            Field[] fields = OrderSearchBuilder.class.getDeclaredFields();
//
//            for (Field field : fields) {
//                field.setAccessible(true);
//                String fieldName = field.getName();
//
//                if(!fieldName.equals("staffId")) {
//                    Object valueObject = field.get(orderSearchBuilder);
//                    if(valueObject != null){
//                        String value = valueObject.toString();
//                        if(StringUtils.check(value)) {
//                            where.append(" OR b.name LIKE '%" + value + "%' ");
//                        }
//                        where.append(" ) ");
//                    }
//                }
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
    }

    public static void groupByQuery(OrderSearchBuilder orderSearchBuilder, StringBuilder where)
    {
        where.append(" GROUP BY orders.id ");
        if(orderSearchBuilder.getStaffId() != null) {
            where.append(" , ao.id ");
        }
    }

    @Override
    public int countTotalItem(OrderSearchResponse orderSearchResponse) {
        String sql = buildQueryFilter(orderSearchResponse.getId());
        Query query = entityManager.createNativeQuery(sql);
        return query.getResultList().size();
    }

    private String buildQueryFilter(Long id) {
        String sql = " SELECT * FROM orders WHERE orders.id = " + id;
        return sql;
    }
}
