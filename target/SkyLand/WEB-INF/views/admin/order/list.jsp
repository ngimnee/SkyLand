<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url value='/admin/order' var="orderURL" />



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
        <div class="row">
            <div class="col-xl-12">
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="fas fa-search me-1"></i> Tìm kiếm</span>
                        <a class="text-decoration-none" data-bs-toggle="collapse" href="#searchForm" role="button">
                            <i class="fas fa-chevron-down" id="toggleArrow"></i>
                        </a>
                        <a href="${updateOrderURL}">
                            <button class="btn btn-info" title="Thêm tòa nhà">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building-add" viewBox="0 0 16 16">
                                    <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0"/>
                                    <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                                    <path d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                                </svg>
                            </button>
                        </a>
                    </div>
                    <div class="collapse" id="searchForm">
                        <div class="card-body">
                            <form:form id="listForm" modelAttribute=" " action="" method="GET">
                                <div class="row">
                                    <div class="col-xl-6 mb-3">
                                        <label class="name">Mã đơn hàng</label>
                                        <form:input class="form-control" path="id" />
                                    </div>
                                    <div class="col-xl-6 mb-3">
                                        <label class="floorArea">Diện tích sàn</label>
                                        <form:input class="form-control" path="floorArea" />
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary w-100" id="btnSearchBuilding">
                                    <i class="fas fa-search me-1"></i> Tìm kiếm
                                </button>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bảng danh sách -->
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="fas fa-table me-1"></i> Danh sách đơn hàng</span>
            </div>
            <div class="card-body">
                <form:form id="buildingListForm" modelAttribute=" ">
                    <display:table name="buildingList.listResult"
                                requestURI="${orderURL}"
                                id="order"
                                class="table table-striped table-bordered align-middle text-start"
                                cellspacing="0" cellpadding="0"
                                export="false"
                                pagesize="${buildingList.maxPageItems}"
                                partialList="true"
                                size="${buildingList.totalItems}"
                                defaultsort="2" defaultorder="ascending">

                        <!-- Cột dữ liệu -->
                        <display:column property="id" title="Mã đơn hàng" headerClass="text-center" />
                        <display:column property="name" title="Tên tòa nhà" headerClass="text-center" />
                        <display:column property="address" title="Địa chỉ" headerClass="text-center" />
                        <display:column property="managerName" title="Tên quản lý" headerClass="text-center" />
                        <display:column property="managerPhone" title="SĐT" headerClass="text-center" />

                        <!-- Cột thao tác -->
                        <display:column title="Trạng thái" headerClass="text-center" class="text-center">
                                <a href="${updateStausURL}/${order.id}"
                                   class="btn btn-info btn-sm"
                                   title="Trạng thái">
                                    <i class="bi bi-pencil-square"></i>
                                </a>
                            </div>
                        </display:column>

                        <display:column title="Thao tác" headerClass="text-center" class="text-center">
                                <button type="button"
                                        class="btn btn-danger btn-sm"
                                        title="Xóa"
                                        onclick="deleteOrder(${order.id})">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </display:column>
                    </display:table>
                </form:form>
            </div>
        </div>
    </div>


    <script>
        $('#btnSearchBuilding').click(function(e) {
            e.preventDefault();
            $('#listForm').submit();
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
