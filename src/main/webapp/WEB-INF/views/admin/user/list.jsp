<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="userAPI" value='/api/user'/>
<c:url var="userURL" value='/admin/user'/>
<c:url var="editUserURL" value="/admin/user/edit"/>
<c:url var="resetPasswordAPI" value="/api/user/reset-password"/>

<html>
<head>
    <title>Tài Khoản</title>
</head>
<body>
    <div class="container-fluid px-4">
        <div class="mb-4 border-bottom pb-2">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="fw-bold mb-0">
                    <i class="bi bi-person-badge me-2 text-primary"></i>Danh sách tài khoản
                </h3>
            </div>

            <nav class="mt-1">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item text-muted">Quản lý</li>
                    <li class="breadcrumb-item active">Tài khoản</li>
                </ol>
            </nav>
        </div>

        <div class="card-header d-flex justify-content-end align-items-center gap-2 mt-4 mb-2">
            <button class="btn btn-primary  btn-sm rounded-1" data-bs-toggle="modal" data-bs-target="#searchModal">
                <i class="fas fa-search me-1"></i> Tìm kiếm
            </button>

            <a href="${editUserURL}" class="btn btn-success btn-sm rounded-1">
                <i class="bi bi-person-plus me-1"></i> Thêm tài khoản
            </a>

            <security:authorize access="hasRole('MANAGER')">
                <button id="btnDeleteUsers" type="button" class="btn btn-danger btn-sm rounded-1">
                    <i class="bi bi-trash me-1"></i> Xóa đã chọn
                </button>
            </security:authorize>
        </div>

        <!-- Bảng danh sách -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="table-responsive">
                    <form:form id="userListForm" modelAttribute="model">
                        <display:table name="model.listResult"
                                   requestURI="${userURL}"
                                   id="user"
                                   class="table table-striped table-bordered align-middle text-start"
                                   cellspacing="0" cellpadding="0"
                                   export="false"
                                   pagesize="${model.maxPageItems}"
                                   partialList="true"
                                   size="${model.totalItems}"
                                   defaultsort="2" defaultorder="ascending">

                        <!-- Checkbox chọn -->
                        <display:column title="<input type='checkbox' id='checkAll'/>" headerClass="text-center" class="text-center">
                            <input type="checkbox" name="ids" value="${user.id}" class="checkItem"/>
                        </display:column>

                        <!-- Cột dữ liệu -->
                        <display:column title="Ngày tạo" headerClass="text-center" class="text-center" style="width:170px; white-space:nowrap;">
                            <fmt:formatDate value="${user.createdDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                        </display:column>

                        <display:column property="userName" title="Tài khoản" headerClass="text-center" class="text-center"/>
                        <display:column property="fullName" title="Họ tên" headerClass="text-center" class="text-justify" style="white-space: nowrap;"/>
                        <display:column property="phone" title="SĐT" headerClass="text-center" class="text-center"/>
                        <display:column property="email" title="Email" headerClass="text-center" class="text-justify"/>
                        <display:column title="Vai trò" headerClass="text-center" class="text-center" style="width:150px; white-space:nowrap;">
                            <c:choose>
                                <c:when test="${user.roleName == 'Quản lý'}">
                                    <span class="badge bg-danger" style="font-size:0.8rem; width:80px; display:inline-block;">
                                        ${user.roleName}
                                    </span>
                                </c:when>
                                <c:when test="${user.roleName == 'Nhân viên'}">
                                    <span class="badge bg-primary" style="font-size:0.75rem; width:90px; display:inline-block;">
                                        ${user.roleName}
                                    </span>
                                </c:when>
                                <c:when test="${user.roleName == 'Người dùng'}">
                                    <span class="badge bg-secondary" style="font-size:0.75rem; width:90px; display:inline-block;">
                                        ${user.roleName}
                                    </span>
                                </c:when>
                            </c:choose>
                        </display:column>
                        <display:column title="Ngày sinh" headerClass="text-center" class="text-center" style="width:130px;">
                            <c:if test="${not empty user.birthday}">
                                <fmt:formatDate value="${user.birthday}" pattern="dd/MM/yyyy"/>
                            </c:if>
                        </display:column>
                        <display:column title="Giới tính" headerClass="text-center" class="text-center" style="min-width:100px; max-width:100px; white-space:nowrap;">
                            ${user.genderName}
                        </display:column>
                        <display:column title="Cập nhật lần cuối" headerClass="text-center" class="text-center" style="width:160px; min-width:160px; max-width:160px;">
                            <fmt:formatDate value="${user.modifiedDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                        </display:column>
                        <!-- Cột thao tác -->
                        <display:column title="Thao tác" headerClass="text-center" class="text-center" style="width:120px; white-space:nowrap;">
                            <div class="d-flex justify-content-center gap-2">
                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button" class="btn btn-outline-warning btn-sm" title="Reset mật khẩu" onclick="resetPassword(${user.id})">
                                        <i class="bi bi-key"></i>
                                    </button>
                                </security:authorize>

                                <a href="${editUserURL}?id=${user.id}" class="btn btn-outline-primary btn-sm" title="Chỉnh sửa">
                                    <i class="bi bi-pencil-square"></i>
                                </a>

                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button" class="btn btn-outline-danger btn-sm" title="Xóa người dùng" onclick="deleteUser(${user.id})">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </security:authorize>
                            </div>
                        </display:column>
                    </display:table>
                </form:form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="searchModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="fas fa-search me-2"></i>Tìm kiếm
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <form:form id="listForm" modelAttribute="MODEL" action="${userURL}" method="GET">
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label>Tài khoản</label>
                                <form:input class="form-control" path="userName"/>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label>Họ tên</label>
                                <form:input class="form-control" path="fullName"/>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label>SĐT</label>
                                <form:input class="form-control" path="phone"/>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label>Email</label>
                                <form:input class="form-control" path="email"/>
                            </div>
                        </div>
                    </form:form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        Đóng
                    </button>
                    <button type="button" class="btn btn-primary" id="btnSearchUser">
                        <i class="fas fa-search"></i> Tìm kiếm
                    </button>
                </div>
            </div>
        </div>
    </div>

    <!-- Toast thông báo -->
<div class="position-fixed top-0 end-0 p-3" style="z-index: 9999">
    <div id="permissionToast" class="toast align-items-center text-white bg-danger border-0"
         role="alert" data-bs-delay="3000">
        <div class="d-flex">
            <div class="toast-body">
                ${param.messageResponse}
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>


    <script>
        // Nút tìm kiếm
        $('#btnSearchUser').click(function (e) {
            e.preventDefault();
            $('#listForm').submit();
        });

        // Chọn tất cả
        $('#checkAll').on('change', function () {
            $('.checkItem').prop('checked', this.checked);
        });

        // Xóa 1 người dùng
        function deleteUser(id) {
            if (confirm("Bạn có chắc muốn xóa người dùng này không?")) {
                $.ajax({
                    type: "DELETE",
                    url: "${userAPI}",
                    contentType: "application/json",
                    data: JSON.stringify([id]),
                    success: function () {
                        alert("✅ Xóa thành công!");
                        location.reload();
                    },
                    error: function (xhr) {
                        console.error("❌ Lỗi khi xóa:", xhr);
                        alert("❌ Xóa thất bại!");
                    }
                });
            }
        }

        // Xóa nhiều người dùng
        function deleteUsers() {
            const selectedIds = [];
            $("input[name='ids']:checked").each(function () {
                const val = $(this).val();
                if (val && !isNaN(val)) {
                    selectedIds.push(parseInt(val));
                }
            });

            if (selectedIds.length === 0) {
                alert("⚠️ Vui lòng chọn ít nhất một người dùng để xóa!");
                return;
            }

            if (confirm("Bạn có chắc muốn xóa người dùng đã chọn không?")) {
                $.ajax({
                    type: "DELETE",
                    url: "${userAPI}",
                    contentType: "application/json",
                    data: JSON.stringify(selectedIds),
                    success: function () {
                        alert("✅ Xóa thành công!");
                        location.reload();
                    },
                    error: function (xhr) {
                        console.error("❌ Lỗi khi xóa:", xhr);
                        alert("❌ Xóa thất bại!");
                    }
                });
            }
        }

        // Gắn sự kiện nút xoá nhiều
        $('#btnDeleteUsers').click(function (e) {
            e.preventDefault();
            deleteUsers();
        });

        function resetPassword(id) {
            Swal.fire({
                title: 'Reset mật khẩu?',
                text: 'Mật khẩu sẽ được đặt lại về mặc định!',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Reset',
                cancelButtonText: 'Hủy'
            }).then((result) => {
                if (result.isConfirmed) {
                    $.ajax({
                        url: '${resetPasswordAPI}/' + id,
                        type: 'PUT',
                        success: function (response) {
                            const password = response.defaultPassword;
                            Swal.fire({
                                title: 'Reset thành công!',
                                position: 'top',
                                showConfirmButton: false,
                                customClass: {
                                    popup: 'swal-top-offset'
                                },
                                html: `
                                    <div style="display:flex;justify-content:center;margin-top:15px">
                                        <div style="display:flex; align-items:center; border:1px solid #dee2e6; border-radius:6px; overflow:hidden; background:white;">
                                            <input id="pwdText" value="${password}" readonly style=" border:none; outline:none; padding:4px 10px; font-size:15px; width:120px; height:26px; text-align:center;">
                                            <button id="copyBtn" style="border:none; border-left:1px solid #dee2e6; background:white; padding:4px 10px; cursor:pointer;" title="Copy">
                                                <i class="bi bi-copy"></i>
                                            </button>
                                        </div>
                                    </div>
                                `,
                                didOpen: () => {
                                    document.getElementById("copyBtn").onclick = function () {
                                        navigator.clipboard.writeText(password);
                                        this.innerHTML = '<i class="bi bi-check-lg text-success"></i>';
                                        setTimeout(() => {
                                            this.innerHTML = '<i class="bi bi-copy"></i>';
                                        }, 1500);
                                    };
                                }
                            });
                        },
                        error: function () {
                            Swal.fire('Lỗi!', 'Không thể reset mật khẩu!', 'error');
                        }
                    });
                }
            });
        }

        $(document).ready(function () {
            const message = "${param.messageResponse}";
            if (message && message !== "") {
                const toastEl = document.getElementById('permissionToast');
                const toast = new bootstrap.Toast(toastEl);
                toast.show();
            }
        });
    </script>
</body>
</html>
