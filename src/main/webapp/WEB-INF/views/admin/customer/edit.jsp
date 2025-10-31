<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<html>
<head>
    <title>Khách Hàng</title>
</head>
<body>
    <div class="container-fluid px-4">
        <h1 class="mt-4">Quản Lý Khách Hàng</h1>
        <ol class="breadcrumb mb-4">
            <li class="breadcrumb-item active">Cập nhật thông tin khách hàng</li>
        </ol>
        <div class="row">
            <div class="col-xl-12">
                <div class="card mb-4">
                    <div class="card-header d-flex justify-content-between align-items-center">
                        <span><i class="bi bi-person-fill-add"></i> Cập nhật thông tin khách hàng</span>
                    </div>

                    <div class="collapse show" id="searchForm">
                        <div class="card-body">
                            <form>
                                <div class="row">
                                    <div class="col-xl-4 mb-3">
                                        <label class="username">Username<span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" required>
                                    </div>
                                    <div class="col-xl-4 mb-3">
                                        <label class="password">Password<span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" required>
                                    </div>
                                    <div class="col-xl-4 mb-3">
                                        <label class="password">Confirm Password<span class="text-danger">*</span></label>
                                        <input type="password" class="form-control" required>                                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-6 mb-3">
                                        <label class="username">Họ tên<span class="text-danger">*</span></label>
                                        <input type="text" class="form-control" required>                                                    </div>
                                    <div class="col-xl-3 mb-3">
                                        <label class="dob">Ngày sinh</label>
                                        <input type="date" class="form-control">
                                    </div>
                                    <div class="col-xl-3 mb-3">
                                        <label class="gender">Giới tính</label>
                                        <select class="form-select" id="gender">
                                            <option value="selected disabled">-- Chọn giới tính --</option>
                                            <option value="male">Nam</option>
                                            <option value="female">Nữ</option>
                                            <option value="other">Khác</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-xl-4 mb-3">
                                        <label class="sdt">SĐT</label>
                                        <input type="text" class="form-control">
                                    </div>
                                    <div class="col-xl-4 mb-3">
                                        <label class="email">Email</label>
                                        <input type="text" class="form-control">
                                    </div>
                                    <div class="col-xl-3 mb-3">
                                        <label class="staffId">Vai trò</label>
                                        <select class="form-control">
                                            <option value="">-- Chọn vai trò --</option>
                                            <option value="">Quản lý</option>
                                            <option value="">Nhân viên</option>
                                            <option value="">Người dùng</option>
                                        </select>
                                        <div class="invalid-feedback">Vui lòng không để trống trường hợp này.</div>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary w-100">
                                    <i class="bi bi-person-fill-add"></i> Thêm tài khoản
                                </button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bảng danh sách tài khoản -->
        <div class="card mb-4">
            <div class="card-header d-flex justify-content-between align-items-center">
                <span><i class="fas fa-table me-1"></i>Tài khoản hiện có</span>
                <div class="d-flex align-items-center">
                    <label class="me-2 mb-0 fw-bold">Trạng thái:</label>
                    <select id="statusFilter" class="form-select form-select-sm" style="width:auto;">
                        <option value="">Tất cả</option>
                        <option value="active">Hoạt động</option>
                        <option value="inactive">Đã tắt</option>
                    </select>
                </div>
            </div>
            <div class="card-body">
                <table id="building" class="table table-striped table-bordered">
                    <thead>
                    <tr>
                        <th>ID</th>
                        <th>Username</th>
                        <th>Password</th>
                        <th>Fullname</th>
                        <th>SĐT</th>
                        <th>Email</th>
                        <th>Status</th>
                        <th>Thao tác</th>
                    </tr>
                    </thead>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
