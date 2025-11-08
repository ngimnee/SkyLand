<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="homeURL" value='/admin/home'/>
<c:url var="buildingURL" value='/admin/building'/>
<c:url var="editBuildingURL" value='/admin/building/edit'/>
<c:url var="userURL" value='/admin/user'/>
<c:url var="editUserURL" value='/admin/user/edit'/>
<c:url var="updateRoleUserURL" value='/admin/user/update'/>
<c:url var="orderURL" value="/admin/order"/>
<c:url var="customerURL" value="/admin/customer"/>
<c:url var="blogURL" value="/admin/blog"/>
<c:url var="editBlogURL" value="/admin/blog/edit"/>
<c:url var="blogURL" value="/admin/blog" />
<c:url var="editBlogURL" value="/admin/blog/edit" />

<!DOCTYPE html PUBLIC>
<div id="layoutSidenav_nav">
    <nav class="sb-sidenav accordion sb-sidenav-dark" id="sidenavAccordion">
        <div class="sb-sidenav-menu">
            <div class="nav">

                <a class="nav-link" href="${homeURL}">
                    <div class="sb-nav-link-icon"><i class="fas fa-tachometer-alt"></i></div>
                    Tổng Quan
                </a>


<%--                <a class="nav-link" href="${buildingURL}">--%>
<%--                    <div class="sb-nav-link-icon"><i class="fas fa-building"></i></div>--%>
<%--                    Quản Lý Tòa Nhà--%>
<%--                </a>--%>

                <a class="nav-link" href="#" data-bs-toggle="collapse" data-bs-target="#collapseBuildings" aria-expanded="true" aria-controls="collapseBuildings">
                    <div class="sb-nav-link-icon"><i class="fas fa-building"></i></div>
                    Quản Lý Toà Nhà
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                </a>
                <div class="collapse show" id="collapseBuildings" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link" href="${buildingURL}">Tòa nhà hiện có</a>
                        <a class="nav-link" href="${editBuildingURL}">Thêm tòa nhà</a>
                    </nav>
                </div>


                <a class="nav-link" href="${orderURL}">
                    <div class="sb-nav-link-icon"><i class="fas fa-box"></i></div>
                    Quản Lý Đơn Hàng
                </a>


                <a class="nav-link" href="${customerURL}">
                    <div class="sb-nav-link-icon"><i class="fa fa-user-group"></i></div>
                    Quản Lý Khách Hàng
                </a>


                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseUsers" aria-expanded="false" aria-controls="collapseUsers">
                    <div class="sb-nav-link-icon"><i class="fas fa-user-alt"></i></div>
                    Quản Lý Tài Khoản
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                </a>
                <div class="collapse" id="collapseUsers" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link" href="${userURL}">Danh sách tài khoản</a>
                        <a class="nav-link" href="${editUserURL}">Thêm tài khoản</a>
                        <security:authorize access="hasRole('MANAGER')">
                            <a class="nav-link" href="${updateRoleUserURL}">Cập nhật tài khoản</a>
                        </security:authorize>
                    </nav>
                </div>


                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#collapseBlogs">
                    <div class="sb-nav-link-icon"><i class="fa-solid fa-newspaper"></i></div>
                    Quản Lý Tin Tức
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                </a>
                <div class="collapse" id="collapseBlogs" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link" href="${blogURL}">Xem tin tức</a>
                        <a class="nav-link" href="#">Thêm tin tức</a>
                    </nav>
                </div>

                <security:authorize access="hasRole('MANAGER')">
                    <a class="nav-link" href="${homeURL}">
                        <div class="sb-nav-link-icon"><i class="fas fa-chart-column"></i></div>
                        Thống kê
                    </a>
                </security:authorize>


                <a class="nav-link collapsed" href="#" data-bs-toggle="collapse" data-bs-target="#pagesSupport">
                    <div class="sb-nav-link-icon"><i class="fa-solid fa-circle-info"></i></div>
                    Hỗ Trợ
                    <div class="sb-sidenav-collapse-arrow"><i class="fas fa-angle-down"></i></div>
                </a>
                <div class="collapse" id="pagesSupport" aria-labelledby="headingOne" data-bs-parent="#sidenavAccordion">
                    <nav class="sb-sidenav-menu-nested nav">
                        <a class="nav-link" href="https://www.facebook.com/profile.php?id=61581626553867" target="_blank">Fanpage</a>
                    </nav>
                </div>
            </div>
        </div>
    </nav>
</div>