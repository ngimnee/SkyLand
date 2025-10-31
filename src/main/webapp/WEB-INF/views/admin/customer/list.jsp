<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<%--<c:url var="customerAPI" value='/api/customer' />--%>
<c:url var="customerURL" value='/admin/customer' />
<c:url var="editCustomerURL" value='/admin/customer/edit/' />
<html>
<head>
    <title>Khách Hàng</title>
</head>
<body>
    <div class="container-fluid px-4">
        <h1 class="mt-4">Quản Lý Khách Hàng</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">Danh sách khách hàng</li>
        </ol>
        <div class="row">
            <div class="col-xl-12">
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-search me-1"></i> Tìm kiếm</span>
                        <a class="text-decoration-none" data-bs-toggle="collapse" href="#searchForm" role="button">
                            <i class="fas fa-chevron-down" id="toggleArrow"></i>
                        </a>
                    </div>

                    <div class="collapse show" id="searchForm">
                        <div class="card-body">
                            <form:form id="listForm" modelAttribute="customerSeach" action="${customerURL}" method="GET">
                                <div class="row">
                                    <div class="col-xl-12 mb-3">
                                        <label class="fullname">Họ và tên</label>
                                        <form:input class="form-control" path="fullName"/>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xl-12 mb-3">
                                        <label class="companyName">Công ty</label>
                                        <form:input class="form-control" path="companyName"/>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xl-4 mb-3">
                                        <label class="phone">SĐT</label>
                                        <form:input class="form-control" path="phone"/>
                                    </div>
                                    <div class="col-xl-4 mb-3">
                                        <label class="email">Email</label>
                                        <form:input class="form-control" path="email"/>
                                    </div>
                                    <div class="col-xl-3 mb-3">
                                    <security:authorize access="hasRole('MANAGER')">
                                        <label class="staffId">Nhân viên</label>
                                        <form:select class="form-control" path="staffId">
                                            <form:option value="">-- Chọn nhân viên --</form:option>
<%--                                            <form:options items=""/>--%>
                                        </form:select>
                                    </security:authorize>
                                    </div>
                                </div>

                                <button type="submit" class="btn btn-primary w-100" id="btnSearchCustomer">
                                    <i class="fas fa-search me-1"></i> Tìm kiếm
                                </button>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bảng danh sách tài khoản -->
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="fas fa-table me-1"></i>Tài khoản hiện có</span>
<%--                <div class="d-flex align-items-center">--%>
<%--                <label class="me-2 mb-0 fw-bold">Trạng thái:</label>--%>
<%--                    <form:form modelAttribute="customerSeach" action="${customerURL}" method="GET">--%>
<%--                        <form:select id="statusFilter" class="form-select form-select-sm" path="isActive">--%>
<%--                            <form:option value="">Tất cả</form:option>--%>
<%--                            <form:option value="1">Hoạt động</form:option>--%>
<%--                            <form:option value="0">Đã tắt</form:option>--%>
<%--                        </form:select>--%>
<%--                    </form:form>--%>
<%--                </div>--%>
            </div>
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

                        <!-- Cột dữ liệu -->
                        <display:column property="id" title="ID" headerClass="text-center" />
                        <display:column property="fullName" title="Họ và tên" headerClass="text-center" />
                        <display:column property="phone" title="SĐT" headerClass="text-center" />
                        <display:column property="email" title="Email" headerClass="text-center" />
                        <display:column title="Trạng thái" headerClass="text-center" class="text-center">
                            <c:choose>
                                <c:when test="${customer.isActive == 1}">
                                    <span>Hoạt động</span>
                                </c:when>
                                <c:otherwise>
                                    <span>Ngưng hoạt động</span>
                                </c:otherwise>
                            </c:choose>
                        </display:column>


                        <!-- Cột thao tác -->
                        <display:column title="Thao tác" headerClass="text-center" class="text-center">
                            <div class="btn-group" role="group">
                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button"
                                            class="btn btn-success btn-sm"
                                            title="Giao khách hàng"
                                            onclick="assignmentCustomer(${customer.id})">
                                        <i class="bi bi-arrow-left-right"></i>
                                    </button>
                                </security:authorize>

                                <a href="${editCustomerURL}/${customer.id}"
                                   class="btn btn-info btn-sm"
                                   title="Chỉnh sửa">
                                    <i class="bi bi-pencil-square"></i>
                                </a>

                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button"
                                            class="btn btn-danger btn-sm"
                                            title="Xóa"
                                            onclick="deleteCustomer(${customer.id})">
                                        <i class="bi bi-trash"></i>
                                    </button>
                                </security:authorize>
                            </div>
                        </display:column>
<%--                        <display:setProperty name="paging.banner.full">--%>
<%--                            <nav aria-label="Page navigation">--%>
<%--                                <ul class="pagination mb-0">--%>
<%--                                    <li class="page-item">${firstPage}</li>--%>
<%--                                    <li class="page-item">${prevPage}</li>--%>
<%--                                    ${pageLinks}--%>
<%--                                    <li class="page-item">${nextPage}</li>--%>
<%--                                    <li class="page-item">${lastPage}</li>--%>
<%--                                </ul>--%>
<%--                            </nav>--%>
<%--                        </display:setProperty>--%>
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
    </script>
</body>
</html>
