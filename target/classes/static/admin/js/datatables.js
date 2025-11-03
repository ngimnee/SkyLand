// Simple-DataTables
// https://github.com/fiduswriter/Simple-DataTables/wiki

window.addEventListener('DOMContentLoaded', event => {
    const datatablesSimple = document.getElementById('datatablesSimple');
    if (datatablesSimple) {
        new simpleDatatables.DataTable(datatablesSimple, {
            searchable: false,           // Tắt thanh tìm kiếm
            perPage: Number.MAX_VALUE,   // Hiển thị tất cả các mục, vô hiệu hóa phân trang
            perPageSelect: false         // Tắt phần chọn số mục mỗi trang
        });
    }
});