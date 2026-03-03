<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url value='/api/user/profile' var="profileURL"/>
<c:url value='/api/user/change-password' var="changePasswordURL"/>
<c:url value='/logout' var="logoutURL" />

<!DOCTYPE html PUBLIC>

<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
    <!-- Navbar Brand-->
    <a class="navbar-brand ps-4 logo d-flex align-items-center" href="<c:url value='/admin/home'/>">
        <img src="https://bizweb.dktcdn.net/100/328/362/themes/894751/assets/logo.png?1676257083798"
            alt="">
    </a>
    <!-- Sidebar Toggle-->
    <button class="btn btn-link btn-sm order-1 order-lg-0 me-4 me-lg-0" id="sidebarToggle" href="#!"><i class="fas fa-bars"></i></button>
    <!-- Navbar Search-->
    <form class="d-none d-md-inline-block form-inline ms-auto me-0 me-md-3 my-2 my-md-0"></form>
    <!-- Navbar-->
    <ul class="navbar-nav ms-auto ms-md-0 me-3 me-lg-4">
        <li class="nav-item dropdown">
            <a class="nav-link dropdown-toggle" id="navbarDropdown" href="#" role="button" data-bs-toggle="dropdown" aria-expanded="false"><i class="fas fa-user fa-fw"></i></a>
            <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="navbarDropdown">
                <li><a class="dropdown-item" href="${profileURL}">
<%--                    <i class="bi bi-person"></i> Profile--%>
                    Hồ sơ cá nhân
                </a></li>
                <li><a class="dropdown-item" href="${changePasswordURL}">
<%--                    <i class="bi bi-lock"></i> Thay đổi mật khẩu--%>
                    Thay đổi mật khẩu
                </a></li>
                <li><hr class="dropdown-divider" /></li>
                <li><a class="dropdown-item" href="${logoutURL}">
<%--                    <i class="bi bi-box-arrow-right"></i> Đăng xuất--%>
                    Đăng xuất
                </a></li>
            </ul>
        </li>
    </ul>
</nav>