<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="customerAPI" value='/api/customer' />
<c:url var="customerURL" value='/admin/customer' />
<html>
<head>
    <title>Khách Hàng</title>
</head>
<body>
    <div class="container-fluid px-4">
        <h1 class="mt-4">Khách Hàng</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">Cập nhật thông tin khách hàng</li>
        </ol>
        <div class="row">
            <div class="col-xl-12">
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-person-fill-add"></i> Cập nhật thông tin khách hàng</span>
                        <a href="${customerURL}">
                            <i class="bi bi-x-circle"></i>
                        </a>
                    </div>

                    <div class="collapse show" id="searchForm">
                        <div class="card-body">
                            <form:form id="formEdit" modelAttribute="editCustomer" method="GET">
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">
                                        Họ và tên<span class="text-danger">*</span>
                                    </label>
                                    <div class="col-xl-10">
                                        <form:input class="form-control" path="fullName" required="true" />
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">
                                        SĐT<span class="text-danger">*</span>
                                    </label>
                                    <div class="col-xl-10">
                                        <form:input class="form-control" path="customerPhone" required="true" />
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">Email</label>
                                    <div class="col-xl-10">
                                        <form:input class="form-control" path="email" />
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">Công ty</label>
                                    <div class="col-xl-10">
                                        <form:input class="form-control" path="companyName" />
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">Nhu cầu</label>
                                    <div class="col-xl-10">
                                        <form:input class="form-control" path="demand" />
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">Tình trạng</label>
                                    <div class="col-xl-10">
                                        <form:input class="form-control" path="status" />
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-success flex-fill" id="btnUpdateCustomer">
                                        <i class="bi bi-person-check"></i> Cập nhật khách hàng
                                    </button>
                                    <button type="button" class="btn btn-danger flex-fill" id="btnCancel">
                                        Hủy
                                    </button>
                                </div>

                                <form:hidden path="id" id="customerId" />
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        $('#btnUpdateCustomer').click(function(e) {
            e.preventDefault();
            if (!validateRequiredFields()) return;

            var data = {};

            $.each($('#formEdit').serializeArray(), function(i, v) {
                data[v.name] = v.value;
            });
            updateCustomer(data);

            function updateCustomer() {
                $.ajax({
                    type: "POST",
                    url: "${customerAPI}",
                    data: JSON.stringify(data),
                    contentType: "application/json",
                    dataType: "json",
                    success: function(respond) {
                        window.location.href = "<c:url value='/admin/customer?message=success' />";
                    },
                    error: function(respond) {
                        console.log("Failed");
                        window.location.href = "<c:url value='/admin/customer?message=error' />";
                        console.log(respond);
                    }
                });
            }
        });

        function validateRequiredFields() {
            const requiredFields = [
                { name: 'fullName', label: 'Họ tên' },
                { name: 'customerPhone', label: 'SĐT' }
            ];

            let isValid = true;

            // Xóa hết lỗi cũ trước
            $('.is-invalid').removeClass('is-invalid');

            // Kiểm tra từng trường
            requiredFields.forEach(f => {
                let val = $('[name="' + f.name + '"]').val()?.trim();
                if (!val) {
                    $('[name="' + f.name + '"]').addClass('is-invalid');
                    isValid = false;
                }
            });

            return isValid; // true nếu hợp lệ, false nếu có lỗi
        }

        $('#btnCancel').click(function() {
            window.location.href = "${customerURL}";
        });
    </script>
</body>
</html>
