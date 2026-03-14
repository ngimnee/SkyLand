<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp" %>
<c:url var="changePasswordAPI" value="/api/user/change-password"/>
<c:url var="changePasswordURL" value="/admin/profile/change-password"/>
<c:url var="homeURL" value='/admin/home'/>

<!DOCTYPE html>
<html>
<head>
    <title>Đổi mật khẩu</title>
</head>
<body>
    <div class="container-fluid px-4">
        <div class="d-flex justify-content-between align-items-center">
            <h3 class="fw-bold mb-0">
                <i class="bi bi-shield-lock me-2 text-primary"></i>
                Đổi mật khẩu
            </h3>
        </div>

        <nav class="mt-1 mb-4">
            <ol class="breadcrumb mb-0 small">
                <li class="breadcrumb-item text-muted">
                    <i class="bi bi-person"></i> Hồ sơ
                </li>
                <li class="breadcrumb-item active">
                    Đổi mật khẩu
                </li>
            </ol>
        </nav>

        <div class="row justify-content-center">
            <div class="col-lg-7">
                <div class="card shadow-sm">
                    <div class="card-header fw-semibold">
                        <i class="bi bi-key me-2"></i>Thay đổi mật khẩu tài khoản
                    </div>

                    <div class="card-body">
                        <c:if test="${not empty messageResponse}">
                            <div class="alert alert-${alert}">
                                ${messageResponse}
                            </div>
                        </c:if>

                        <form id="formChangePassword">
                            <div class="row mb-4">
                                <label class="col-sm-4 col-form-label">
                                    Mật khẩu cũ<span class="text-danger">*</span>
                                </label>

                                <div class="col-sm-8">
                                    <input type="password" class="form-control" id="oldPassword" name="oldPassword" placeholder="Nhập mật khẩu cũ">
                                </div>
                            </div>

                            <div class="row mb-4">
                                <label class="col-sm-4 col-form-label">
                                    Mật khẩu mới<span class="text-danger">*</span>
                                </label>

                                <div class="col-sm-8">
                                    <input type="password" class="form-control" id="newPassword" name="newPassword" placeholder="Nhập mật khẩu mới">
                                </div>
                            </div>

                            <div class="row mb-4">
                                <label class="col-sm-4 col-form-label">
                                    Nhập lại mật khẩu<span class="text-danger">*</span>
                                </label>

                                <div class="col-sm-8">
                                    <input type="password" class="form-control" id="confirmPassword" name="confirmPassword" placeholder="Nhập lại mật khẩu mới">
                                </div>
                            </div>

                            <input type="hidden" value="${model.id}" id="userId"/>

                            <div class="text-center mb-3">
                                <button type="button" class="btn btn-success px-4 me-2" id="btnChangePassword">
                                    <i class="bi bi-check-circle"></i> Đổi mật khẩu
                                </button>

                                <button type="button" class="btn btn-outline-secondary px-4" id="btnCancel">
                                    <i class="bi bi-x-circle"></i> Hủy
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
            $('#btnCancel').click(function () {
                window.history.back();
            });

            $('#btnChangePassword').click(function () {
                if ($("#formChangePassword").valid()) {
                    let formData = $('#formChangePassword').serializeArray();
                    let data = {};

                    $.each(formData, function (i, v) {
                        data[v.name] = v.value;
                    });
                    changePassword(data, $('#userId').val());
                }
            });

            $("#formChangePassword").validate({
                rules: {
                    oldPassword: "required",
                    newPassword: {
                        required: true,
                        minlength: 6
                    },
                    confirmPassword: {
                        required: true,
                        equalTo: "#newPassword"
                    }
                },
                messages: {
                    oldPassword: "Vui lòng nhập mật khẩu cũ",
                    newPassword: {
                        required: "Vui lòng nhập mật khẩu mới",
                        minlength: "Mật khẩu phải có ít nhất 6 ký tự"
                    },
                    confirmPassword: {
                        required: "Vui lòng nhập lại mật khẩu",
                        equalTo: "Mật khẩu xác nhận không khớp"
                    }
                }
            });
        });

        function changePassword(data, id) {
            $.ajax({
                url: '${changePasswordAPI}/' + id,
                type: 'PUT',
                contentType: 'application/json',
                data: JSON.stringify(data),
                success: function (res) {
                    if (res === 'update_success') {
                        alert("Đổi mật khẩu thành công");
                        window.location.href = "${homeURL}?message=change_password_success";
                    }
                    else if (res === 'change_password_fail') {
                        alert("Thay đổi mật khẩu thất bại.");
                        window.location.href = "${changePasswordURL}?message=change_password_fail";
                    }
                    else if (res === 'old_password_incorrect') {
                        alert("Mật khẩu cũ không đúng.");
                        window.location.href = "${changePasswordURL}?message=change_password_fail";
                    }
                    else if (res === 'password_same_old') {
                        alert("Mật khẩu mới không được trùng mật khẩu cũ");
                    }
                    else {
                        alert(res);
                    }
                },
                error: function () {
                    window.location.href = "${changePasswordURL}?message=error_system";
                }
            });
        }
    </script>
</body>
</html>