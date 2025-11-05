<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url var="orderURL" value='/admin/order' />

<html>
<head>
    <title>Đơn Hàng</title>
</head>
<body>
    <div class="container-fluid px-4">
        <h1 class="mt-4">Quản Lý Đơn Hàng</h1>
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
                        <form:input path="id" class="form-control" placeholder="Nhập mã đơn hàng..." />
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
<%--                <form:form id="orderListForm">--%>
<%--                    <display:table name="orderList.listResult"--%>
<%--                                requestURI="${orderURL}"--%>
<%--                                id="order"--%>
<%--                                class="table table-striped table-bordered align-middle text-start"--%>
<%--                                cellspacing="0" cellpadding="0"--%>
<%--                                export="false"--%>
<%--                                pagesize="${orderList.maxPageItems}"--%>
<%--                                partialList="true"--%>
<%--                                size="${orderList.totalItems}"--%>
<%--                                defaultsort="2" defaultorder="ascending">--%>

<%--                        <!-- Cột dữ liệu -->--%>
<%--                        <display:column property="createdDate" title="Ngày" headerClass="text-center" />--%>
<%--                        <display:column property="code" title="Mã đơn hàng" headerClass="text-center" />--%>
<%--                        <display:column property="buildingName" title="Tên tòa nhà" headerClass="text-center" />--%>
<%--                        <display:column property="name" title="Tên khách hàng" headerClass="text-center" />--%>
<%--                        <display:column property="phone" title="SĐT" headerClass="text-center" />--%>
<%--                        <display:column property="email" title="Email" headerClass="text-center" />--%>
<%--                        <display:column property="address" title="Địa chỉ" headerClass="text-center" />--%>
<%--                        <display:column property="amount" title="Đã cọc" headerClass="text-center" />--%>
<%--                        <display:column property="paymentMethod" title="Phương thức" headerClass="text-center" />--%>

<%--                        <!-- Cột thao tác -->--%>
<%--                        <display:column title="Thao tác" headerClass="text-center" class="text-center">--%>
<%--                                <a href="${editOrderURL}/${order.id}"--%>
<%--                                   class="btn btn-info btn-sm"--%>
<%--                                   title="Chỉnh sửa">--%>
<%--                                    <i class="bi bi-pencil-square"></i>--%>
<%--                                </a>--%>

<%--                                <security:authorize access="hasRole('MANAGER')">--%>
<%--                                    <button type="button"--%>
<%--                                            class="btn btn-danger btn-sm"--%>
<%--                                            title="Xóa"--%>
<%--                                            onclick="deleteOrder(${order.id})">--%>
<%--                                        <i class="bi bi-trash"></i>--%>
<%--                                    </button>--%>
<%--                                </security:authorize>--%>
<%--                            </div>--%>
<%--                        </display:column>--%>
<%--                    </display:table>--%>
<%--                </form:form>--%>
            </div>
        </div>
    </div>

<%--    <script>--%>
<%--        $('#btnSearchBuilding').click(function(e) {--%>
<%--            e.preventDefault();--%>
<%--            $('#listForm').submit();--%>
<%--        });--%>


<%--        function deleteOrder(id) {--%>
<%--            if (confirm("Bạn có chắc muốn xóa đơn hàng này không?")) {--%>
<%--                $.ajax({--%>
<%--                    type: "DELETE",--%>
<%--                    url: "${orderAPI}/" + id,--%>
<%--                    success: function() {--%>
<%--                        alert("✅ Xóa thành công!");--%>
<%--                        location.reload();--%>
<%--                    },--%>
<%--                    error: function(xhr) {--%>
<%--                        console.error("❌ Lỗi khi xóa:", xhr);--%>
<%--                        alert("❌ Xóa thất bại!");--%>
<%--                    }--%>
<%--                });--%>
<%--            }--%>
<%--        }--%>

<%--    </script>--%>
</body>
</html>
