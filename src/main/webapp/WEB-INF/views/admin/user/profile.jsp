<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="profileAPI" value="/api/user/profile"/>
<c:url var="homeURL" value="/admin/home"/>

<html>
<head>
    <title>Thông tin cá nhân</title>
</head>
<body>
    <div class="container-fluid px-4">
        <div class="mb-4 border-bottom pb-2">
            <h3 class="fw-bold">
                <i class="bi bi-person-circle text-primary me-2"></i>
                Thông tin cá nhân
            </h3>
        </div>

        <c:if test="${not empty messageResponse}">
            <div class="alert alert-${alert} alert-dismissible fade show">
                ${messageResponse}
                <button class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="row">
            <div class="col-md-4">
                <div class="card shadow-sm profile-card">
                    <div class="card-body">
                        <img src="https://ui-avatars.com/api/?name=${model.fullName}&background=random" class="profile-avatar mb-3"/>
                        <h5 class="fw-bold">${model.fullName}</h5>
                        <p class="text-muted">@${model.userName}</p>

                        <div class="mt-2">
                            <c:choose>
                                <c:when test="${model.isActive == 1}">
                                    <span class="badge bg-success badge-status">🟢 Đang hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-danger badge-status">🔴 Không hoạt động</span>
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <hr>

                        <div class="profile-info text-start">
                            <p><i class="bi bi-telephone text-success me-2"></i>${model.phone}</p>
                            <p><i class="bi bi-envelope text-primary me-2"></i>${model.email}</p>
                            <p><i class="bi bi-gender-ambiguous text-info me-2"></i>${model.genderName}</p>
                            <p><i class="bi bi-cake text-danger me-2"></i><fmt:formatDate value="${model.birthday}" pattern="dd/MM/yyyy"/></p>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm mt-3">
                    <p class="mb-0 text-danger" id="deactivateAccount">Đóng tài khoản</p>
                </div>
            </div>

            <div class="col-md-8">
                <div class="card shadow-sm">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <strong>Cập nhật thông tin</strong>
                        <a href="${homeURL}">
                            <i class="bi bi-x-circle text-danger"></i>
                        </a>
                    </div>
                    <div class="card-body">
                        <form:form id="formEdit" modelAttribute="model">
                            <div class="row mb-3">
                                <label class="col-md-3 col-form-label">Tên đăng nhập</label>
                                <div class="col-md-9">
                                    <form:input path="userName" id="userName" cssClass="form-control readonly-input" readonly="true"/>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-md-3 col-form-label">Họ và tên</label>
                                <div class="col-md-9">
                                    <form:input path="fullName" id="fullName" cssClass="form-control"/>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-md-3 col-form-label">Số điện thoại</label>
                                <div class="col-md-9">
                                    <form:input path="phone" id="phone" cssClass="form-control"/>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <label class="col-md-3 col-form-label">Email</label>
                                <div class="col-md-9">
                                    <form:input path="email" id="email" cssClass="form-control"/>
                                </div>
                            </div>

                            <div class="row mb-4">
                                <label class="col-md-3 col-form-label">Sinh nhật</label>
                                <div class="col-md-9">
                                    <form:input path="birthday" id="birthday" type="date" cssClass="form-control"/>
                                </div>
                            </div>

                            <div class="row mb-3">
                                <label class="col-md-3 col-form-label">Giới tính</label>
                                <div class="col-md-9">
                                    <form:select path="gender" id="gender" cssClass="form-select">
                                        <form:option value="">-- Chọn giới tính --</form:option>
                                        <form:options items="${genders}" itemValue="code" itemLabel="label"/>
                                    </form:select>
                                </div>
                            </div>

                            <div class="text-end">
                                <button type="button" class="btn btn-primary" id="btnUpdateUser">
                                    <i class="bi bi-save me-1"></i>Cập nhật
                                </button>

                                <button type="button" class="btn btn-danger me-2" id="btnCancel">
                                    <i class="bi bi-x-circle me-1"></i>Hủy
                                </button>
                            </div>
                            <form:hidden path="id" id="userId"/>
                            <form:hidden path="userName" id="usernameHidden"/>
                        </form:form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $("#btnUpdateUser").click(function (event) {
            event.preventDefault();
            var dataArray = {};

            dataArray["fullName"] = $('#fullName').val();
            dataArray["phone"] = $('#phone').val();
            dataArray["email"] = $('#email').val();
            dataArray["gender"] = $('#gender').val();
            dataArray["birthday"] = $('#birthday').val();

            if ($('#userId').val() != "") {
                updateInfo(dataArray, $('#usernameHidden').val());
            }
        });


        function updateInfo(data, username) {
            $.ajax({
                url: '${profileAPI}/' + username,
                type: 'PUT',
                dataType: 'json',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function () {
                    Swal.fire({
                        icon: 'success',
                        title: 'Thành công',
                        text: 'Cập nhật thông tin thành công!',
                        timer: 1500,
                        showConfirmButton: true
                    }).then(() => {
                        window.location.href = "<c:url value='/admin/profile?message=update_success'/>";
                    });
                },
                error: function () {
                    Swal.fire({
                        icon: 'error',
                        title: 'Thất bại',
                        text: 'Cập nhật thông tin thất bại!',
                        confirmButtonText: 'Đóng'
                    });
                }
            });
        }

        $("#btnCancel").click(function () {
            window.location.href = "${homeURL}";
        });

        $("#deactivateAccount").click(function () {
            Swal.fire({
                icon: 'warning',
                text: 'Vui lòng liên hệ Bộ phận quản lý để hủy kích hoạt tài khoản.',
                confirmButtonText: 'Đã hiểu',
                position: 'top',
                width: '550px'
            });
        });
    </script>
</body>
</html>
