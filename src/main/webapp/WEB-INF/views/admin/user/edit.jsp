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
        <h1 class="mt-4">Tài Khoản</h1>
        <ol class="breadcrumb mb-4">
            <c:choose>
                <c:when test="${empty model.id}"><li class="breadcrumb-item active">Thêm tài khoản mới</li></c:when>
                <c:otherwise><li class="breadcrumb-item active">Cập nhật thông tin</li></c:otherwise>
            </c:choose>
        </ol>

        <div class="row">
            <div class="col-xl-12">
                <div class="card mb-4">
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
                            <i class="bi bi-x-circle"></i>
                        </a>
                    </div>

                    <div class="card-body">
                        <form:form id="formEdit" modelAttribute="model" method="POST">
                            <!-- CSRF Token -->
                            <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                            <!-- USERNAME -->
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Username <span class="text-danger">*</span></label>
                                <div class="col-sm-9">
                                    <form:input path="userName" class="form-control"
                                               placeholder="Nhập username..." readonly="${not empty model.id}"/>
                                </div>
                            </div>

                            <!-- FULLNAME -->
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Họ tên <span class="text-danger">*</span></label>
                                <div class="col-sm-9">
                                    <form:input path="fullName" class="form-control" placeholder="Nhập họ tên..." />
                                </div>
                            </div>

                            <!-- PHONE -->
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Số điện thoại <span class="text-danger">*</span></label>
                                <div class="col-sm-9">
                                    <form:input path="phone" class="form-control" placeholder="0909123456..." />
                                </div>
                            </div>

                            <!-- EMAIL -->
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Email</label>
                                <div class="col-sm-9">
                                    <form:input path="email" class="form-control" placeholder="example@gmail.com" />
                                </div>
                            </div>

                            <!-- PASSWORD - Chỉ khi thêm mới -->
                            <c:if test="${empty model.id}">
                                <div class="row mb-3">
                                    <label class="col-sm-3 col-form-label">Mật khẩu <span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <form:password path="password" class="form-control" placeholder="Nhập mật khẩu..." />
                                    </div>
                                </div>
                                <div class="row mb-3">
                                    <label class="col-sm-3 col-form-label">Xác nhận <span class="text-danger">*</span></label>
                                    <div class="col-sm-9">
                                        <input type="password" id="confirmPassword" class="form-control" placeholder="Nhập lại mật khẩu..." />
                                    </div>
                                </div>
                            </c:if>

                            <!-- PASSWORD khi sửa -->
                            <c:if test="${not empty model.id}">
                                <div class="row mb-3">
                                    <label class="col-sm-3 col-form-label">Mật khẩu</label>
                                    <div class="col-sm-9">
                                        <input type="text" class="form-control" value="********" readonly>
                                        <small class="text-muted">Dùng chức năng "Đổi mật khẩu" để thay đổi.</small>
                                    </div>
                                </div>
                                <form:hidden path="password"/>
                            </c:if>

                            <!-- ROLE -->
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Vai trò <span class="text-danger">*</span></label>
                                <div class="col-sm-9">
                                    <security:authorize access="hasRole('STAFF')">
                                        <input type="text" class="form-control" value="USER" readonly>
                                        <small class="text-info">Nhân viên chỉ được tạo tài khoản USER</small>
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
                            </div>

                            <!-- STATUS -->
                            <security:authorize access="hasRole('MANAGER')">
                                <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Trạng thái</label>
                                <div class="col-sm-9">
                                    <form:select path="status" class="form-select">
                                        <form:option value="1">Hoạt động</form:option>
                                        <form:option value="0">Khóa</form:option>
                                    </form:select>
                                </div>
                            </div>
                            </security:authorize>
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
    </div>

    <!-- SweetAlert2 -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                            showConfirmButton: false
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