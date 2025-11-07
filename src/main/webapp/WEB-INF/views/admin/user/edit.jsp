<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="userAPI" value='/api/user'/>
<c:url var="userURL" value='/admin/user'/>

<html>
<head>
    <title>Tài Khoản</title>
</head>
<body>
<div class="container-fluid px-4">
    <h1 class="mt-4">Tài Khoản</h1>
    <ol class="breadcrumb mb-4">
        <c:choose>
            <c:when test="${empty model.id}">
                <li class="breadcrumb-item active">Thêm mới</li>
            </c:when>
            <c:otherwise>
                <li class="breadcrumb-item active">Cập nhật thông tin</li>
            </c:otherwise>
        </c:choose>
    </ol>

    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <c:choose>
                        <c:when test="${empty model.id}">
                            <span><i class="bi bi-person-fill-add"></i> Thêm mới tài khoản</span>
                        </c:when>
                        <c:otherwise>
                            <span><i class="bi bi-person-fill-check"></i> Cập nhật thông tin tài khoản</span>
                        </c:otherwise>
                    </c:choose>
                    <a href="${userURL}" class="text-decoration-none">
                        <i class="bi bi-x-circle"></i>
                    </a>
                </div>

                <div class="card-body">
                    <form:form id="formEdit" modelAttribute="model">
                        <!-- USERNAME -->
                        <div class="row mb-3 align-items-center">
                            <label class="col-xl-2 col-form-label">Username<span class="text-danger">*</span></label>
                            <div class="col-xl-10">
                                <c:choose>
                                    <c:when test="${empty model.id}">
                                        <form:input class="form-control" path="userName" placeholder="Nhập username..." />
                                    </c:when>
                                    <c:otherwise>
                                        <form:input class="form-control" path="userName" readonly="true"/>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- PASSWORD -->
                        <div class="row mb-3 align-items-center">
                            <label class="col-xl-2 col-form-label">Password<span class="text-danger">*</span></label>
                            <div class="col-xl-10">
                                <c:choose>
                                    <c:when test="${empty model.id}">
                                        <form:password class="form-control" path="password" placeholder="Nhập mật khẩu..." />
                                    </c:when>
                                    <c:otherwise>
                                        <form:password class="form-control" path="password" readonly="true" />
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>

                        <!-- CONFIRM PASSWORD -->
                        <c:if test="${empty model.id}">
                            <div class="row mb-3 align-items-center">
                                <label class="col-xl-2 col-form-label">Xác nhận mật khẩu<span class="text-danger">*</span></label>
                                <div class="col-xl-10">
                                    <input type="password" class="form-control" id="confirmPassword" placeholder="Nhập lại mật khẩu" required />
                                </div>
                            </div>
                        </c:if>

                        <!-- HỌ TÊN -->
                        <div class="row mb-3 align-items-center">
                            <label class="col-xl-2 col-form-label">Họ tên<span class="text-danger">*</span></label>
                            <div class="col-xl-10">
                                <form:input class="form-control" path="fullName" placeholder="Nhập họ tên..." />
                            </div>
                        </div>

                        <!-- SĐT -->
                        <div class="row mb-3 align-items-center">
                            <label class="col-xl-2 col-form-label">SĐT<span class="text-danger">*</span></label>
                            <div class="col-xl-10">
                                <form:input class="form-control" path="phone" placeholder="Nhập số điện thoại..." />
                            </div>
                        </div>

                        <!-- EMAIL -->
                        <div class="row mb-3 align-items-center">
                            <label class="col-xl-2 col-form-label">Email</label>
                            <div class="col-xl-10">
                                <form:input class="form-control" path="email" placeholder="Nhập email..." />
                            </div>
                        </div>

                        <!-- TRẠNG THÁI + VAI TRÒ (chỉ MANAGER) -->
                        <security:authorize access="hasRole('MANAGER')">
                            <div class="row mb-3 align-items-center">
                                <label class="col-xl-2 col-form-label">Trạng thái</label>
                                <div class="col-xl-10">
                                    <form:select class="form-select" path="status">
                                        <form:option value="1">Hoạt động</form:option>
                                        <form:option value="0">Ngưng hoạt động</form:option>
                                    </form:select>
                                </div>
                            </div>

                            <div class="row mb-3 align-items-center">
                                <label class="col-xl-2 col-form-label">Vai trò</label>
                                <div class="col-xl-10">
                                    <form:select class="form-select" path="roleCode">
                                        <form:option value="">--- Chọn vai trò ---</form:option>
                                        <form:option value="MANAGER">Quản lý</form:option>
                                        <form:option value="STAFF">Nhân viên</form:option>
                                        <form:option value="USER">Người dùng</form:option>
                                    </form:select>
                                </div>
                            </div>
                        </security:authorize>

                        <!-- NÚT -->
                        <div class="d-flex gap-2 mt-3">
                            <button type="submit" class="btn btn-success flex-fill" id="btnAddOrUpdateUser">
                                <c:choose>
                                    <c:when test="${empty model.id}">
                                        <i class="bi bi-person-add"></i> Thêm mới
                                    </c:when>
                                    <c:otherwise>
                                        <i class="bi bi-person-check"></i> Cập nhật
                                    </c:otherwise>
                                </c:choose>
                            </button>
                            <button type="button" class="btn btn-danger flex-fill" id="btnCancel">Hủy</button>
                        </div>

                        <form:hidden path="id" id="userId"/>
                    </form:form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    $('#btnAddOrUpdateUser').click(function (e) {
        e.preventDefault();
        if (!validateRequiredFields()) return;

        const data = {};
        $.each($('#formEdit').serializeArray(), function (i, v) {
            data[v.name] = v.value;
        });

        const password = $('[name="password"]').val();
        const confirm = $('#confirmPassword').val();
        if (confirm && password !== confirm) {
            alert("❌ Mật khẩu xác nhận không khớp!");
            $('#confirmPassword').addClass('is-invalid');
            return;
        }

        const id = $('#userId').val();
        const url = id ? '${userAPI}/' + id : '${userAPI}';

        $.ajax({
            type: 'POST',
            url: url,
            data: JSON.stringify(data),
            contentType: "application/json",
            success: function () {
                window.location.href = "<c:url value='${userURL}?message=success'/>";
            },
            error: function (xhr) {
                console.error("❌ Lỗi khi lưu:", xhr);
                window.location.href = "<c:url value='${userURL}?message=error'/>";
            }
        });
    });

    function validateRequiredFields() {
        const requiredFields = ['userName', 'fullName', 'phone'];
        if (!$('#userId').val()) requiredFields.push('password');
        let isValid = true;
        $('.is-invalid').removeClass('is-invalid');

        requiredFields.forEach(name => {
            const el = $('[name="' + name + '"]');
            const val = el.val()?.trim();
            if (!val) {
                el.addClass('is-invalid');
                isValid = false;
            }
        });
        return isValid;
    }

    $('#btnCancel').click(() => window.location.href = "${userURL}");
</script>
</body>
</html>
