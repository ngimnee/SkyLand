<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="userAPI" value='/api/user'/>
<c:url var="userURL" value='/admin/user'/>
<!DOCTYPE html>
<html>
<head>
    <title>Cập Nhật</title>
</head>
<body>
    <div class="container-fluid px-4">
        <div class="d-flex justify-content-between align-items-center">
            <h3 class="fw-bold mb-0">
                <i class="bi bi-person-badge me-2 text-primary"></i>Tài khoản
            </h3>
        </div>
        <nav class="mt-1 mb-4">
            <ol class="breadcrumb mb-0 small">
                <li class="breadcrumb-item text-muted"><i class="bi bi-gear"></i> Quản lý</li>
                <li class="breadcrumb-item active">Cập nhật vai trò</li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-lg-8">
                <div class="card mb-4">
                    <div class="card-header fw-semibold">
                        <i class="bi bi-person-gear me-2"></i>
                        Cập nhật vai trò người dùng
                    </div>

                    <div class="card-body">
                        <form id="formUpdate">
                            <!-- SELECT USER -->
                            <div class="row mb-3 align-items-center">
                                <label class="col-sm-3 col-form-label">
                                    Tài khoản <span class="text-danger">*</span>
                                </label>

                                <div class="col-sm-9 d-flex gap-2">
                                    <select class="form-select" id="userSelect">
                                        <option value="">-- Chọn tài khoản --</option>
                                        <c:forEach var="u" items="${userList}">
                                            <option value="${u.userName}">
                                                ${u.fullName} (${u.roleName})
                                            </option>
                                        </c:forEach>
                                        <option value="other">Khác</option>
                                    </select>

                                    <input type="text" id="userName" class="form-control" placeholder="Nhập username" style="display:none;">

                                    <button type="button" id="backToSelect" class="btn btn-outline-secondary" style="display:none;">
                                        <i class="bi bi-arrow-left"></i>
                                    </button>

                                </div>
                            </div>

                            <!-- USERNAME -->
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Username</label>
                                <div class="col-sm-9">
                                    <input type="text" id="usernameDisplay" class="form-control bg-light" readonly>
                                </div>
                            </div>

                            <!-- FULLNAME -->
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">Họ tên</label>

                                <div class="col-sm-9">
                                    <input type="text" id="fullName" class="form-control bg-light" readonly>
                                </div>
                            </div>

                            <!-- ROLE -->
                            <div class="row mb-3">
                                <label class="col-sm-3 col-form-label">
                                    Vai trò <span class="text-danger">*</span>
                                </label>

                                <div class="col-sm-9">
                                    <select class="form-select" id="roleSelect">
                                        <option value="">-- Chọn vai trò --</option>
                                        <c:forEach var="r" items="${model.roleDTOs}">
                                            <option value="${r.key}">
                                                ${r.value}
                                            </option>
                                        </c:forEach>
                                    </select>
                                </div>
                            </div>

                            <input type="hidden" id="userId">

                            <!-- BUTTON -->
                            <div class="text-center mt-4">
                                <button type="button" class="btn btn-success px-4 me-2" id="btnSave">
                                    <i class="bi bi-check-circle"></i>Cập nhật
                                </button>

                                <button type="button" class="btn btn-outline-secondary px-4" id="btnCancel">
                                    <i class="bi bi-x-circle"></i>Hủy
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
    $(document).ready(function () {
        const CSRF_TOKEN = '${_csrf.token}';

        const $userSelect = $('#userSelect');
        const $userName = $('#userName');
        const $backToSelect = $('#backToSelect');
        const $fullName = $('#fullName');
        const $userId = $('#userId');
        const $roleSelect = $('#roleSelect');
        const $btnSave = $('#btnSave');

        function reset() {
            $('#usernameDisplay').val('');
            $userName.val('');
            $fullName.val('');
            $userId.val('');
            $roleSelect.val('');
        }

        function loadUser(username) {
            $.get('${userAPI}/detail', { userName: username })
                .done(res => {
                    if (!res?.id) {
                        Swal.fire('Không tồn tại!', 'Tài khoản này không có trong hệ thống.', 'error');
                        reset();
                        return;
                    }
                    $('#usernameDisplay').val(res.userName || '');
                    $fullName.val(res.fullName || '');
                    $userId.val(res.id);
                    $roleSelect.val(res.roleCode || '');
                })
                .fail(() => {
                    Swal.fire('Lỗi!', 'Không kết nối được server!', 'error');
                    reset();
                });
        }

        $userSelect.on('change', function() {
            const v = this.value;
            if (v === 'other') {
                $userSelect.hide();
                $userName.show().focus();
                $backToSelect.show();
                reset();
            } else if (v) {
                $('#usernameDisplay').val(v);
                loadUser(v);
            } else {
                reset();
            }
        });

        $backToSelect.on('click', () => {
            $userName.hide().val('');
            $backToSelect.hide();
            $userSelect.show().val('');
            reset();
        });

        $userName.on('blur', function() {
            const u = this.value.trim();
            if (u) loadUser(u);
        });

        $userName.on('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                const u = this.value.trim();
                if (u) loadUser(u);
            }
        });

        $btnSave.on('click', function() {
            const selected = $userSelect.val();
            const custom = $userName.val().trim();
            const username = selected === 'other' ? custom : selected;
            const roleCode = $roleSelect.val();
            const id = $userId.val();

            if (!username || !roleCode || !id) {
                Swal.fire('Thiếu!', 'Vui lòng chọn đầy đủ thông tin!', 'warning');
                return;
            }

            $btnSave.prop('disabled', true).html('<span class="spinner-border spinner-border-sm"></span> Đang lưu...');

            $.ajax({
                url: '${userAPI}',
                type: 'PUT',
                contentType: 'application/json',
                headers: {
                    'X-CSRF-TOKEN': CSRF_TOKEN
                },
                data: JSON.stringify({
                    id: id,
                    userName: username,
                    roleCode: roleCode
                }),
                timeout: 10000, // Tối đa 10s
                success: function() {
                    Swal.fire({
                        icon: 'success',
                        title: 'THÀNH CÔNG!',
                        text: 'Vai trò đã được cập nhật thành công!',
                        timer: 1500,
                        showConfirmButton: true
                    }).then(() => {
                        location.reload();
                        <%--window.location.href = '${userURL}?message=update_success';--%>
                    });
                },

                error: function(xhr) {
                    const msg = xhr.responseJSON?.message || xhr.responseText || 'Lỗi hệ thống! Vui lòng thử lại.';
                    Swal.fire('Thất bại!', msg, 'error');
                    $btnSave.prop('disabled', false).html('<i class="bi bi-check-circle"></i> Cập nhật');
                }
            });
        });

        $('#btnCancel').on('click', () => window.location.href = '${userURL}');
    });
    </script>
</body>
</html>