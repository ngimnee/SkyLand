<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="userAPI" value='/api/user'/>
<c:url var="userURL" value='/admin/user'/>

<!DOCTYPE html>
<html>
<head>
    <title>
        <c:choose>
            <c:when test="${empty model.id}">Thêm Tài Khoản</c:when>
            <c:otherwise>Cập Nhật Tài Khoản</c:otherwise>
        </c:choose>
    </title>
</head>
<body>
    <div class="container-fluid px-4">
        <div class="d-flex justify-content-between align-items-center mb-2">
            <h3 class="fw-bold mb-0">
                <i class="bi bi-person-badge me-2 text-primary"></i>Tài khoản
            </h3>
        </div>

        <nav>
            <ol class="breadcrumb mb-3 small">
            <li class="breadcrumb-item text-muted">Quản lý</li>

            <c:choose>
                <c:when test="${empty model.id}"><li class="breadcrumb-item active">Thêm tài khoản</li></c:when>
                <c:otherwise><li class="breadcrumb-item active">Cập nhật tài khoản</li></c:otherwise>
            </c:choose>
            </ol>
        </nav>

        <div class="card mb-4">
            <div class="col-xl-12">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <div>
                        <c:choose>
                            <c:when test="${empty model.id}">
                                <i class="bi bi-person-plus me-2"></i>Tạo tài khoản mới
                            </c:when>
                            <c:otherwise>
                                <i class="bi bi-person-check me-2"></i>Chỉnh sửa tài khoản
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <a href="${userURL}">
                        <i class="bi bi-x-circle fs-5 text-danger"></i>
                    </a>
                </div>

                <div class="card-body">
                    <form:form id="formEdit" modelAttribute="model" method="POST">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="bi bi-person"></i> Username<span class="text-danger">*</span>
                                </label>
                                <form:input path="userName" class="form-control" placeholder="Nhập username..." readonly="${not empty model.id}"/>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="bi bi-person-badge"></i> Họ tên<span class="text-danger">*</span>
                                </label>
                                <form:input path="fullName" class="form-control" placeholder="Nhập họ tên..." />
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="bi bi-telephone"></i> Số điện thoại<span class="text-danger">*</span>
                                </label>
                                <form:input path="phone" class="form-control" placeholder="0909xxxxxx"/>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="bi bi-envelope"></i> Email
                                </label>
                                <form:input path="email" class="form-control" placeholder="example@gmail.com"/>
                            </div>
                        </div>

                        <c:if test="${empty model.id}">
                            <div class="row g-3 mt-1">
                                <div class="col-md-6">
                                    <label class="form-label">
                                        <i class="bi bi-lock"></i> Mật khẩu<span class="text-danger">*</span>
                                    </label>
                                    <form:password path="password" value="" class="form-control" placeholder="Nhập mật khẩu..."/>
                                </div>

                                <div class="col-md-6">
                                    <label class="form-label">
                                        <i class="bi bi-lock-fill"></i> Xác nhận mật khẩu<span class="text-danger">*</span>
                                    </label>
                                    <input type="password" id="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu..."/>
                                </div>
                            </div>
                        </c:if>

                        <div class="row g-3 mt-1">
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="bi bi-calendar-date"></i> Ngày sinh
                                </label>
                                <form:input path="birthday" type="date" class="form-control"/>
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="bi bi-gender-ambiguous"></i> Giới tính
                                </label>
                                <form:select path="gender" class="form-select">
                                    <form:option value="">-- Chọn giới tính --</form:option>
                                    <form:options items="${genders}" itemValue="code" itemLabel="label"/>
                                </form:select>
                            </div>
                        </div>

                        <div class="row g-3 mt-1">
                            <div class="col-md-6">
                                <label class="form-label">
                                    <i class="bi bi-shield-lock"></i> Vai trò<span class="text-danger">*</span>
                                </label>

                                <security:authorize access="hasRole('STAFF')">
                                    <input type="text" class="form-control" value="USER" readonly>
                                    <small class="text-info">Nhân viên chỉ được tạo USER</small>
                                    <form:hidden path="roleCode" value="USER"/>
                                </security:authorize>

                                <security:authorize access="hasRole('MANAGER')">
                                    <form:select path="roleCode" class="form-select">
                                    <form:option value="">-- Chọn vai trò --</form:option>
                                        <c:forEach var="role" items="${model.roleDTOs}">
                                            <form:option value="${role.key}">${role.value}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </security:authorize>
                            </div>

                            <security:authorize access="hasRole('MANAGER')">
                                <div class="col-md-6">
                                    <c:if test="${not empty model.id}">
                                        <label class="form-label">
                                            <i class="bi bi-toggle-on"></i> Trạng thái
                                        </label>

                                        <form:select path="isActive" class="form-select">
                                            <form:option value="1">Hoạt động</form:option>
                                            <form:option value="0">Khóa</form:option>
                                        </form:select>
                                    </c:if>
                                </div>
                            </security:authorize>
                        </div>
                        <form:hidden path="id" id="userId"/>

                        <!-- BUTTONS -->
                        <div class="row mt-4">
                            <div class="col-sm-9 offset-sm-3">
                                <button type="button" class="btn btn-primary me-2" id="btnSave">
                                    <i class="fas fa-save"></i>
                                    <c:choose><c:when test="${empty model.id}">Thêm mới</c:when><c:otherwise>Cập nhật</c:otherwise></c:choose>
                                </button>
                                <button type="button" class="btn btn-secondary" id="btnCancel">
                                    <i class="fas fa-times"></i> Hủy
                                </button>
                            </div>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

    <script>
        $(document).ready(function () {
            $('#btnSave').click(function () {
                if (!validateForm()) return;

                const data = {};
                $('#formEdit').serializeArray().forEach(item => {
                    data[item.name] = item.value;
                });

                const id = $('#userId').val();
                const url = id ? '${userAPI}/' + id : '${userAPI}';
                const type = id ? 'PUT' : 'POST';

                $.ajax({
                    url: url,
                    type: type,
                    contentType: 'application/json',
                    data: JSON.stringify(data),
                    success: function () {
                        Swal.fire({
                            icon: 'success',
                            title: 'Thành công!',
                            text: id ? 'Cập nhật tài khoản thành công!' : 'Thêm tài khoản thành công!',
                            timer: 2000,
                            showConfirmButton: true
                        }).then(() => {
                            window.location.href = '${userURL}?message=success';
                        });
                    },
                    error: function (xhr) {
                        const msg = xhr.responseJSON?.message || xhr.responseText || 'Hệ thống lỗi!';
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi!',
                            text: msg
                        });
                    }
                });
            });

            $('#btnCancel').click(() => window.location.href = '${userURL}');

            function validateForm() {
                let valid = true;
                $('.is-invalid').removeClass('is-invalid');

                const phone = $('[name="phone"]').val();
                if (phone && !/^[0-9]{9,11}$/.test(phone)) {
                    $('[name="phone"]').addClass('is-invalid');
                    Swal.fire('Lỗi!', 'Số điện thoại không hợp lệ!', 'error');
                    valid = false;
                }

                const required = ['userName', 'fullName', 'phone'];
                if (!$('#userId').val()) {
                    required.push('password');
                }
                // roleCode luôn có giá trị (do hidden hoặc select)
                if (!$('[name="roleCode"]').val()) {
                    required.push('roleCode');
                }

                required.forEach(field => {
                    const el = $('[name="' + field + '"]');
                    if (!el.val()?.trim()) {
                        el.addClass('is-invalid');
                        valid = false;
                    }
                });

                if (!$('#userId').val()) {
                    const pass = $('[name="password"]').val();
                    const confirm = $('#confirmPassword').val();
                    if (pass !== confirm) {
                        $('#confirmPassword').addClass('is-invalid');
                        Swal.fire('Lỗi!', 'Mật khẩu xác nhận không khớp!', 'error');
                        valid = false;
                    }
                }
                return valid;
            }
        });
    </script>
</body>
</html>