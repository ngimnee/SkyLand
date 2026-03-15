<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="registerURL" value='/admin/home'/>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<body>
    <section class="py-5">
        <div class="container">
            <div class="row align-items-center">
                <div class="col-lg-6 offset-lg-6">
                    <div class="card login-card card-body p-5">
                        <h3 class="text-center mb-4">Đăng nhập</h3>
                        <!-- THÔNG BÁO LỖI -->
                        <c:if test="${param.incorrectAccount != null}">
                            <div class="alert alert-danger">
                                Sai tài khoản hoặc mật khẩu!
                            </div>
                        </c:if>

                        <c:if test="${param.accessDenied != null}">
                            <div class="alert alert-danger">
                                Bạn không có quyền truy cập!
                            </div>
                        </c:if>

                        <c:if test="${param.sessionTimeout != null}">
                            <div class="alert alert-danger">
                                Phiên đăng nhập đã hết hạn!
                            </div>
                        </c:if>

                        <!-- FORM LOGIN -->
                        <form action="j_spring_security_check" method="post">
                            <div class="form-floating mb-3">
                                <input class="form-control" id="userName" name="j_username" type="text" placeholder="Email" required/>
                                <label for="userName">Username</label>
                            </div>

                            <div class="form-floating mb-3">
                                <input class="form-control" id="password" name="j_password" type="password" placeholder="Password" required/>
                                <label for="password">Mật khẩu</label>
                            </div>

                            <div class="form-check mb-3">
                                <input class="form-check-input" id="remember" type="checkbox"/>
                                <label class="form-check-label" for="remember">Ghi nhớ đăng nhập</label>
                            </div>

                            <div class="d-grid">
                                <button class="btn btn-primary btn-lg" type="submit">
                                    Đăng nhập
                                </button>
                            </div>

                            <div class="d-flex justify-content-end mt-3">
                                <a href="#" onclick="alert('Vui lòng liên hệ Bộ phận hỗ trợ để được cấp lại mật khẩu!'); return false;">
                                    Quên mật khẩu?
                                </a>
                            </div>
                        </form>
                        <hr class="my-4">

                        <!-- LOGIN SOCIAL -->
                        <div class="d-flex justify-content-center gap-3">
                            <a href="#" class="btn btn-outline-danger">
                                <i class="fab fa-google"></i> Google
                            </a>
                            <a href="#" class="btn btn-outline-primary">
                                <i class="fab fa-facebook-f"></i> Facebook
                            </a>
                        </div>

                        <p class="text-center mt-4">
                            Chưa có tài khoản? <a href="${registerURL}">Đăng ký ngay</a>
                        </p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</body>
</html>