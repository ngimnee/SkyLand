<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@include file="/common/taglib.jsp"%>
<c:url var="blogAPI" value="/api/blog"/>
<c:url var="blogURL" value="/admin/blog"/>

<html>
<head>
    <title>Thêm tin tức</title>
</head>
<body>
    <div class="container-fluid px-4 py-4">
        <div class="mb-4 border-bottom pb-2">
            <div class="d-flex justify-content-between align-items-center">
                <h3 class="fw-bold mb-0">
                    <i class="bi bi-newspaper me-2 text-primary"></i>
                    Thêm tin tức mới
                </h3>
            </div>

            <nav class="mt-1">
                <ol class="breadcrumb mb-0 small">
                    <li class="breadcrumb-item">
                        <a href="${blogURL}">Tin tức</a>
                    </li>
                    <li class="breadcrumb-item active">Thêm mới</li>
                </ol>
            </nav>
        </div>

        <div class="card shadow border-0">
            <div class="card-body p-4">
                <form id="blogForm">
                    <div class="mb-4">
                        <label class="form-label fw-semibold">
                            <span class="text-danger">*</span> Tiêu đề bài viết
                        </label>
                        <input type="text" id="title" class="form-control" placeholder="Nhập tiêu đề bài viết...">
                    </div>

                    <div class="row g-4">
                        <div class="col-md-4">
                            <div class="mb-4">
                                <label class="form-label fw-semibold">Trạng thái</label>
                                <select id="status" class="form-select">
                                    <option value="PUBLISHED">Xuất bản ngay</option>
                                    <option value="SCHEDULED">Đặt lịch</option>
                                </select>
                            </div>

                            <div class="mb-4" id="scheduleBox" style="display:none;">
                                <label class="form-label fw-semibold">Thời gian đăng</label>
                                <input type="text" id="publishedTime" class="form-control" placeholder="YYYY/MM/DD HH:mm">
                                <div class="text-danger mt-1" id="timeError" style="display:none;">
                                    Thời gian không hợp lệ
                                </div>
                            </div>

                            <div class="mb-4">
                                <label class="form-label fw-semibold">Ảnh đại diện</label>
                                <input type="file" id="avatar" class="form-control" accept="image/*">
                                <img id="previewImage" class="img-thumbnail mt-3 shadow-sm" style="max-width:100%; display:none;">
                            </div>
                        </div>

                        <div class="col-md-8">
                            <div class="mb-4">
                                <label class="form-label fw-semibold">
                                    <span class="text-danger">*</span>Nội dung bài viết
                                </label>
                                <textarea id="content" class="form-control" rows="18"></textarea>
                            </div>
                        </div>
                    </div>

                    <div class="d-flex gap-2">
                        <button type="button" class="btn btn-primary" onclick="saveBlog()">
                            <i class="bi bi-save2-fill"></i>Lưu bài viết
                        </button>

                        <a href="${blogURL}" class="btn btn-danger px-4">
                            Hủy
                        </a>
                    </div>
                </form>
            </div>
        </div>
    </div>

    <script>
        function isValidDateTime(value){
            const regex = /^(\d{4})\/(\d{2})\/(\d{2}) (\d{2}):(\d{2})$/;
            if(!regex.test(value)) return false;
            const parts = value.split(/[/ :]/);
            const year = parseInt(parts[0]);
            const month = parseInt(parts[1]) - 1;
            const day = parseInt(parts[2]);
            const hour = parseInt(parts[3]);
            const minute = parseInt(parts[4]);
            const date = new Date(year, month, day, hour, minute);
            return date.getFullYear() === year &&
                   date.getMonth() === month &&
                   date.getDate() === day &&
                   hour < 24 &&
                   minute < 60;
        }

        $(function(){
            flatpickr("#publishedTime",{
                enableTime:true,
                dateFormat:"Y/m/d H:i",
                time_24hr:true,
                allowInput:true
            });

            $('#status').on('change',function(){
                if($(this).val()==='SCHEDULED'){
                    $('#scheduleBox').slideDown(200);
                }else{
                    $('#scheduleBox').slideUp(200);
                }
            });

            $('#status').trigger('change');

            $('#avatar').on('change',function(){
                if(this.files && this.files[0]){
                    const reader = new FileReader();
                    reader.onload=function(e){
                        $('#previewImage').attr('src',e.target.result).fadeIn(300);
                    };
                    reader.readAsDataURL(this.files[0]);
                }
            });

            CKEDITOR.config.versionCheck=false;
            CKEDITOR.replace('content',{
                height:520,
                language:'vi',
                removePlugins:'elementspath',
                toolbar:[
                    ['Bold','Italic','Underline','Strike'],
                    ['NumberedList','BulletedList','Blockquote'],
                    ['Link','Unlink'],
                    ['Image','Table','HorizontalRule'],
                    ['Format','Font','FontSize'],
                    ['TextColor','BGColor'],
                    ['Maximize']
                ]
            });
        });

        function saveBlog(){
            const time=$('#publishedTime').val();
            if(time && !isValidDateTime(time)){
                $('#timeError').show();
                return;
            }
            const data={
                title:$('#title').val(),
                content:CKEDITOR.instances.content.getData(),
                status:$('#status').val(),
                publishedTime:time
            };

            $.ajax({
                url:'${blogAPI}',
                type:'POST',
                contentType:'application/json',
                data:JSON.stringify(data),
                success:function(){
                    alert("Lưu bài viết thành công");
                    window.location.href='${blogURL}';
                },
                error:function(){
                    alert("Lỗi khi lưu bài viết");
                }
            });
        }
    </script>
</body>
</html>