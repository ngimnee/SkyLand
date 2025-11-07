<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="orderURL" value='/admin/order'/>
<c:url var="editOrderURL" value='/admin/order/edit'/>
<c:url var="orderAPI" value='/api/order'/>

<html>
<head>
    <title>Đơn Hàng</title>
</head>
<body>
    <div class="container-fluid px-4">
        <h1 class="mt-4">Đơn Hàng</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">Danh sách đơn hàng</li>
        </ol>

        <form:form id="listForm" modelAttribute="orderSearch" action="${orderURL}" method="GET">
            <div class="row align-items-center">
                <div class="col-auto">
                    <label class="fw-bold mb-3"> Tìm kiếm:</label>
                </div>

                <div class="col mb-3">
                    <div class="input-group">
                        <form:input path="code" class="form-control" placeholder="Nhập đơn hàng hoặc tòa nhà..." />
                        <button type="submit" class="btn btn-primary" id="btnSearchOrder">
                            <i class="fas fa-search"></i>
                        </button>
                    </div>
                </div>
            </div>
        </form:form>

        <!-- Bảng danh sách -->
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="fas fa-table me-1"></i> Danh sách đơn hàng</span>
            </div>
            <div class="card-body">
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
                                defaultsort="2" defaultorder="ascending">

                        <!-- Cột dữ liệu -->
                        <display:column title="Ngày" headerClass="text-center">
                            <c:if test="${empty order.modifiedDate}">
                                <fmt:formatDate value="${order.createdDate}" pattern="dd/MM/yyyy"/>
                            </c:if>
                            <c:if test="${not empty order.modifiedDate}">
                                <fmt:formatDate value="${order.modifiedDate}" pattern="dd/MM/yyyy"/>
                            </c:if>
                        </display:column>
                        <display:column property="code" title="Mã đơn hàng" headerClass="text-center" />
                        <display:column property="buildingName" title="Tên tòa nhà" headerClass="text-center" />
                        <display:column property="name" title="Khách hàng" headerClass="text-center" />
                        <display:column property="phone" title="SĐT" headerClass="text-center" />
                        <display:column property="email" title="Email" headerClass="text-center" />
                        <display:column property="amount" title="Đã cọc" headerClass="text-center" />
                        <display:column property="status" title="Trạng thái" headerClass="text-center" />

                        <!-- Cột thao tác -->
                        <display:column title="Thao tác" headerClass="text-center" class="text-center">
                            <div class="btn-group" role="group">
                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button" class="btn btn-success btn-sm" title="Giao đơn hàng" onclick="assignmentOrder(${order.id})">
                                        <i class="bi bi-arrow-left-right"></i>
                                    </button>
                                </security:authorize>

                                <a href="${editOrderURL}/${order.id}" class="btn btn-info btn-sm" title="Cập nhật">
                                    <i class="bi bi-pencil-square"></i>
                                </a>

                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button" class="btn btn-danger btn-sm" title="Xóa" onclick="deleteOrder(${order.id})">
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
                // data: JSON.stringify(data),
                // contentType: "application/json",
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

    </script>
</body>
</html>
