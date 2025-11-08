<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title><dec:title default="Trang Chủ" /></title>

    <!-- Favicon -->
    <link rel="icon" href="/admin/img/favicon.ico" type="image/x-icon">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"/>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css"/>

    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v6.3.0/css/all.css"/>

    <!-- Simple DataTables -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"/>

    <!-- SweetAlert2 -->
    <link rel="stylesheet" href="/admin/assets/sweetalert/sweetalert2.min.css">

    <!-- Custom CSS -->
    <link rel="stylesheet" href="/admin/css/styles.css"/>

    <!-- jQuery + Fallback -->
    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script>
        window.jQuery || document.write('<script src="/admin/assets/jquery/jquery-3.6.4.min.js"><\/script>');
    </script>
</head>
<body class="sb-nav-fixed">
    <!-- Header -->
    <%@ include file="/common/admin/header.jsp" %>

    <div id="layoutSidenav">
        <!-- Menu -->
        <%@ include file="/common/admin/menu.jsp" %>

        <div id="layoutSidenav_content">
            <main>
                <dec:body/>
            </main>

            <%@ include file="/common/admin/footer.jsp" %>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Chart.js -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>

    <!-- Simple DataTables -->
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>

    <!-- SweetAlert2 -->
    <script src="/admin/assets/sweetalert/sweetalert2.all.min.js"></script>
<%--    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>--%>

    <!-- Custom JS -->
    <script src="/admin/js/scripts.js"></script>
    <script src="/admin/js/validation.js"></script>
    <script src="/admin/js/datatables-simple-demo.js"></script>
    <script src="/admin/demo/chart-area-demo.js"></script>
    <script src="/admin/demo/chart-bar-demo.js"></script>

    <!-- Hàm xóa dùng SweetAlert2 v11 -->
    <script type="text/javascript">
        function showAlertBeforeDelete(callback) {
            Swal.fire({
                title: "Xác nhận xóa",
                text: "Bạn có chắc chắn xóa những dòng đã chọn?",
                icon: "warning",
                showCancelButton: true,
                confirmButtonText: "Xác nhận",
                cancelButtonText: "Hủy bỏ",
                confirmButtonColor: "#d33",
                cancelButtonColor: "#3085d6",
                reverseButtons: true
            }).then((result) => {
                if (result.isConfirmed) {
                    callback();
                }
            });
        }
    </script>
</body>
</html>