package com.ngimnee.repository.custom.impl;

import com.ngimnee.builder.CustomerSearchBuilder;
import com.ngimnee.entity.CustomerEntity;
import com.ngimnee.model.response.CustomerSearchResponse;
import com.ngimnee.repository.custom.CustomerRepositoryCustom;
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
public class CustomerRepositoryImpl implements CustomerRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    public static void joinTable(CustomerSearchBuilder customerSearchBuilder, StringBuilder sql) {
        Long staffId = customerSearchBuilder.getStaffId();
        if(NumberUtils.isNumber(staffId)) {
            sql.append(" INNER JOIN assignmentcustomer ac ON ac.customerid = customer.id ");
        }
    }

    public static void queryNormal(CustomerSearchBuilder customerSearchBuilder, StringBuilder where) {
        try{
            Field[] fields = CustomerSearchBuilder.class.getDeclaredFields();

            for (Field item : fields) {
                item.setAccessible(true);
                String fieldName = item.getName();

                if(!fieldName.equals("staffId")) {
                    Object valueObject = item.get(customerSearchBuilder);
                    if(valueObject != null) {
                        String value =  valueObject.toString();
                        if(StringUtils.check(value)) {
                            if(NumberUtils.isLong(value) || NumberUtils.isInteger(value)) {
                                where.append(" AND customer." + fieldName + " = " + value);
                            } else {
                                where.append(" AND customer." + fieldName + " LIKE '%" + value + "%' ");
                            }
                        }
                    }
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public static void querySpecial(CustomerSearchBuilder customerSearchBuilder, StringBuilder where) {
        Long staffId = customerSearchBuilder.getStaffId();
        if(NumberUtils.isNumber(staffId)) {
            where.append(" AND ac.staffid = " + staffId);
        }
    }

    @Override
    public List<CustomerEntity> findCustomers(CustomerSearchBuilder customerSearchBuilder, Pageable pageable) {
        StringBuilder sql = new StringBuilder("SELECT * FROM customer ");
        StringBuilder where = new StringBuilder("WHERE 1 = 1 ");

        joinTable(customerSearchBuilder, sql);
        queryNormal(customerSearchBuilder, where);
        querySpecial(customerSearchBuilder, where);
        sql.append(where);

        Query query = entityManager.createNativeQuery(sql.toString(), CustomerEntity.class);
        return query.getResultList();
    }

    @Override
    public int countTotalItem(CustomerSearchResponse customerSearchResponse) {
        String sql = buildQueryFilter(customerSearchResponse.getId());
        Query query = entityManager.createNativeQuery(sql);
        return query.getResultList().size();
    }

    private String buildQueryFilter(Long id) {
        String sql = " SELECT * FROM customer WHERE customer.id = " + id;
        return sql;
    }
}
