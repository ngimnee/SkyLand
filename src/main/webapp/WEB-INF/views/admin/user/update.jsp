<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="userAPI" value='/api/user'/>
<c:url var="userURL" value='/admin/user'/>

<!DOCTYPE html>
<html>
<head>
    <title>Cập Nhật Tài Khoản</title>
</head>
<body>
<div class="container-fluid px-4">
    <h1 class="mt-4">Tài Khoản</h1>
    <ol class="breadcrumb mb-4">Cập nhật tài khoản</ol>

    <div class="row">
        <div class="col-xl-12">
            <div class="card mb-4">
                <div class="card-header d-flex justify-content-between align-items-center">
                    <span>Cập nhật vai trò</span>
                    <a href="${userURL}" class="text-danger"><i class="bi bi-x-circle"></i></a>
                </div>
                <div class="card-body">
                    <form:form id="formEdit" modelAttribute="model" method="POST">
                        <input type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}"/>

                        <!-- TÀI KHOẢN -->
                        <div class="row mb-3 align-items-center">
                            <label class="col-sm-3 col-form-label">Tài Khoản <span class="text-danger">*</span></label>
                            <div class="col-sm-9 d-flex align-items-center gap-2">
                                <!-- Dropdown -->
                                <form:select path="userName" class="form-select w-50" id="userSelect">
                                    <form:option value="">-- Chọn tài khoản --</form:option>
                                    <c:forEach var="users" items="${userList}">
                                        <form:option value="${users.userName}">
                                            ${users.fullName} (${users.roleName})
                                        </form:option>
                                    </c:forEach>
                                    <form:option value="other">Khác...</form:option>
                                </form:select>

                                <!-- Ô nhập username khác (luôn trùng dòng, cùng hàng) -->
                                <input type="text" id="customUserName" name="customUserName"
                                       class="form-control w-50" placeholder="Nhập username khác"
                                       style="display:none;"/>
                            </div>
                        </div>

                        <!-- HỌ TÊN -->
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Họ tên</label>
                            <div class="col-sm-9">
                                <form:input path="fullName" class="form-control" id="fullName" readonly="true"/>
                            </div>
                        </div>

                        <!-- ROLE -->
                        <div class="row mb-3">
                            <label class="col-sm-3 col-form-label">Vai trò <span class="text-danger">*</span></label>
                            <div class="col-sm-9">
                                <security:authorize access="hasRole('MANAGER')">
                                    <form:select path="roleCode" class="form-select" id="roleSelect">
                                        <form:option value="">-- Chọn vai trò --</form:option>
                                        <c:forEach var="role" items="${model.roleDTOs}">
                                            <form:option value="${role.key}">${role.value}</form:option>
                                        </c:forEach>
                                    </form:select>
                                </security:authorize>
                            </div>
                        </div>

                        <form:hidden path="id" id="userId"/>

                        <!-- BUTTONS -->
                        <div class="row mt-4">
                            <div class="col-sm-9 offset-sm-3">
                                <button type="button" class="btn btn-primary me-2" id="btnSave">
                                    <i class="fa-solid fa-circle-check me-1"></i> Cập nhật
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

<script>
$(document).ready(function () {
    const select = $('#userSelect');
    const customInput = $('#customUserName');
    const fullNameInput = $('#fullName');
    const userId = $('#userId');
    const roleSelect = $('#roleSelect');

    // Khi chọn tài khoản
    select.on('change', function () {
        const selected = $(this).val();

        if (selected === 'other') {
            // Hiện ô nhập trùng hàng luôn
            customInput.show().val('');
            fullNameInput.val('');
            userId.val('');
            roleSelect.val('');
        } else if (selected) {
            customInput.hide().val('');
            $.ajax({
                url: '${userAPI}/detail?userName=' + selected,
                type: 'GET',
                dataType: 'json',
                success: function (res) {
                    if (!res || !res.id) {
                        Swal.fire({ icon: 'error', title: 'Không tồn tại!', text: 'Username không tồn tại.' });
                        fullNameInput.val('');
                        userId.val('');
                        roleSelect.val('');
                        return;
                    }
                    fullNameInput.val(res.fullName || '');
                    userId.val(res.id || '');

                    // Highlight role hiện tại
                    if (res.roleCode) {
                        roleSelect.val(res.roleCode);
                    } else {
                        roleSelect.val('');
                    }
                },
                error: function () {
                    Swal.fire({ icon: 'error', title: 'Lỗi!', text: 'Không tìm thấy tài khoản!' });
                    fullNameInput.val('');
                    userId.val('');
                    roleSelect.val('');
                }
            });
        } else {
            customInput.hide().val('');
            fullNameInput.val('');
            userId.val('');
            roleSelect.val('');
        }
    });

    // Khi nhập username “Khác” → kiểm tra tồn tại
    customInput.on('blur', function () {
        const username = $(this).val().trim();
        if (username) {
            $.ajax({
                url: '${userAPI}/detail?userName=' + username,
                type: 'GET',
                dataType: 'json',
                success: function (res) {
                    if (!res || !res.id) {
                        Swal.fire({ icon: 'error', title: 'Không tồn tại!', text: 'Username không tồn tại trong hệ thống.' });
                        fullNameInput.val('');
                        userId.val('');
                        roleSelect.val('');
                        return;
                    }
                    fullNameInput.val(res.fullName || '');
                    userId.val(res.id || '');
                    roleSelect.val(res.roleCode || '');
                },
                error: function () {
                    Swal.fire({ icon: 'error', title: 'Không tồn tại!', text: 'Username không tồn tại trong hệ thống.' });
                    fullNameInput.val('');
                    userId.val('');
                    roleSelect.val('');
                }
            });
        }
    });

    // Nút Hủy
    $('#btnCancel').click(() => window.location.href = '${userURL}');

    // Nút Lưu
    $('#btnSave').click(function () {
        if (!validateForm()) return;

        const data = {};
        $('#formEdit').serializeArray().forEach(item => data[item.name] = item.value);

        if (data.userName === 'other' && data.customUserName) {
            data.userName = data.customUserName.trim();
        }

        const id = $('#userId').val();
        const url = id ? '${userAPI}/' + id : '${userAPI}';

        $.ajax({
            url: url,
            type: 'PUT',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function () {
                Swal.fire({
                    icon: 'success',
                    title: 'Thành công!',
                    text: 'Cập nhật tài khoản thành công!',
                    timer: 2000,
                    showConfirmButton: false
                }).then(() => {
                    window.location.href = '${userURL}?message=success';
                });
            },
            error: function (xhr) {
                const msg = xhr.responseJSON?.message || xhr.responseText || 'Hệ thống lỗi!';
                Swal.fire({ icon: 'error', title: 'Lỗi!', text: msg });
            }
        });
    });

    // Validate
    function validateForm() {
        const role = $('#roleSelect').val();
        const user = $('#userSelect').val();
        const custom = $('#customUserName').val();

        if ((!user || (user === 'other' && !custom.trim())) || !role) {
            Swal.fire({
                icon: 'warning',
                title: 'Thiếu thông tin!',
                text: 'Vui lòng chọn hoặc nhập tài khoản và vai trò.'
            });
            return false;
        }
        return true;
    }
});
</script>
</body>
</html>
