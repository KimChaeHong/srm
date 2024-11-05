$(document).ready(function() {
    // 탭 클릭 이벤트 핸들러 설정
    $(".nav-tabs .nav-link").on("click", function(e) {
        e.preventDefault();
        $(".nav-tabs .nav-link").removeClass("active");
        $(this).addClass("active");
        let srStat = $(this).data("srstat");
        loadPage(1, srStat); // 첫 페이지 로드
    });

    // 페이지네이션 클릭 이벤트 핸들러
    $(document).on("click", ".page-btn", function(e) {
        e.preventDefault();
        let pageNo = $(this).data("page");
        let srStat = $(".nav-tabs .nav-link.active").data("srstat");
        loadPage(pageNo, srStat);
    });

    // 행 수 선택 변경 이벤트 핸들러
    $(document).on("change", "#rowsPerPageSelect", function() {
        let rowsPerPage = $(this).val();
        let srStat = $(".nav-tabs .nav-link.active").data("srstat");
        loadPage(1, srStat, rowsPerPage); // 첫 페이지로 이동
    });

    // AJAX로 페이지 로드 함수
    function loadPage(pageNo, srStat, rowsPerPage = 16) {
    	
    	 // mytaskFragment 데이터 로드
        $.ajax({
            url: "/srm/myportal/mytaskFragment",
            method: "GET",
            data: { pageNo: pageNo, srStat: srStat, rowsPerPage: rowsPerPage },
            success: function(data) {
                $("#mytask").html(data); // mytask 영역에 데이터 삽입
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 실패:", error);
            }
        });
        
     // pagination 데이터 로드
        $.ajax({
            url: "/srm/myportal/pagination",
            method: "GET",
            data: { pageNo: pageNo, srStat: srStat, rowsPerPage: rowsPerPage },
            success: function(data) {
                $("#pagination").html(data); // pagination 영역에 데이터 삽입
            },
            error: function(xhr, status, error) {
                console.error("AJAX 요청 실패:", error);
            }
        });
        
     
    }
});
