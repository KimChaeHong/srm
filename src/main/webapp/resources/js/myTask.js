$(document).ready(function() {

	// 초기 로딩 시 행 갯수 업데이트
	updateRowCounts();

	let currentPage = 1; // 현재 페이지 번호 기본값
	let currentRowsPerPage = $("#rowsPerPageSelect").val(); // 세션에 저장된 rowsPerPage를 가져와 설정

	// 탭 클릭 이벤트 핸들러 설정
	$(".nav-tabs .nav-link").on("click", function(e) {

		$(".nav-tabs .nav-link").removeClass("active");
		$(this).addClass("active");
		let srStat = $(this).data("srstat");

		currentPage = 1; // 탭을 변경할 때 첫 페이지로 이동
		loadPage(currentPage, srStat, currentRowsPerPage);
	});

	// 페이지네이션 클릭 이벤트 핸들러
	$(document).on("click", ".page-btn", function(e) {

		currentPage = $(this).data("page");
		let srStat = $(".nav-tabs .nav-link.active").data("srstat");
		loadPage(currentPage, srStat, currentRowsPerPage);
	});

	// 행 수 선택 변경 이벤트 핸들러
	$(document).on("change", "#rowsPerPageSelect", function() {
		currentRowsPerPage = $(this).val();
		let srStat = $(".nav-tabs .nav-link.active").data("srstat") || '';
		currentPage = 1; // 행 수 변경 시 첫 페이지로 이동
		loadPage(currentPage, srStat, currentRowsPerPage);
	});
	// AJAX로 페이지 로드 함수
	function loadPage(pageNo, srStat, rowsPerPage) {
		// mytaskFragment 데이터 로드
		$.ajax({
			url : "/srm/myportal/mytaskFragment",
			method : "GET",
			data : {
				pageNo : pageNo,
				srStat : srStat,
				rowsPerPage : rowsPerPage
			},
			success : function(data) {
				$("#mytask").html(data); // mytask 영역에 데이터 삽입
			},
			error : function(xhr, status, error) {
				console.error("AJAX 요청 실패:", error);
			}
		});

		// pagination 데이터 로드
		$.ajax({
			url : "/srm/myportal/pagination",
			method : "GET",
			data : {
				pageNo : pageNo,
				srStat : srStat,
				rowsPerPage : rowsPerPage
			},
			success : function(data) {
				$("#pagination").html(data); // pagination 영역에 데이터 삽입
			},
			error : function(xhr, status, error) {
				console.error("AJAX 요청 실패:", error);
			}
		});
	}

	// 행 갯수 업데이트 함수
    function updateRowCounts() {
        $.ajax({
            url: "/srm/myportal/countStatus",
            method: "GET",
            success: function(data) {
                $(".nav-link.tb-tab").each(function() {
                    const status = $(this).data("srstat");
                    const count = data[status] || 0;
                    $(this).find(".row-cnt").text(`(${count})`);
                });
                
                // 행 갯수 업데이트 후 첫 페이지로 이동
                currentPage = 1;
                let srStat = $(".nav-tabs .nav-link.active").data("srstat") || '';
                loadPage(currentPage, srStat, currentRowsPerPage);
            },
            error: function(xhr, status, error) {
                console.error("행 갯수 업데이트 실패:", error);
            }
        });
    }
});
