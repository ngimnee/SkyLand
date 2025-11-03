<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp" %>

<!DOCTYPE html>
<html>
<head>
	<title><dec:title default="Trang chủ" /></title>

    <script src="https://code.jquery.com/jquery-3.6.4.min.js"></script>
    <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"></script>

    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css" rel="stylesheet" />
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="<c:url value='/admin/css/styles.css'/>" rel="stylesheet" />

	<%--sweetalert--%>
    <script src="<c:url value='/admin/assets/sweetalert/sweetalert2.min.js'/>"></script>
    <link rel="stylesheet" href="<c:url value='/admin/assets/sweetalert/sweetalert2.min.css'/>">
</head>
<body class="sb-nav-fixed">
	<!-- header -->
    <%@ include file="/common/admin/header.jsp" %>
    <!-- header -->

    <div id="layoutSidenav">
		<!-- menu -->
    	<%@ include file="/common/admin/menu.jsp" %>
    	<!-- menu -->
		
		<div id="layoutSidenav_content">
            <main>
                <dec:body/>
            </main>

            <%@ include file="/common/admin/footer.jsp" %>
        </div>
	</div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    <script src="<c:url value='/admin/js/validation.js'/>"></script>
    <script src="<c:url value='/admin/js/datatables-simple-demo.js'/>"></script>
    <script src="<c:url value='/admin/js/scripts.js'/>"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"></script>
    <script src="<c:url value='/admin/demo/chart-area-demo.js'/>"></script>
    <script src="<c:url value='/admin/demo/chart-bar-demo.js'/>"></script>



    <script type="text/javascript">
        function showAlertBeforeDelete(callback) {
            swal({
                title: "Xác nhận xóa",
                text: "Bạn có chắc chắn xóa những dòng đã chọn",
                type: "warning",
                showCancelButton: true,
                confirmButtonText: "Xác nhận",
                cancelButtonText: "Hủy bỏ",
                confirmButtonClass: "btn btn-success",
                cancelButtonClass: "btn btn-danger"
            }).then(function (res) {
                if(res.value){
                    callback();
                }else if(res.dismiss == 'cancel'){
                    console.log('cancel');
                }
            });
        }
	</script>
</body>
</html>