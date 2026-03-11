<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="customerAPI" value='/api/customer' />
<c:url var="customerURL" value='/admin/customer' />
<c:url var="transactionURL" value='/admin/customer/support'/>


<html>
<head>
    <title>Khách Hàng</title>
</head>
<body>
    <div class="container-fluid px-4">
        <div class="mb-4 border-bottom pb-2">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="fw-bold mb-0">
                    <i class="bi bi-people me-2 text-primary"></i>Danh sách khách hàng
                </h3>
            </div>

            <nav class="mt-1">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item text-muted">Quản lý</li>
                    <li class="breadcrumb-item active">Khách hàng</li>
                </ol>
            </nav>
        </div>

        <div class="row mb-3">
            <div class="col-12 d-flex justify-content-between align-items-center">
                <div class="d-flex align-items-center gap-2">
                    <span class="fw-bold">Trạng thái:</span>
                    <form action="${customerURL}" method="GET" class="mb-0">
                        <div class="d-flex gap-1" role="group">
                            <input type="radio" class="btn-check" name="isActive" id="statusAll" value="" onchange="this.form.submit()"${empty param.isActive ? 'checked' : ''}>
                            <label class="btn btn-outline-secondary btn-sm rounded-pill px-3" for="statusAll">Tất cả</label>

                            <input type="radio" class="btn-check" name="isActive" id="statusActive" value="1" onchange="this.form.submit()"${param.isActive == '1' ? 'checked' : ''}>
                            <label class="btn btn-outline-success btn-sm rounded-pill px-3" for="statusActive">Hoạt động</label>

                            <input type="radio" class="btn-check" name="isActive" id="statusInactive" value="0" onchange="this.form.submit()"${param.isActive == '0' ? 'checked' : ''}>
                            <label class="btn btn-outline-danger btn-sm rounded-pill px-3" for="statusInactive">Đã tắt</label>
                        </div>
                    </form>
                </div>

                <div class="d-flex gap-2">
                    <button class="btn btn-outline-primary shadow-sm" data-bs-toggle="modal" data-bs-target="#searchCustomerModal">
                        <i class="fas fa-search me-1"></i> Tìm kiếm
                    </button>

                    <button class="btn btn-success shadow-sm" onclick="addCustomer()">
                        <i class="fas fa-plus me-1"></i> Thêm khách hàng
                    </button>
                </div>
            </div>
        </div>

        <!-- Bảng danh sách tài khoản -->
        <div class="card mb-4">
            <div class="card-body">
                <form:form id="customerListForm">
                    <display:table name="customerList.listResult"
                                requestURI="${customerURL}"
                                id="customer"
                                class="table table-striped table-bordered align-middle text-start"
                                cellspacing="0" cellpadding="0"
                                export="false"
                                pagesize="${customerList.maxPageItems}"
                                partialList="true"
                                size="${customerList.totalItems}"
                                defaultsort="2" defaultorder="ascending">

                        <display:column title="STT" headerClass="text-center" class="text-center">
                            ${customer_offset + customer_rowNum}
                        </display:column>
                        <!-- Cột dữ liệu -->
                        <display:column title="Ngày" headerClass="text-center" class="text-center">
                            <c:if test="${empty customer.modifiedDate}">
                                <fmt:formatDate value="${customer.createdDate}" pattern="dd/MM/yyyy"/>
                            </c:if>
                            <c:if test="${not empty customer.modifiedDate}">
                                <fmt:formatDate value="${customer.modifiedDate}" pattern="dd/MM/yyyy"/>
                            </c:if>
                        </display:column>
                        <display:column property="fullName" title="Họ và tên" headerClass="text-center" class="text-center"/>
                        <display:column property="phone" title="SĐT" headerClass="text-center" class="text-center"/>
                        <display:column property="email" title="Email" headerClass="text-center" class="text-center"/>
                        <display:column property="companyName" title="Công ty" headerClass="text-center" class="text-center"/>
                        <display:column property="demand" title="Yêu cầu" headerClass="text-center" class="text-center"/>
                        <display:column property="status" title="Tình trạng" headerClass="text-center" class="text-center"/>

                        <!-- Cột thao tác -->
                        <display:column title="Thao tác" headerClass="text-center" class="text-center">
                            <div class="d-flex justify-content-center gap-1">
                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button" class="btn btn-outline-success btn-sm" title="Giao khách hàng" onclick="assignmentCustomer(${customer.id})">
                                        <i class="bi bi-arrow-left-right"></i>
                                    </button>
                                </security:authorize>

                                <a href="${transactionURL}/${customer.id}" class="btn btn-outline-primary btn-sm" title="CSKH">
                                    <i class="bi bi-headset"></i>
                                </a>

                                <button type="button" class="btn btn-info btn-sm" onclick="editCustomer(${customer.id})" title="Cập nhật thông tin">
                                    <i class="bi bi-pencil-square"></i>
                                </button>

                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button" class="btn btn-outline-danger btn-sm" title="Xóa" onclick="deleteCustomer(${customer.id})">
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
    <div class="modal fade" id="assignmentCustomerModal" tabindex="-1" aria-labelledby="assignmentCustomerModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-center w-100" id="assignmentCustomerModalLabel">Danh Sách Nhân Viên</h5>
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
                    <input type="hidden" id="customerId" name="customerId" value="">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="btnAssignmentCustomer">Giao khách hàng</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Modal tìm kiếm khách hàng -->
    <div class="modal fade" id="searchCustomerModal" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">Tìm kiếm khách hàng</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">
                    <form:form id="listForm" modelAttribute="customerSearch" action="${customerURL}" method="GET">
                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label>Họ và tên</label>
                                <form:input class="form-control" path="fullName"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-12 mb-3">
                                <label>Công ty</label>
                                <form:input class="form-control" path="companyName"/>
                            </div>
                        </div>

                        <div class="row">
                            <div class="col-md-4 mb-3">
                                <label>SĐT</label>
                                <form:input class="form-control" path="phone"/>
                            </div>

                            <div class="col-md-4 mb-3">
                                <label>Email</label>
                                <form:input class="form-control" path="email"/>
                            </div>

                            <security:authorize access="hasRole('MANAGER')">
                                <div class="col-md-4 mb-3">
                                    <label>Nhân viên</label>
                                    <form:select class="form-control" path="staffId">
                                        <form:option value="">-- Chọn nhân viên --</form:option>
                                        <form:options items="${listStaff}"/>
                                    </form:select>
                                </div>
                            </security:authorize>
                        </div>

                        <div class="text-end">
                            <button type="submit" class="btn btn-primary">
                                <i class="fas fa-search me-1"></i> Tìm kiếm
                            </button>

                            <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">
                                Đóng
                            </button>
                        </div>
                    </form:form>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="customerModal" tabindex="-1">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">

                <div class="modal-header">
                    <h5 class="modal-title" id="customerModalTitle">
                        <i class="bi bi-person-fill-add"></i> Thông tin khách hàng
                    </h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                </div>

                <div class="modal-body">

                    <form id="formEditCustomer">

                        <div class="row mb-3">
                            <label class="col-md-3 col-form-label">
                                Họ và tên<span class="text-danger">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" name="fullName" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-md-3 col-form-label">
                                SĐT<span class="text-danger">*</span>
                            </label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" name="customerPhone" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-md-3 col-form-label">Email</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" name="email">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-md-3 col-form-label">Công ty</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" name="companyName">
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-md-3 col-form-label">Yêu cầu</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" name="demand" required>
                            </div>
                        </div>

                        <div class="row mb-3">
                            <label class="col-md-3 col-form-label">Tình trạng</label>
                            <div class="col-md-9">
                                <input type="text" class="form-control" name="status" required>
                            </div>
                        </div>

                        <input type="hidden" name="id" id="editCustomerId">
                    </form>

                </div>

                <div class="modal-footer">
                    <button class="btn btn-success" id="btnUpdateCustomer">
                        <i class="bi bi-check"></i> Cập nhật
                    </button>
                    <button class="btn btn-secondary" data-bs-dismiss="modal">
                        Hủy
                    </button>
                </div>

            </div>
        </div>
    </div>

    <script>
        $('#btnSearchCustomer').click(function(e) {
            e.preventDefault();
            $('#listForm').submit();
        });

        // Hàm mở modal
        function assignmentCustomer(customerId) {
            var modalEl = document.getElementById('assignmentCustomerModal');
            var myModal = new bootstrap.Modal(modalEl);
            myModal.show();
            $('#customerId').val(customerId);
            loadStaff(customerId);
        }

        function loadStaff(customerId) {
            $.ajax({
                type: "GET",
                url: "${customerAPI}/" + customerId + '/staffs',
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
                    window.location.href = '<c:url value="/admin/customer?message=error" />';
                    console.log(response);
                }
            });
        }

        $('#btnAssignmentCustomer').click(function(e) {
            e.preventDefault();
            var data = {};
            data['customerId'] = $('#customerId').val();
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
                window.location.href="<c:url value = "${customerURL}?message=staff_required" />";
            }
        });

        function assignment(data) {
            $.ajax({
                type: "PUT",
                url: "${customerAPI}",
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "JSON",
                success: function (response)
                {
                    console.info("Success", response);
                    alert("✅ Giao thành công!");
                    location.reload()
                    //window.location.href="<c:url value = "${customerURL}?message=success"/>";
                },

                error: function (response)
                {
                    console.error("Error", response);
                    alert("❌ Giao thất bại!");
                    window.location.href="<c:url value = "${customerURL}?message=error"/>";
                }
            })
        }

        $('#assignmentCustomerModal').on('show.bs.modal', function () {
            var customerId = $('#customerId').val();
            if (customerId) {
                loadStaff(customerId);
            }
        });


        function deleteCustomer(id) {
            if (confirm("Bạn có chắc muốn xóa khách hàng này không?")) {
                $.ajax({
                    type: "DELETE",
                    url: "${customerAPI}/" + id,
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

        function editCustomer(id) {
            $('#customerModalTitle').text("Cập nhật khách hàng");

            $.ajax({
                type: "GET",
                url: "${customerAPI}/" + id,
                dataType: "json",
                success: function(data){
                    $('[name="fullName"]').val(data.fullName);
                    $('[name="customerPhone"]').val(data.customerPhone);
                    $('[name="email"]').val(data.email);
                    $('[name="companyName"]').val(data.companyName);
                    $('[name="demand"]').val(data.demand);
                    $('[name="status"]').val(data.status);
                    $('#editCustomerId').val(data.id);
                    var modal = new bootstrap.Modal(document.getElementById('customerModal'));
                    modal.show();
                }
            });
        }

        $('#btnUpdateCustomer').click(function(){
            if(!validateCustomerForm()){
                return;
            }
            let data = {};
            $.each($('#formEditCustomer').serializeArray(), function(i,v){
                data[v.name] = v.value;
            });

            $.ajax({
                type: "POST",
                url: "${customerAPI}",
                data: JSON.stringify(data),
                contentType: "application/json",
                success: function(){
                    if(data.id){
                        alert("✅ Cập nhật khách hàng thành công");
                    }else{
                        alert("✅ Thêm khách hàng thành công");
                    }
                    location.reload();
                },
                error: function(){
                    alert("❌ Thao tác thất bại");
                }
            });
        });

        function addCustomer(){
            $('#formEditCustomer')[0].reset();
            $('#editCustomerId').val('');
            $('#customerModalTitle').text("Thêm khách hàng");

            var modal = new bootstrap.Modal(document.getElementById('customerModal'));
            modal.show();
        }

        function validateCustomerForm(){
            let fullName = $('#formEditCustomer [name="fullName"]').val().trim();
            let phone = $('#formEditCustomer [name="customerPhone"]').val().trim();
            let demand = $('#formEditCustomer [name="demand"]').val().trim();
            let status = $('#formEditCustomer [name="status"]').val().trim();

            if(fullName === ""){
                alert("⚠️ Vui lòng nhập họ tên");
                return false;
            }
            if(phone === ""){
                alert("⚠️ Vui lòng nhập số điện thoại");
                return false;
            }
            var phoneRegex = /^[0-9]{9,11}$/;
            if(!phoneRegex.test(phone)){
                alert("⚠️ Số điện thoại không hợp lệ");
                return false;
            }
            if(demand === ""){
                alert("⚠️ Vui lòng nhập yêu cầu");
                return false;
            }
            if(status === ""){
                alert("⚠️ Vui lòng nhập tình trạng");
                return false;
            }
            return true;
        }
    </script>
</body>
</html>
