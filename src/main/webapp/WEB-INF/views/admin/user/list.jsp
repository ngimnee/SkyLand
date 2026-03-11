<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="userAPI" value='/api/user'/>
<c:url var="userURL" value='/admin/user'/>
<c:url var="editUserURL" value="/admin/user/edit"/>
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
        <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#searchModal">
            <i class="fas fa-search me-1"></i> Tìm kiếm
        </button>

        <a href="${editUserURL}" class="btn btn-success">
            <i class="bi bi-person-plus me-1"></i> Thêm tài khoản
        </a>

        <security:authorize access="hasRole('MANAGER')">
            <button id="btnDeleteUsers" type="button" class="btn btn-danger">
                <i class="bi bi-trash me-1"></i> Xóa đã chọn
            </button>
        </security:authorize>
    </div>

    <!-- Bảng danh sách -->
    <div class="card mb-4">
        <div class="card-body">
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
                    <display:column title="Ngày" headerClass="text-center" class="text-center">
                        <c:choose>
                            <c:when test="${not empty user.modifiedDate}">
                                <fmt:formatDate value="${user.modifiedDate}" pattern="dd/MM/yyyy"/>
                            </c:when>
                            <c:otherwise>
                                <fmt:formatDate value="${user.createdDate}" pattern="dd/MM/yyyy"/>
                            </c:otherwise>
                        </c:choose>
                    </display:column>

                    <display:column property="userName" title="Tài khoản" headerClass="text-center" class="text-center"/>
                    <display:column property="fullName" title="Họ tên" headerClass="text-center" class="text-center"/>
                    <display:column property="phone" title="SĐT" headerClass="text-center" class="text-center"/>
                    <display:column property="email" title="Email" headerClass="text-center" class="text-center"/>

<%--                    <security:authorize access="hasRole('MANAGER')">--%>
<%--                        <display:column title="Trạng thái" headerClass="text-center" class="text-center">--%>
<%--                            <c:choose>--%>
<%--                                <c:when test="${user.status == 1}">Hoạt động</c:when>--%>
<%--                                <c:otherwise>Ngưng hoạt động</c:otherwise>--%>
<%--                            </c:choose>--%>
<%--                        </display:column>--%>

<%--                        <display:column property="roleCode" title="Vai trò" headerClass="text-center"/>--%>
<%--                    </security:authorize>--%>

                    <!-- Cột thao tác -->
                    <display:column title="Thao tác" headerClass="text-center" class="text-center">
                        <div class="d-flex justify-content-center gap-2">
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
</script>
</body>
</html>
