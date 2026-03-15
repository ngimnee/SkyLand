<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="buildingURL" value='/admin/building'/>
<c:url var="editBuildingURL" value='/admin/building/edit/'/>
<c:url var="buildingAPI" value='/api/building'/>
<html>
<head>
    <title>
        <c:choose>
            <c:when test="${empty editBuilding.id}">Thêm Tòa Nhà</c:when>
            <c:otherwise>Thông Tin Tòa Nhà</c:otherwise>
        </c:choose>
    </title>
</head>
<body>
    <div class="container-fluid px-4">
        <div class="mb-4 border-bottom pb-2">
            <div class="d-flex align-items-center gap-2">
                <h3 class="fw-bold mb-0">
                    <i class="bi bi-buildings me-2 text-primary"></i>Tòa nhà
                </h3>
            </div>
            <nav class="mt-1">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item">Quản lý</li>
                    <c:if test="${empty editBuilding.id}">
                        <li class="breadcrumb-item active">Thêm tòa nhà</li>
                    </c:if>
                    <c:if test="${not empty editBuilding.id}">
                        <li class="breadcrumb-item active">Cập nhật tòa nhà</li>
                    </c:if>
                </ol>
            </nav>
        </div>
        <div class="row">
            <div class="col-xl-12">
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <c:if test="${empty editBuilding.id}">
                            <span><i class="bi-building-add me-1"></i> Thêm tòa nhà</span>
                        </c:if>
                        <c:if test="${not empty editBuilding.id}">
                            <span><i class="bi-building-check me-1"></i> Cập nhật tòa nhà</span>
                        </c:if>
                        <a href="${buildingURL}">
                            <i class="bi bi-x-circle text-danger"></i>
                        </a>
                    </div>
                    <div id="editForm">
                        <div class="card-body">
                            <form:form id="form-edit" modelAttribute="editBuilding">
                                 <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                Tên tòa nhà<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="name" required="true" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Pháp lý</label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="legal"/>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                Tỉnh/Thành phố<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                                <form:select class="form-control" id="city" path="city">
                                                    <option value="">--- Chọn Tỉnh/Thành phố ---</option>
                                                    <form:options items="${city}" />
                                                </form:select>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                Quận/Huyện<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                                <form:select class="form-control" id="district" path="district">
                                                    <option value="">--- Chọn Quận/Huyện ---</option>
                                                    <form:options items="${district}" />
                                                </form:select>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                Phường<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="ward" required="true" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                Đường<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="street" required="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Kết cấu</label>
                                            <div class="col-xl-9">
                                               <form:input class="form-control" path="structure" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                Số tầng hầm<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="numberOfBasement" required="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Tầng</label>
                                            <div class="col-xl-9">
                                               <form:input class="form-control" path="floor" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                Diện tích sàn<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="floorArea" required="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Hướng</label>
                                            <div class="col-xl-9">
                                               <form:input type="text" class="form-control" path="direction" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Hạng</label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="level" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                Diện tích<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                               <form:input class="form-control" path="rentArea" required="true" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                Giá thuê<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="rentPrice" required="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Thời hạn thuê</label>
                                            <div class="col-xl-9">
                                               <form:input class="form-control" path="rentTime" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Mô tả giá</label>
                                            <div class="col-xl-9">
                                               <form:input class="form-control" path="rentPriceDescription" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Phí dịch vụ</label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="serviceFee" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Phí môi giới</label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="brokerageFee" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Phí ô tô</label>
                                            <div class="col-xl-9">
                                               <form:input class="form-control" path="carFee" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Phí mô tô</label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="motorbikeFee" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Phí ngoài giờ</label>
                                            <div class="col-xl-9">
                                               <form:input class="form-control" path="overtimeFee" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Tiền điện</label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="electricityFee" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Đặt cọc</label>
                                            <div class="col-xl-9">
                                               <form:input class="form-control" path="deposit" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Thanh toán</label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="payment" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">Thời gian trang trí</label>
                                            <div class="col-xl-9">
                                               <form:input class="form-control" path="decorationTime" />
                                            </div>
                                        </div>
                                    </div>


                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                Tên quản lý<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                               <form:input class="form-control" path="managerName" required="true" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                SĐT quản lý<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                                <form:input class="form-control" path="managerPhone" required="true" />
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                 Loại tòa nhà<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9 d-flex flex-wrap gap-3">
                                                <form:checkboxes items="${typeCode}" path="typeCode" />
                                            </div>
                                        </div>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="row align-items-center">
                                            <label class="col-xl-3 col-form-label">
                                                Hình thức<span class="text-danger">*</span>
                                            </label>
                                            <div class="col-xl-9">
                                               <div class="form-check form-check-inline">
                                                    <form:radiobutton path="status" value="THUE" cssClass="form-check-input" id="status_thue"/>
                                                    <label class="form-check-label" for="status_thue">Cho thuê</label>
                                                </div>

                                                <div class="form-check form-check-inline">
                                                    <form:radiobutton path="status" value="BAN" cssClass="form-check-input" id="status_ban"/>
                                                    <label class="form-check-label" for="status_ban">Bán</label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <div class="row mb-3">
                                    <div class="col-xl-6">
                                        <label class="col-form-label">Ghi chú</label>
                                        <form:textarea class="form-control" path="note" rows="6"/>
                                    </div>

                                    <div class="col-xl-6">
                                        <div class="mb-3">
                                            <label class="col-form-label">Đường dẫn ảnh</label>
                                            <form:input class="form-control" path="image" />
                                        </div>

                                        <div>
                                            <label class="col-form-label">Map</label>
                                            <form:input class="form-control" path="map" />
                                        </div>
                                    </div>
                                </div>

                                <div class="d-flex justify-content-center gap-2" style="margin-right:100px;">
                                    <c:if test="${empty editBuilding.id}">
                                        <button type="button" class="btn btn-primary" id="btnAddOrUpdateBuilding">
                                            <i class="bi bi-building-add"></i> Thêm tòa nhà
                                        </button>
                                    </c:if>
                                    <c:if test="${not empty editBuilding.id}">
                                        <button type="button" class="btn btn-success" id="btnAddOrUpdateBuilding">
                                            <i class="bi bi-building-check"></i> Cập nhật tòa nhà
                                        </button>
                                    </c:if>
                                    <button type="button" class="btn btn-danger px-4" id="btnCancel">
                                        Hủy
                                    </button>
                                </div>
                                <form:hidden path="id" id="buildingId"/>
                            </form:form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        var imageBase64 = '';
        var imageName = '';
        function openImage(input, imageView) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    $('#' +imageView).attr('src', reader.result);
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        $('#form-edit').on('submit', function(e) {
            e.preventDefault();
        });

        $('#btnAddOrUpdateBuilding').click(function(e) {
            // e.preventDefault();
            if (!validateRequiredFields()) return;

            var data = {};
            var typeCode = [];
                var formData = $('#form-edit').serializeArray();

            $.each(formData, function(i, v) {
                if(v.name != 'typeCode') {
                    data["" + v.name + ""] = v.value;
                }
                else {
                    typeCode.push(v.value);
                }
                if ('' !== imageBase64) {
                    data['imageBase64'] = imageBase64;
                    data['imageName'] = imageName;
                }
            });
            data['typeCode'] = typeCode;
            data['id'] = $('#buildingId').val();
            $('#loading_image').show();
             if(typeCode.length > 0) {
                addOrUpdateBuilding(data);
            }
            else {
                window.location.href = "/admin/building/edit?typeCode=require";
            }
            function addOrUpdateBuilding() {
                $.ajax({
                    type: "POST",
                    url: "${buildingAPI}",
                    data: JSON.stringify(data),
                    contentType: "application/json",
                    dataType: "json",
                    success: function(respond) {
                        Swal.fire({
                            icon: 'success',
                            title: 'Thành công',
                            text: 'Thêm / cập nhật tòa nhà thành công!',
                            confirmButtonText: 'OK'
                        }).then(() => {
                            window.location.href = "${buildingURL}";
                        });
                    },
                    error: function(respond) {
                        Swal.fire({
                            icon: 'error',
                            title: 'Lỗi',
                            text: 'Thao tác thất bại!'
                        });
                        console.log("Failed");
                        window.location.href = "<c:url value='/admin/building?message=error' />";
                        console.log(respond);
                    }
                });
            }
        });

        function validateRequiredFields() {
            const requiredFields = [
                { name: 'name', label: 'Tên tòa nhà' },
                { name: 'city', label: 'Tỉnh/Thành phố' },
                { name: 'district', label: 'Quận/Huyện' },
                { name: 'ward', label: 'Phường' },
                { name: 'street', label: 'Đường' },
                { name: 'numberOfBasement', label: 'Số tầng hầm' },
                { name: 'floorArea', label: 'Diện tích sàn' },
                { name: 'rentArea', label: 'Diện tích thuê' },
                { name: 'rentPrice', label: 'Giá thuê' },
                { name: 'managerName', label: 'Tên quản lý' },
                { name: 'managerPhone', label: 'SĐT quản lý' }
            ];

            let isValid = true;
            $('.is-invalid').removeClass('is-invalid');

            // Kiểm tra hình thức (radio)
            if ($('input[name="status"]:checked').length === 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Thiếu thông tin',
                    text: 'Vui lòng chọn hình thức (Cho thuê / Bán)'
                });
                $('input[name="status"]').addClass('is-invalid');
                isValid = false;
            }

            // Kiểm tra từng trường
            requiredFields.forEach(f => {
                let val = $('[name="' + f.name + '"]').val()?.trim();
                if (!val) {
                    $('[name="' + f.name + '"]').addClass('is-invalid');
                    isValid = false;
                }
            });

            // Kiểm tra loại tòa nhà
            if ($('input[name="typeCode"]:checked').length === 0) {
                Swal.fire({
                    icon: 'warning',
                    title: 'Thiếu thông tin',
                    text: 'Vui lòng chọn ít nhất một loại tòa nhà'
                });
                $('input[name="typeCode"]').addClass('is-invalid');
                isValid = false;
            }

            return isValid; // true nếu hợp lệ, false nếu có lỗi
        }



        $('#uploadImage').change(function (event) {
                var reader = new FileReader();
                var file = $(this)[0].files[0];
                reader.onload = function(e){
                    imageBase64 = e.target.result;
                    imageName = file.name; // ten hinh khong dau, khoang cach. Dat theo format sau: a-b-c
                };
                reader.readAsDataURL(file);
                openImage(this, "viewImage");
            });

        $('#btnCancel').click(function() {
            window.location.href = "${buildingURL}";
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
                    console.error("Không tải được danh sách quận/huyện", err);
                }
            });
        });
    </script>
</body>
</html>
