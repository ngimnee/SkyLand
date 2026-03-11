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
        <div class="mb-4 border-bottom pb-2">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="fw-bold mb-0">
                    <i class="bi bi-buildings me-2 text-primary"></i>Danh sách tòa nhà
                </h3>
            </div>
            <nav class="mt-1">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item text-muted">Quản lý</li>
                    <li class="breadcrumb-item active">Tòa nhà</li>
                </ol>
            </nav>
        </div>

        <div class="d-flex justify-content-between align-items-center mb-3">
            <div class="d-flex align-items-center gap-3">
                <form:form id="typeOForm" modelAttribute="buildingSearch" action="${buildingURL}" method="GET">
                    <div class="d-flex align-items-center gap-3">
                        <c:forEach var="itemO" items="${typeO}">
                            <div class="form-check form-check-inline">
                                <form:radiobutton path="typeO" value="${itemO.key}" cssClass="form-check-input" id="typeO_${itemO.key}"/>
                                <label class="form-check-label" for="typeO_${itemO.key}">
                                    ${itemO.value}
                                </label>
                            </div>
                        </c:forEach>
                    </div>
                </form:form>
            </div>

            <div class="d-flex gap-2">
                <button class="btn btn-outline-primary btn-sm" data-bs-toggle="modal" data-bs-target="#searchModal" title="Tìm kiếm">
                    <i class="fas fa-search"></i>
                </button>

                <a href="${editBuildingURL}" class="btn btn-primary btn-sm">
                    <i class="bi bi-building-add"></i> Thêm tòa nhà
                </a>

                <security:authorize access="hasRole('MANAGER')">
                    <button id="btnDeleteBuilding" class="btn btn-outline-danger btn-sm" title="Xóa tòa nhà">
                        <i class="bi bi-trash"></i>
                    </button>
                </security:authorize>
            </div>
        </div>

        <!-- SEARCH MODAL -->
        <div class="modal fade" id="searchModal">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title">Tìm kiếm tòa nhà</h5>
                        <button class="btn-close" data-bs-dismiss="modal"></button>
                    </div>

                    <div class="modal-body">
                        <form:form id="listForm" modelAttribute="buildingSearch" action="${buildingURL}" method="GET">
                            <div class="row">
                                <div class="col-md-6 mb-3">
                                    <label>Tên tòa nhà</label>
                                    <form:input path="name" class="form-control"/>
                                </div>

                                <div class="col-md-6 mb-3">
                                    <label>Diện tích sàn</label>
                                    <form:input path="floorArea" class="form-control"/>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label>Tỉnh/Thành phố</label>
                                    <form:select id="city" path="city" class="form-control">
                                        <form:option value="">--- Tỉnh ---</form:option>
                                        <form:options items="${city}"/>
                                    </form:select>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label>Quận/Huyện</label>
                                    <form:select id="district" path="district" class="form-control">
                                        <form:option value="">--- Quận ---</form:option>
                                        <form:options items="${district}"/>
                                    </form:select>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label>Phường</label>
                                    <form:input path="ward" class="form-control"/>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12 mb-3">
                                    <label>Đường</label>
                                    <form:input class="form-control" path="street"/>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label>Số tầng hầm</label>
                                    <form:input class="form-control" path="numberOfBasement"/>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label>Hướng</label>
                                    <form:input class="form-control" path="direction"/>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label>Hạng</label>
                                    <form:input class="form-control" path="level"/>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-3 mb-3">
                                    <label>Diện tích từ</label>
                                    <form:input class="form-control" path="rentAreaFrom"/>
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Diện tích đến</label>
                                    <form:input class="form-control" path="rentAreaTo"/>
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Giá thuê từ</label>
                                    <form:input class="form-control" path="rentPriceFrom"/>
                                </div>

                                <div class="col-md-3 mb-3">
                                    <label>Giá thuê đến</label>
                                    <form:input class="form-control" path="rentPriceTo"/>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-4 mb-3">
                                    <label>Tên quản lý</label>
                                    <form:input class="form-control" path="managerName"/>
                                </div>

                                <div class="col-md-4 mb-3">
                                    <label>SĐT quản lý</label>
                                    <form:input class="form-control" path="managerPhone"/>
                                </div>

                                <security:authorize access="hasRole('MANAGER')">
                                    <div class="col-md-4 mb-3">
                                        <label>Nhân viên phụ trách</label>
                                        <form:select class="form-control" path="staffId">
                                            <form:option value="">--- Chọn nhân viên ---</form:option>
                                            <form:options items="${listStaff}"/>
                                        </form:select>
                                    </div>
                                </security:authorize>
                            </div>

                            <div class="row">
                                <div class="col-md-12 mb-3 type-checkboxes">
                                    <form:checkboxes items="${typeCode}" path="typeCode"/>
                                </div>
                            </div>
                        </form:form>
                    </div>
                    <div class="modal-footer">
                        <button type="submit" form="listForm" class="btn btn-primary">Tìm kiếm</button>
                        <button class="btn btn-secondary" data-bs-dismiss="modal">Đóng</button>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bảng danh sách tòa nhà -->
        <div class="card mb-4">
            <div class="card-body p-0">
                <div style="overflow-x:auto;">
                    <form:form id="buildingListForm" modelAttribute="buildingList">
                        <display:table id="building"
                                name="buildingList.listResult"
                                requestURI="${buildingURL}"
                                class="table table-striped table-bordered mb-0"
                                style="min-width:1600px; white-space:nowrap;"
                                pagesize="${buildingList.maxPageItems}"
                                partialList="true"
                                size="${buildingList.totalItems}">
                            <!-- Cột checkbox chọn tất cả -->
                            <display:column title="<input type='checkbox' id='checkAll'/>" headerClass="text-center" class="text-center">
                                <input type="checkbox" name="checkList" value="${building.id}" class="checkItem"/>
                            </display:column>

                            <!-- Cột dữ liệu -->
    <%--                        <display:column property="createddate" title="Ngày" headerClass="text-center" />--%>
                            <display:column title="STT" headerClass="text-center" class="text-center">
                                ${building_offset + building_rowNum}
                            </display:column>
                            <display:column property="name" title="Tên tòa nhà" headerClass="text-center" class="text-center"/>
                            <display:column property="address" title="Địa chỉ" headerClass="text-center" class="text-center"/>
                            <display:column property="floor" title="Tầng" headerClass="text-center" class="text-center"/>
                            <display:column property="numberOfBasement" title="Số tầng hầm" headerClass="text-center" class="text-center"/>
                            <display:column property="managerName" title="Tên quản lý" headerClass="text-center" class="text-center"/>
                            <display:column property="managerPhone" title="SĐT" headerClass="text-center" class="text-center"/>
                            <display:column property="floorArea" title="DT sàn" headerClass="text-center" class="text-center"/>
                            <display:column property="emptyArea" title="DT trống" headerClass="text-center" class="text-center"/>
                            <display:column property="rentArea" title="DT thuê" headerClass="text-center" class="text-center"/>
                            <display:column property="brokerageFee" title="Môi giới" headerClass="text-center" class="text-center"/>

                            <!-- Cột thao tác -->
                            <display:column title="Thao tác" headerClass="text-center" class="text-center">
                                <div class="d-flex justify-content-center gap-1">
                                    <security:authorize access="hasRole('MANAGER')">
                                        <button type="button" class="btn btn-outline-success btn-sm" title="Giao tòa nhà" onclick="assignmentBuilding(${building.id})">
                                            <i class="bi bi-arrow-left-right"></i>
                                        </button>
                                    </security:authorize>

                                    <a href="${editBuildingURL}/${building.id}" class="btn btn-outline-primary btn-sm" title="Chỉnh sửa">
                                        <i class="bi bi-pencil-square"></i>
                                    </a>

                                    <security:authorize access="hasRole('MANAGER')">
                                        <button type="button" class="btn btn-outline-danger btn-sm" title="Xóa" onclick="deleteBuilding(${building.id})">
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

        $('input[name="typeO"]').change(function () {
            $('#typeOForm').submit();
        });

        $(document).ready(function () {
            if ($('input[name="typeO"]:checked').length === 0) {
                $('#typeO_AVAILABLE').prop('checked', true);
                $('#typeOForm').submit();
            }
        });
    </script>
</body>
</html>
