<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="orderURL" value='/admin/order'/>
<c:url var="orderAPI" value='/api/order'/>

<html>
<head>
    <title>Đơn Hàng</title>
</head>
<body>
    <div class="container-fluid px-4">
        <div class="mb-4 border-bottom pb-2">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="fw-bold mb-0">
                    <i class="bi bi-receipt me-2 text-primary"></i>Danh sách đơn hàng
                </h3>
            </div>
            <nav class="mt-1">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item text-muted">Quản lý</li>
                    <li class="breadcrumb-item active">Đơn hàng</li>
                </ol>
            </nav>
        </div>

        <form:form id="listForm" modelAttribute="orderSearch" action="${orderURL}" method="GET">
            <div class="row mt-0 mb-2">
                <div class="col-md-12 d-flex justify-content-end">
                    <div class="search-box-sm">
                        <form:input path="code" class="search-input-sm" placeholder="Nhập mã đơn hàng..." />
                        <button type="submit" class="search-btn-sm" id="btnSearchOrder">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </form:form>

        <!-- Bảng danh sách -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="table-responsive">
                    <form:form id="orderListForm">
                        <display:table name="orderList.listResult"
                                requestURI="${orderURL}"
                                id="order"
                                class="table table-striped table-bordered align-middle text-start"
                                cellspacing="0" cellpadding="0"
                                export="false"
                                pagesize="${orderList.maxPageItems}"
                                partialList="true"
                                size="${orderList.totalItems}"
                                defaultsort="1" defaultorder="ascending">

                        <display:column title="STT" headerClass="text-center" class="text-center">
                            ${order_rowNum}
                        </display:column>

                        <display:column title="Ngày tạo" headerClass="text-center" class="text-center" style="width:170px; white-space:nowrap;">
                            <fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy HH:mm:ss"/>
                        </display:column>
                        <display:column property="code" title="Mã đơn hàng" headerClass="text-center" class="text-center"/>
                        <display:column property="buildingName" title="Tên tòa nhà" headerClass="text-center" class="text-justify"/>
                        <display:column property="name" title="Khách hàng" headerClass="text-center" class="text-justify" style="white-space:nowrap;"/>
                        <display:column property="phone" title="SĐT" headerClass="text-center" class="text-center"/>
                        <display:column property="email" title="Email" headerClass="text-center" class="text-center"/>
                        <display:column title="Đã cọc" headerClass="text-center" class="text-center" style="white-space:nowrap;">
                            <fmt:formatNumber value="${order.amount}" type="number"/> VNĐ
                        </display:column>
<%--                        <display:column property="amount" title="Thanh toán" headerClass="text-center" />--%>
                        <display:column title="Trạng thái" headerClass="text-center" class="text-center">
                            <c:choose>
                                <c:when test="${order.status == 'PROCESSING'}">
                                    <span class="badge bg-warning text-dark rounded-pill fs-7 px-3 py-2">Đang xử lý</span>
                                </c:when>
                                <c:when test="${order.status == 'COMPLETED'}">
                                    <span class="badge bg-success rounded-pill fs-7 px-3 py-2">Hoàn thành</span>
                                </c:when>
                                <c:when test="${order.status == 'CANCELLED'}">
                                    <span class="badge bg-danger rounded-pill fs-7 px-3 py-2">Đã hủy</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="badge bg-secondary">${order.status}</span>
                                </c:otherwise>
                            </c:choose>
                        </display:column>
                        <display:column property="paymentMethod" title="PT thanh toán" headerClass="text-center" class="text-center"/>

                        <!-- Cột thao tác -->
                        <display:column title="Thao tác" headerClass="text-center" class="text-center" style="width:120px; white-space:nowrap;">
                            <div class="d-flex justify-content-center gap-1">
                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button" class="btn btn-outline-success btn-sm" title="Giao đơn hàng" onclick="assignmentOrder(${order.id})">
                                        <i class="bi bi-arrow-left-right"></i>
                                    </button>
                                </security:authorize>

                               <button type="button" class="btn btn-outline-primary btn-sm" onclick="openEditOrder(${order.id})" title="Cập nhật">
                                    <i class="bi bi-pencil-square"></i>
                                </button>

                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button" class="btn btn-outline-danger btn-sm" title="Xóa" onclick="deleteOrder(${order.id})">
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

    <!-- Modal -->
    <div class="modal fade" id="assignmentOrderModal" tabindex="-1" aria-labelledby="assignmentOrderModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-center w-100" id="assignmenOrderModalLabel">Danh Sách Nhân Viên</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <table class="table table-bordered text-center" id="staffList">
                        <thead>
                        <tr>
                            <th>Chọn</th>
                            <th>Tên nhân viên</th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                    <input type="hidden" id="orderId" name="orderId" value="">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="btnAssignmentOrder">Giao</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="editOrderModal">
        <div class="modal-dialog modal-dialog-centered modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">
                        <i class="bi bi-pencil-square me-2"></i> Cập nhật đơn hàng
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <form id="formEdit">
                        <div class="row g-3">
                            <div class="col-md-6">
                                <label class="form-label">Họ và tên<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="name">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">SĐT<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="phone">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Email</label>
                                <input type="text" class="form-control" name="email">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Địa chỉ<span class="text-danger">*</span></label>
                                <input type="text" class="form-control" name="address">
                            </div>

                            <div class="col-md-12">
                                <label class="form-label">Ghi chú</label>
                                <input type="text" class="form-control" name="note">
                            </div>

                            <div class="col-md-6">
                                <label class="form-label">Trạng thái<span class="text-danger">*</span></label>
                                <select class="form-select" name="status">
                                    <c:forEach var="item" items="${listStatus}">
                                        <option value="${item.key}">${item.value}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <input type="hidden" name="id" id="editOrderId">
                    </form>
                </div>

                <div class="modal-footer">
                    <button type="button" class="btn btn-success px-4" id="btnUpdateOrder">
                        <i class="bi bi-check-circle"></i> Cập nhật
                    </button>

                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                        Đóng
                    </button>
                </div>
            </div>
        </div>
    </div>


    <script>
        $('#btnSearchOrder').click(function(e) {
            e.preventDefault();
            $('#listForm').submit();
        });

        // Hàm mở modal
        function assignmentOrder(orderId) {
            var modalEl = document.getElementById('assignmentOrderModal');
            var myModal = new bootstrap.Modal(modalEl);
            myModal.show();
            $('#orderId').val(orderId);
            loadStaff(orderId);
        }

        function loadStaff(orderId) {
            $.ajax({
                type: "GET",
                url: "${orderAPI}/" + orderId + '/staffs',
                dataType: "JSON",
                success: function(response) {
                    var row = "";
                    $.each(response.data, function (index, item){
                        row += '<tr>';
                        row += '<td class="text-center">'
                            + '<input type="checkbox" '
                            + 'value="' + item.staffId + '" '
                            + 'class="check-box-element" '
                            + (item.checked ? 'checked' : '')
                            + '>'
                            + '</td>';
                        row += '<td class="text-center">' + item.fullName + '</td>';
                        row += '</tr>';
                    });
                    $('#staffList tbody').html(row);
                    console.info("Success");
                },
                error: function(response) {
                    console.info("Failed");
                    window.location.href = '<c:url value="/admin/order?message=error" />';
                    console.log(response);
                }
            });
        }

        $('#btnAssignmentOrder').click(function(e) {
            e.preventDefault();
            var data = {};
            data['orderId'] = $('#orderId').val();
            var staffs = $('#staffList')
                .find('tbody input[type=checkbox]:checked')
                .map(function() {
                    return $(this).val();
                }).get();

            if (staffs.length === 0) {
                alert("⚠️ Vui lòng chọn ít nhất một nhân viên quản lý!");
                return;
            }

            data['staffs'] = staffs;
            if (data['staffs'] != '') {
                assignment(data);
            }else
            {
                window.location.href="<c:url value = "${orderURL}?message=staff_required" />";
            }
        });

        function assignment(data) {
            $.ajax({
                type: "PUT",
                url: "${orderAPI}",
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "JSON",
                success: function (response)
                {
                    console.info("Success", response);
                    alert("✅ Giao thành công!");
                    location.reload()
                    //window.location.href="<c:url value = "${orderURL}?message=success"/>";
                },

                error: function (response)
                {
                    console.error("Error", response);
                    alert("❌ Giao thất bại!");
                    window.location.href="<c:url value = "${orderURL}?message=error"/>";
                }
            })
        }

        $('#assignmentOrderModal').on('show.bs.modal', function () {
            var orderId = $('#orderId').val();
            if (orderId) {
                loadStaff(orderId);
            }
        });


        function deleteOrder(id) {
            if (confirm("Bạn có chắc muốn xóa đơn hàng này không?")) {
                $.ajax({
                    type: "DELETE",
                    url: "${orderAPI}/" + id,
                    success: function() {
                        alert("✅ Xóa thành công!");
                        location.reload();
                    },
                    error: function(xhr) {
                        console.error("❌ Lỗi khi xóa:", xhr);
                        alert("❌ Xóa thất bại!");
                    }
                });
            }
        }

        function openEditOrder(id){
            $('#editOrderId').val(id);
            $.ajax({
                type: "GET",
                url: "${orderAPI}/" + id,
                success: function(response){
                    var data = response;
                    $('[name="name"]').val(data.name);
                    $('[name="phone"]').val(data.phone);
                    $('[name="email"]').val(data.email);
                    $('[name="address"]').val(data.address);
                    $('[name="note"]').val(data.note);
                    $('[name="status"]').val(data.status);
                    var modal = new bootstrap.Modal(document.getElementById('editOrderModal'));
                    modal.show();
                },
                error: function(){
                    alert("Không lấy được dữ liệu đơn hàng!");
                }
            });
        }

        $('#btnUpdateOrder').click(function(){
            var name = $('[name="name"]').val().trim();
            var phone = $('[name="phone"]').val().trim();
            var address = $('[name="address"]').val().trim();
            var status = $('[name="status"]').val();
            if(name === '' || phone === '' || address === '' || status === ''){
                alert("⚠️ Vui lòng nhập đầy đủ các trường bắt buộc!");
                return;
            }

            var data = {};
            $.each($('#formEdit').serializeArray(), function (i, v) {
                data[v.name] = v.value;
            });

            $.ajax({
                type: "POST",
                url: "${orderAPI}",
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "json",
                success: function(){
                    alert("✅ Cập nhật thành công!");
                    location.reload();
                },
                error: function(){
                    alert("❌ Cập nhật thất bại!");
                }
            });
        });

    </script>
</body>
</html>
