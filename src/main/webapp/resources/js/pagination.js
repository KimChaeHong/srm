document.addEventListener("DOMContentLoaded", function() {
    const rowsPerPageSelect = document.getElementById('rowsPerPageSelect');
    const currentPageInput = document.getElementById('currentPage');

    if (rowsPerPageSelect && currentPageInput) {
        rowsPerPageSelect.addEventListener('change', function() {
            const rowsPerPage = this.value;
            const currentPage = currentPageInput.value;

            // rowsPerPage와 현재 페이지를 URL 파라미터로 전달하여 페이지 리로드
            window.location.href = `mytask?pageNo=${currentPage}&rowsPerPage=${rowsPerPage}`;
        });
    }
});
