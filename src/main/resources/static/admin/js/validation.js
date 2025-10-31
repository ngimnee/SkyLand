(() => {
    'use strict'

    // Lấy tất cả form cần validation
    const forms = document.querySelectorAll('.needs-validation')

    // Lặp qua từng form và ngăn submit nếu không hợp lệ
    Array.from(forms).forEach(form => {
        form.addEventListener('submit', event => {
            if (!form.checkValidity()) {
                event.preventDefault()   // ngăn submit
                event.stopPropagation()
            }
            form.classList.add('was-validated') // hiển thị feedback
        }, false)
    })
})();
