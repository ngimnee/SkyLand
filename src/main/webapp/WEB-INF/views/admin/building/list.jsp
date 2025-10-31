<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@include file="/common/taglib.jsp"%>
<c:url value='/admin/building' var="buildingURL" />
<c:url value='/admin/building/edit' var="editBuildingURL" />
<c:url var="buildingAPI" value='/api/building' />

<html>
<head>
    <title>Tòa Nhà</title>
</head>
<body>
    <div class="container-fluid px-4">
        <h1 class="mt-4">Quản Lý Tòa Nhà</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">Danh sách tòa nhà</li>
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
                            <form:form id="listForm" modelAttribute="buildingSearch" action="${buildingURL}" method="GET">
                                <div class="row">
                                    <div class="col-xl-6 mb-3">
                                        <label class="name">Tên tòa nhà</label>
                                        <form:input class="form-control" path="name" />
                                    </div>
                                    <div class="col-xl-6 mb-3">
                                        <label class="floorArea">Diện tích sàn</label>
                                        <form:input class="form-control" path="floorArea" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-3 mb-3">
                                        <label class="city">Tỉnh/Thành phố</label>
                                        <form:select class="form-control" id="city" path="city">
                                            <form:option value="">--- Tỉnh/Thành phố ---</form:option>
                                            <form:options items="${city}" />
                                        </form:select>
                                    </div>
                                    <div class="col-xl-3 mb-3">
                                        <label class="district">Quận/Huyện</label>
                                        <form:select class="form-control" id="district" path="district">
                                            <form:option value="">--- Chọn Quận/Huyện ---</form:option>
                                            <form:options items="${district}" />
                                        </form:select>
                                    </div>
                                    <div class="col-xl-6 mb-3">
                                        <label class="ward">Phường</label>
                                        <form:input class="form-control" path="ward" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-12 mb-3">
                                        <label class="street">Đường</label>
                                        <form:input class="form-control" path="street" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-4 mb-3">
                                        <label class="numberofbasement">Số tầng hầm</label>
                                        <form:input class="form-control" path="numberOfBasement" />
                                    </div>
                                    <div class="col-xl-4 mb-3">
                                        <label class="direction">Hướng</label>
                                        <form:input class="form-control" path="direction" />
                                    </div>
                                    <div class="col-xl-4 mb-3">
                                        <label class="level">Hạng</label>
                                        <form:input class="form-control" path="level" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-3 mb-3">
                                        <label class="rentAreaFrom">Diện tích từ</label>
                                        <form:input class="form-control" path="rentAreaFrom" />
                                    </div>
                                    <div class="col-xl-3 mb-3">
                                        <label class="rentAreaTo">Diện tích đến</label>
                                        <form:input class="form-control" path="rentAreaTo" />
                                    </div>
                                    <div class="col-xl-3 mb-3">
                                        <label class="rentPriceFrom">Giá thuê từ</label>
                                        <form:input class="form-control" path="rentPriceFrom" />
                                    </div>
                                    <div class="col-xl-3 mb-3">
                                        <label class="rentPriceFrom">Giá thuê đến</label>
                                        <form:input class="form-control" path="rentPriceTo" />
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-4 mb-3">
                                        <label class="managerName">Tên quản lý</label>
                                        <form:input type="text" class="form-control" path="managerName" />
                                    </div>
                                    <div class="col-xl-4 mb-3">
                                        <label class="managerPhone">SĐT quản lý</label>
                                        <form:input class="form-control" path="managerPhone" />
                                    </div>
                                    <security:authorize access="hasRole('MANAGER')">
                                        <div class="col-xl-3 mb-3">
                                            <label class="staffId">Nhân viên phụ trách</label>
                                            <form:select class="form-control" path="staffId">
                                                <form:option value="">--- Chọn nhân viên ---</form:option>
                                                <form:options items="${listStaff}" />
                                            </form:select>
                                        </div>
                                    </security:authorize>
                                </div>
                                <div class="row">
                                    <div class="col-xl-12 mb-3 type-checkboxes">
                                        <form:checkboxes items="${typeCode}" path="typeCode" />
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary w-100" id="btnSearchBuilding">
                                    <i class="fas fa-search me-1"></i> Tìm kiếm
                                </button>
                            </form:form>
                        </div>
                    </div>
                    <div class="d-flex justify-content-end align-items-stretch" style="border-top: 1px solid #ccc;">
                        <a href="${editBuildingURL}">
                            <button class="btn btn-info" title="Thêm tòa nhà">
                                <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building-add" viewBox="0 0 16 16">
                                    <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7m.5-5v1h1a.5.5 0 0 1 0 1h-1v1a.5.5 0 0 1-1 0v-1h-1a.5.5 0 0 1 0-1h1v-1a.5.5 0 0 1 1 0"/>
                                    <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                                    <path d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                                </svg>
                            </button>
                        </a>
                        <security:authorize access="hasRole('MANAGER')">
                            <a href="#" id="btnDeleteBuilding">
                                <button class="btn btn-danger" title="Xóa tòa nhà">
                                    <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-building-dash" viewBox="0 0 16 16">
                                        <path d="M12.5 16a3.5 3.5 0 1 0 0-7 3.5 3.5 0 0 0 0 7M11 12h3a.5.5 0 0 1 0 1h-3a.5.5 0 0 1 0-1"/>
                                        <path d="M2 1a1 1 0 0 1 1-1h10a1 1 0 0 1 1 1v6.5a.5.5 0 0 1-1 0V1H3v14h3v-2.5a.5.5 0 0 1 .5-.5H8v4H3a1 1 0 0 1-1-1z"/>
                                        <path d="M4.5 2a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm-6 3a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5zm3 0a.5.5 0 0 0-.5.5v1a.5.5 0 0 0 .5.5h1a.5.5 0 0 0 .5-.5v-1a.5.5 0 0 0-.5-.5z"/>
                                    </svg>
                                </button>
                            </a>
                        </security:authorize>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bảng danh sách tòa nhà -->
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="fas fa-table me-1"></i> Danh sách tòa nhà hiện có</span>
                <div class="d-flex align-items-center">
                    <label class="me-2 mb-0 fw-bold">Trạng thái:</label>
                    <form:form modelAttribute="buildingSearch" action="${buildingURL}" method="GET">
                        <form:select id="statusFilter" class="form-select form-select-sm" path="status">
                            <form:options items="${status}"/>
                        </form:select>
                    </form:form>
                </div>
            </div>
            <div class="card-body">
                <form:form id="buildingListForm" modelAttribute="buildingList">
                    <display:table name="buildingList.listResult"
                                requestURI="${buildingURL}"
                                id="building"
                                class="table table-striped table-bordered align-middle text-start"
                                cellspacing="0" cellpadding="0"
                                export="false"
                                pagesize="${buildingList.maxPageItems}"
                                partialList="true"
                                size="${buildingList.totalItems}"
                                defaultsort="2" defaultorder="ascending">

                        <!-- Cột checkbox chọn tất cả -->
                        <display:column title="<input type='checkbox' id='checkAll'/>" headerClass="text-center" class="text-center">
                            <input type="checkbox" name="checkList" value="${building.id}" class="checkItem"/>
                        </display:column>

                        <!-- Cột dữ liệu -->
<%--                        <display:column property="createddate" title="Ngày" headerClass="text-center" />--%>
                        <display:column property="name" title="Tên tòa nhà" headerClass="text-center" />
                        <display:column property="address" title="Địa chỉ" headerClass="text-center" />
                        <display:column property="floor" title="Tầng" headerClass="text-center" />
                        <display:column property="numberOfBasement" title="Số tầng hầm" headerClass="text-center" />
                        <display:column property="managerName" title="Tên quản lý" headerClass="text-center" />
                        <display:column property="managerPhone" title="SĐT" headerClass="text-center" />
                        <display:column property="floorArea" title="DT sàn" headerClass="text-center" />
                        <display:column property="emptyArea" title="DT trống" headerClass="text-center" />
                        <display:column property="rentArea" title="DT thuê" headerClass="text-center" />
                        <display:column property="brokerageFee" title="Môi giới" headerClass="text-center" />

                        <!-- Cột thao tác -->
                        <display:column title="Thao tác" headerClass="text-center" class="text-center">
                            <div class="btn-group" role="group">
                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button"
                                        class="btn btn-success btn-sm"
                                        title="Giao tòa nhà"
                                        onclick="assignmentBuilding(${building.id})">
                                        <i class="bi bi-arrow-left-right"></i>
                                    </button>
                                </security:authorize>

                                <a href="${editBuildingURL}/${building.id}"
                                   class="btn btn-info btn-sm"
                                   title="Chỉnh sửa">
                                    <i class="bi bi-pencil-square"></i>
                                </a>

                                <security:authorize access="hasRole('MANAGER')">
                                    <button type="button"
                                            class="btn btn-danger btn-sm"
                                            title="Xóa"
                                            onclick="deleteBuilding(${building.id})">
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
    <div class="modal fade" id="assignmentBuildingModal" tabindex="-1" aria-labelledby="assignmentBuildingModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title text-center w-100" id="assignmentBuildingModalLabel">Danh Sách Nhân Viên</h5>
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
                    <input type="hidden" id="buildingId" name="buildingId" value="">
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary" id="btnAssignmentBuilding">Giao tòa nhà</button>
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        $('#btnSearchBuilding').click(function(e) {
            e.preventDefault();
            $('#listForm').submit();
        });

        // Hàm mở modal
        function assignmentBuilding(buildingId) {
            var modalEl = document.getElementById('assignmentBuildingModal');
            var myModal = new bootstrap.Modal(modalEl);
            myModal.show();
            $('#buildingId').val(buildingId);
            loadStaff(buildingId);
        }

        function loadStaff(buildingId) {
            $.ajax({
                type: "GET",
                url: "${buildingAPI}/" + buildingId + '/staffs',
                // data: JSON.stringify(data),
                // contentType: "application/json",
                dataType: "json",
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
                    window.location.href = '<c:url value="/admin/building?message=error" />';
                    console.log(response);
                }
            });
        }

        $('#btnAssignmentBuilding').click(function(e) {
            e.preventDefault();
            var data = {};
            data['buildingId'] = $('#buildingId').val();
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
                window.location.href="<c:url value = "${buildingURL}?message=staff_required" />";
            }
        });

        function assignment(data) {
            $.ajax({
                type: "PUT",
                url: "${buildingAPI}",
                data: JSON.stringify(data),
                contentType: "application/json",
                dataType: "JSON",
                success: function (response)
                {
                    console.info("Success", response);
                    alert("✅ Giao tòa nhà thành công!");
                    location.reload()
                    //window.location.href="<c:url value = "${buildingURL}?message=success"/>";
                },

                error: function (response)
                {
                    console.error("Error", response);
                    alert("❌ Giao tòa nhà thất bại!");
                    window.location.href="<c:url value = "${buildingURL}?message=error"/>";
                }
            })
        }

        $('#assignmentBuildingModal').on('show.bs.modal', function () {
            var buildingId = $('#buildingId').val();
            if (buildingId) {
                loadStaff(buildingId);
            }
        });


        function deleteBuilding(id) {
            if (confirm("Bạn có chắc muốn xóa tòa nhà này không?")) {
                $.ajax({
                    type: "DELETE",
                    url: "${buildingAPI}/" + id,
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

        // Xóa nhiều tòa nhà
        $('#btnDeleteBuilding').click(function(e) {
            e.preventDefault();
            const buildingIds = $('#buildingListForm')
                .find('input.checkItem:checked')
                .map(function() {
                    return $(this).val();
                }).get();

            if (buildingIds.length === 0) {
                alert("⚠️ Vui lòng chọn ít nhất một tòa nhà để xóa!");
                return;
            }

            if (confirm("Bạn có chắc muốn xóa " + buildingIds.length + " tòa nhà này không?")) {
                const ids = buildingIds.join(',');

                $.ajax({
                    type: "DELETE",
                    url: "${buildingAPI}/" + ids,
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
        });

        // Check / uncheck tất cả
        $('#checkAll').on('change', function() {
            $('.checkItem').prop('checked', this.checked);
        });

        // ======= LOAD QUẬN THEO THÀNH PHỐ =======
        $('#city').change(function() {
            let city = $(this).val();
            if (city === "") {
                $('#district').empty();
                $('#district').append('<option value="">--- Chọn Quận/Huyện ---</option>');
                return;
            }

            $.ajax({
                url: '/admin/building/districts',
                type: 'GET',
                data: { city: city },
                success: function(districts) {
                    $('#district').empty();
                    $('#district').append('<option value="">--- Chọn Quận/Huyện ---</option>');
                    $.each(districts, function(key, value) {
                        $('#district').append('<option value="' + key + '">' + value + '</option>');
                    });
                },
                error: function(err) {
                    console.error("Không tải được danh sách quận", err);
                }
            });
        });

    </script>
</body>
</html>
