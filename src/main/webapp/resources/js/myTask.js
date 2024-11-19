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


// 실적등록 불러오는 함수
function loadWkhour() {
    $.ajax({
        url: '/srm/myportal/wkhour',
        type: 'POST',
        success: function(response) {
            console.log('실적등록 Ajax 통신 성공');
            $('#wkhour-modal-body').html(response); // response로 받은 jsp를 wkhour-modal에 넣기
        },
        error: function() {
            console.log('Ajax 통신 실패');
        }
    });
}

$(document).on('click', '#wkhour-modal-btn', function(){
	loadWkhour();
});

$(document).ready(function () {
	// Toast 알림 설정
	let Toast = Swal.mixin({
		toast: true,
		position: 'center',
		showConfirmButton: false,
		timer: 2000,
		timerProgressBar: true,
		showClass: {
			popup: '' // 나타날 때 애니메이션 없음
		},
		hideClass: {
			popup: '' // 사라질 때 애니메이션 없음
		},
		didOpen: (toast) => {
			toast.addEventListener('mouseenter', Swal.stopTimer);
			toast.addEventListener('mouseleave', Swal.resumeTimer);
		}
	});
	
    // 부모 요소에서 이벤트 위임
    $(document).on('blur', '.wkhour-input', function () {
        const maxValue = 2.0; // 최대값
        const minValue = 0.0; // 최소값
        let value = parseFloat($(this).val()) || 0.0; // 숫자로 변환, 빈 값은 0.0

        if (value < minValue) {
            value = minValue; // 최소값으로 설정
            Toast.fire({
                icon: 'warning',
                title: "0.0 이상의 값을 입력해주세요."
            });
        } else if (value > maxValue) {
            value = maxValue; // 최대값으로 설정
            Toast.fire({
                icon: 'warning',
                title: "2.0 이하의 값을 입력해주세요."
            });
        }

        // 소수점 첫째 자리까지 유지
        $(this).val(value.toFixed(1));
    });
});

$(document).ready(function () {
	// Toast 알림 설정
	let Toast = Swal.mixin({
		toast: true,
		position: 'center',
		showConfirmButton: false,
		timer: 2000,
		timerProgressBar: true,
		showClass: {
			popup: '' // 나타날 때 애니메이션 없음
		},
		hideClass: {
			popup: '' // 사라질 때 애니메이션 없음
		},
		didOpen: (toast) => {
			toast.addEventListener('mouseenter', Swal.stopTimer);
			toast.addEventListener('mouseleave', Swal.resumeTimer);
		}
	});
	
    $('#wkhour-save-btn').on('click', function () {
        const wkhourData = [];
        const memId = $('#hidden-mem-id').val();
        
        $('.wkhour-input').each(function () {
            const appSrId = $(this).data('appsrid');
            const wkDt = $(this).data('wkdt');
            const wkHour = $(this).val();

            wkhourData.push({
            	memId: memId,
                appSrId: appSrId,
                wkDt: wkDt,
                wkHour: wkHour
            });
        });

        $.ajax({
            url: '/srm/myportal/updateWkhour',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(wkhourData),
            success: function (updateCount) {
            	loadWkhour();
            	Toast.fire({
                    icon: 'success',
                    title: updateCount+'개의 항목의 저장이 완료되었습니다.'
                });
            },
            error: function (xhr, status, error) {
                alert('저장 실패: ' + error);
            }
        });
        
    });
});
