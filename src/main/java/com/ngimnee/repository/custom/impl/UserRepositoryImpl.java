package com.ngimnee.repository.custom.impl;

import com.ngimnee.builder.UserSearchBuilder;
import com.ngimnee.entity.UserEntity;
import com.ngimnee.repository.custom.UserRepositoryCustom;
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
public class UserRepositoryImpl implements UserRepositoryCustom {
    @PersistenceContext
    private EntityManager entityManager;

    @Override
    public List<UserEntity> findUsers(UserSearchBuilder builder, Pageable pageable) {
        StringBuilder sql = new StringBuilder("SELECT * FROM user ");
        StringBuilder where = new StringBuilder(" WHERE 1 = 1 ");

        queryNormal(builder, where);
        querySpecial(builder, where);
        groupByQuery(builder, where);
        sql.append(where);
        sql.append(" ORDER BY user.createddate DESC ");

        Query query = entityManager.createNativeQuery(sql.toString(), UserEntity.class);
        return query.getResultList();
    }

    @Override
    public int countTotalItem() {
        String sql = buildQueryFilter();
        Query query = entityManager.createNativeQuery(sql.toString());
        return query.getResultList().size();
    }


    public static void queryNormal(UserSearchBuilder builder, StringBuilder where) {
        try {
            Field[] fields = UserSearchBuilder.class.getDeclaredFields();
            for (Field field : fields) {
                field.setAccessible(true);
                String name = field.getName();
                if ("roleId".equals(name) || "roleCode".equals(name)) continue;

                Object valueObj = field.get(builder);
                if (valueObj != null) {
                    String value = valueObj.toString();
                    if (StringUtils.check(value)) {
                        if (NumberUtils.isLong(value) || NumberUtils.isInteger(value)) {
                            if (name.equals("isActive")) {
                                where.append(" AND user.is_active").append(" = ").append(value);
                            } else {
                                where.append(" AND user.").append(name).append(" = ").append(value);
                            }
                        } else {
                            where.append(" AND user.").append(name).append(" LIKE '%").append(value).append("%'");
                        }
                    }
                }
            }
        } catch (IllegalAccessException e) {
            e.printStackTrace();
        }
    }

    public static void querySpecial(UserSearchBuilder builder, StringBuilder where) {
        Long roleId = builder.getRoleId();
        if (roleId != null) {
            where.append(" AND ur.role_id = " + roleId);
        }
    }

    public static void groupByQuery(UserSearchBuilder builder, StringBuilder where) {
        where.append(" GROUP BY user.id ");
        if (builder.getRoleId() != null) {
            where.append(" , ur.id ");
        }
    }

    private String buildQueryFilter() {
        String sql = "SELECT * FROM user WHERE user.is_active = 1";
        return sql;
    }
}
