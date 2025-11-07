<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="orderAPI" value='/api/order' />
<c:url var="orderURL" value='/admin/order' />
<%--<c:url var="editOrderURL" value='/admin/order/edit' />--%>

<html>
<head>
    <title>Đơn Hàng</title>
</head>
<body>
    <div class="container-fluid px-4">
        <h1 class="mt-4">Đơn Hàng</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">Cập nhật đơn hàng</li>
        </ol>
        <div class="row">
            <div class="col-xl-12">
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-person-fill-check"></i> Cập nhật đơn hàng</span>
                        <a href="${orderURL}">
                            <i class="bi bi-x-circle"></i>
                        </a>
                    </div>

                    <div class="collapse show" id="searchForm">
                        <div class="card-body">
                            <form:form id="formEdit" modelAttribute="editOrder" method="GET">
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">
                                        Họ và tên<span class="text-danger">*</span>
                                    </label>
                                    <div class="col-xl-10">
                                        <form:input class="form-control" path="name" />
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">
                                        SĐT<span class="text-danger">*</span>
                                    </label>
                                    <div class="col-xl-10">
                                        <form:input class="form-control" path="phone" />
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">Email</label>
                                    <div class="col-xl-10">
                                        <form:input class="form-control" path="email" />
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">Địa chỉ</label>
                                    <div class="col-xl-10">
                                        <form:input class="form-control" path="address" />
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">Ghi chú</label>
                                    <div class="col-xl-10">
                                        <form:input class="form-control" path="note" />
                                    </div>
                                </div>
                                <div class="row mb-3 align-items-center">
                                    <label class="col-xl-2 col-form-label">
                                        Trạng thái đơn hàng<span class="text-danger">*</span>
                                    </label>
                                    <div class="col-xl-10">
                                        <form:select class="form-control" path="status">
                                            <form:options items="${listStatus}" />
                                        </form:select>
                                    </div>
                                </div>

                                <div class="d-flex gap-2">
                                    <button type="submit" class="btn btn-success flex-fill" id="btnUpdateOrder">
                                        <i class="bi bi-bag-check"></i> Cập nhật đơn hàng
                                    </button>
                                    <button type="button" class="btn btn-danger flex-fill" id="btnCancel">
                                        Hủy
                                    </button>
                                </div>



                                <form:hidden path="id" id="orderId" />
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

<%--        <div class="d-flex align-items-center">--%>
<%--          <hr class="flex-grow-1">--%>
<%--          <span class="mx-2 text-muted">HOẶC</span>--%>
<%--          <hr class="flex-grow-1">--%>
<%--        </div>--%>

<%--        <div class="d-flex justify-content-center gap-3 mb-4">--%>
<%--            <a type="submit" class="btn btn-primary flex-fill" href="web/list">--%>
<%--                <i class="bi bi-bag-plus"></i> Thêm đơn hàng mới--%>
<%--            </a>--%>
<%--        </div>--%>
    </div>

    <script>

        $('#btnUpdateOrder').click(function (e) {
            e.preventDefault();
            if (!validateRequiredFields()) return;

            var data = {}

            $.each($('#formEdit').serializeArray(), function (i, v) {
               data[v.name] = v.value;
            });
            updateOrder(data);

            function updateOrder() {
                $.ajax({
                    type: 'POST',
                    url: '${orderAPI}',
                    data: JSON.stringify(data),
                    contentType: "application/json",
                    dataType: "json",
                    success: function(respond) {
                        alert("Cập nhật thành công!");
                        window.location.reload();
                        window.location.href = "${orderURL}";
                    },
                    error: function(respond) {
                        console.log("Failed");
                        window.location.href = "<c:url value='${orderURL}?message=error'/>";
                        console.log(respond);
                        alert("Cập nhật thất bại!");
                    }
                });
            }
        });

        function validateRequiredFields() {
            const requiredFields = [
                { name: 'name', label: 'Họ tên' },
                { name: 'phone', label: 'SĐT' }
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
            window.location.href = "${orderURL}";
        });
    </script>
</body>
</html>
