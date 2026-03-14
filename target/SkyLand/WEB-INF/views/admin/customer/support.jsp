<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="transactionAPI" value='/api/transaction'/>
<c:url var="transactionURL" value='/admin/customer/support'/>
<c:url var="customerURL" value='/admin/customer'/>

<html>
<head>
    <title>CSKH</title>
</head>
<body>
    <div class="container-fluid px-4">
        <div class="mb-4 border-bottom pb-2">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="fw-bold mb-0">
                    <i class="bi bi-people me-2 text-primary"></i>Khách hàng
                </h3>
            </div>

            <nav class="mt-1">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item text-muted">Quản lý</li>
                    <li class="breadcrumb-item active">CSKH</li>
                </ol>
            </nav>
        </div>

        <!-- Nút mở modal thêm -->
        <div class="col-12 d-flex mt-3 mb-1">
            <button type="button" class="btn btn-primary btn-sm d-flex align-items-center gap-2 px-4 py-2 rounded-pill shadow-sm" data-bs-toggle="modal" data-bs-target="#noteModal">
                <i class="fa fa-plus"></i>Thêm yêu cầu
            </button>
        </div>

        <!-- Bảng CSKH & Dẫn KH đi xem -->
        <c:forEach var="code" items="${codeList}">
            <div class="card mb-4 shadow-sm">
                <!-- Header -->
                <div class="card-header bg-light fw-semibold">
                    <c:choose>
                        <c:when test="${code.key == 'CSKH'}">CSKH</c:when>
                        <c:when test="${code.key == 'VIEW'}">Dẫn đi xem</c:when>
                        <c:otherwise>${code.value}</c:otherwise>
                    </c:choose>
                </div>

                <div class="card-body p-0">
                    <div class="table-responsive">
                        <form:form id="transactionForm_${code.key}">
                            <table class="table table-bordered table-striped text-center align-middle mb-0">
                                <thead>
                                    <tr>
                                        <th>STT</th>
                                        <th>Ngày</th>
                                        <th>Người tạo</th>
                                        <th>Chi tiết giao dịch</th>
                                        <th>Thao tác</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:choose>
                                        <c:when test="${code.key == 'CSKH'}">
                                            <c:forEach var="supportItem" items="${supports}" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td><fmt:formatDate value="${supportItem.createdDate}" pattern="dd/MM/yyyy"/></td>
                                                    <td>${supportItem.createdBy}</td>
                                                    <td>${supportItem.note}</td>
                                                    <td>
                                                        <a class="btn btn-info btn-sm" title="Cập nhật" onclick="editTransaction(${supportItem.id})">
                                                            <i class="bi bi-pencil-square"></i>
                                                        </a>
                                                        <button type="button" class="btn btn-danger btn-sm" title="Xóa" onclick="deleteTransaction(${supportItem.id})">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty supports}">
                                                <tr>
                                                    <td colspan="5" class="text-center text-muted">Không có hỗ trợ CSKH nào.</td>
                                                </tr>
                                            </c:if>
                                        </c:when>

                                        <c:when test="${code.key == 'VIEW'}">
                                            <c:forEach var="viewItem" items="${views}" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td><fmt:formatDate value="${viewItem.createdDate}" pattern="dd/MM/yyyy"/></td>
                                                    <td>${viewItem.createdBy}</td>
                                                    <td>${viewItem.note}</td>
                                                    <td>
                                                        <a class="btn btn-info btn-sm" onclick="editTransaction(${viewItem.id})">
                                                            <i class="bi bi-pencil-square"></i>
                                                        </a>
                                                        <button type="button" class="btn btn-danger btn-sm" onclick="deleteTransaction(${viewItem.id})">
                                                            <i class="bi bi-trash"></i>
                                                        </button>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                            <c:if test="${empty views}">
                                                <tr>
                                                    <td colspan="5" class="text-center text-muted">Không có hỗ trợ dẫn khách hàng đi xem BĐS nào.</td>
                                                </tr>
                                            </c:if>
                                        </c:when>
                                    </c:choose>
                                </tbody>
                            </table>
                        </form:form>
                    </div>
                </div>
            </div>
        </c:forEach>


        <!-- Modal thêm/chỉnh sửa giao dịch -->
        <div class="modal fade" id="noteModal" tabindex="-1" aria-labelledby="noteModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="noteModalLabel">Chi tiết giao dịch</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                    </div>
                    <div class="modal-body">
                        <form:form id="noteForm" modelAttribute="transactionForm">
                            <form:hidden path="id" id="transactionId"/>
                            <form:hidden path="customerId" value="${customerId}"/>
                            <div class="mb-3">
                                <label for="transactionCode" class="form-label">Loại giao dịch</label>
                                <form:select path="code" class="form-select" id="transactionCode">
                                    <form:options items="${codeList}"/>
                                </form:select>
                            </div>
                            <div class="mb-3">
                                <label for="noteContent" class="form-label">Nội dung</label>
                                <form:textarea path="note" id="noteContent" class="form-control" placeholder="Nhập nội dung..." required="true"/>
                            </div>
                        </form:form>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" form="noteForm" class="btn btn-primary">Lưu</button>
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Hủy</button>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <script>
        function editTransaction(id) {
            $.ajax({
                type: 'GET',
                url: '${transactionAPI}/' + id,
                contentType: "application/json",
                dataType: "json",
                success: function (data) {
                    $('#transactionId').val(data.id);
                    $('#transactionCode').val(data.code);
                    $('#noteContent').val(data.note);

                    const modal = new bootstrap.Modal(document.getElementById('noteModal'));
                    modal.show();
                },
                error: function () {
                    alert('Không lấy được dữ liệu!');
                }
            });
        }

        $('#noteForm').submit(function(e){
            e.preventDefault();
            let formData = {
                id: $('#transactionId').val(),
                code: $('#transactionCode').val(),
                note: $('#noteContent').val(),
                customerId: '${customerId}'
            };
            $.ajax({
                type: 'POST',
                url: "${transactionAPI}",
                data: JSON.stringify(formData),
                contentType: "application/json",
                success: function(){
                    alert('Lưu thành công!');
                    location.reload();
                },
                error: function(){
                    alert('Lưu thất bại!');
                }
            });
        });


        function deleteTransaction(id) {
            if (confirm("Bạn có chắc muốn xóa hỗ trợ này không?")) {
                $.ajax({
                    type: 'DELETE',
                    url: '${transactionAPI}/' + id,
                    success: function () {
                        alert('Xóa thành công!');
                        location.reload();
                    },
                    error: function () {
                        alert('Xóa thất bại!');
                    }
                });
            }
        }
    </script>
</body>
</html>