<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="blogAPI" value="/api/blog"/>
<c:url var="blogURL" value="/admin/blog"/>
<c:url var="editBlogURL" value="/admin/blog/edit"/>

<html>
<head>
    <title>Tin Tức</title>
</head>
<body>
    <div class="container-fluid px-4">
        <div class="mb-4 border-bottom pb-2">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="fw-bold mb-0">
                    <i class="bi bi-newspaper me-2 text-primary"></i>Danh sách tin tức
                </h3>
            </div>

            <nav class="mt-1">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item text-muted">Quản lý</li>
                    <li class="breadcrumb-item active">Tin tức</li>
                </ol>
            </nav>
        </div>

        <div class="card-header d-flex justify-content-between align-items-center mt-4 mb-2">
            <form:form id="searchForm" modelAttribute="blogSearchRequest" action="${blogURL}" method="GET" class="d-flex align-items-center gap-2">
                <label class="fw-semibold mb-0">
                    <span class="text-danger">*</span> Thời gian:
                </label>

                <div class="date-range-box d-flex align-items-center gap-2">
                    <form:input path="fromDate" id="fromDate" type="text"
                        class="form-control" placeholder="Từ ngày" style="width:120px"/>

                    <span>→</span>

                    <form:input path="toDate" id="toDate" type="text"
                        class="form-control" placeholder="Đến ngày" style="width:120px"/>
                </div>

                <button class="btn btn-primary btn-sm" style="width:32px;height:38px">
                    <i class="fas fa-search"></i>
                </button>

                <button type="button" class="btn btn-secondary" onclick="resetDate()">
                    Reset
                </button>
            </form:form>

            <div class="d-flex gap-2">
                <a href="${editBlogURL}" class="btn btn-success btn-sm">
                    <i class="bi bi-plus-lg"></i> Thêm tin tức
                </a>

                <a href="${editBlogURL}" class="btn btn-warning btn-sm">
                    <i class="bi bi-calendar"></i> Đặt lịch
                </a>
            </div>
        </div>

        <!-- TABLE -->
        <div class="card mb-4">
            <div class="card-body">
                <div class="table-responsive">
                    <display:table name="model.listResult"
                                   requestURI="${blogURL}"
                                   id="blog"
                                   class="table table-striped table-bordered"
                                   pagesize="${model.maxPageItems}"
                                   partialList="true"
                                   size="${model.totalItems}">

                        <display:column title="Thời gian" class="text-center" headerClass="text-center">
                            <fmt:formatDate value="${blog.publishedTime}" pattern="dd/MM/yyyy HH:mm"/>
                        </display:column>
                        <display:column property="title" title="Tiêu đề" headerClass="text-center"/>
                        <display:column property="content" title="Nội dung" headerClass="text-center"/>
                        <display:column title="Thao tác" class="text-center" headerClass="text-center">
                            <div class="d-flex justify-content-center gap-2">
                                <a href="${editBlogURL}?id=${blog.id}" class="btn btn-outline-primary btn-sm">
                                    <i class="bi bi-pencil"></i>
                                </a>

                                <button class="btn btn-outline-danger btn-sm" onclick="deleteBlog(${blog.id})">
                                    <i class="bi bi-trash"></i>
                                </button>
                            </div>
                        </display:column>
                    </display:table>
                </div>
            </div>
        </div>
    </div>

    <script>
        $('#checkAll').change(function () {
            $('.checkItem').prop('checked', this.checked);
        });

        function deleteBlog(id){
            if(confirm("Bạn có chắc muốn xóa bài viết này?")){
                $.ajax({
                    url : "${blogAPI}/" + id,
                    type : "DELETE",
                    success : function(){
                        alert("Xóa thành công");
                        location.reload();
                    },
                    error : function(){
                        alert("Xóa thất bại");
                    }
                });
            }
        }

        $('#btnDeleteBlogs').click(function(){
            const ids = [];
            $('.checkItem:checked').each(function(){
                ids.push($(this).val());
            });

            if(ids.length === 0){
                alert("Vui lòng chọn bài viết");
                return;
            }

            if(confirm("Bạn có chắc muốn xóa?")){
                ids.forEach(function(id){
                    deleteBlog(id);
                });
            }
        });

        document.addEventListener("DOMContentLoaded", function () {
            const toPicker = flatpickr("#toDate", {
                dateFormat: "Y-m-d",
                altInput: true,
                altFormat: "d-m-Y"
            });

            flatpickr("#fromDate", {
                dateFormat: "Y-m-d",
                altInput: true,
                altFormat: "d-m-Y",
                onChange: function(selectedDates) {
                    toPicker.set('minDate', selectedDates[0]);
                }
            });
        });

        function resetDate() {
            document.getElementById("fromDate")._flatpickr.clear();
            document.getElementById("toDate")._flatpickr.clear();
            document.getElementById("searchForm").submit();
        }
    </script>
</body>
</html>