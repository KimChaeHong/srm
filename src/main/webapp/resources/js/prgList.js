/*관련시스템 - 업무구분*/
function changeRelSys(relSys){
	if(relSys.value == "") {
		$('#wkType').html("<option value=''>전체</option>");
	} else {
		$.ajax({
			method: 'get',
			url: "getWkTypeList",
			data: {selectedCdId: relSys.value},
			success: function(data){
				//[ {cdId:xxx, cdNm:yyy}, {...}, {...} ]
				var options = "<option value=''>전체</option>";
				for (let x of data) {
				  options += "<option value='" + x.cdId + "'>" + x.cdNm + "</option>";
				}
				$('#wkType').html(options);
			}
		});
	}
}

/*SR처리 목록 조회 시 커서가 맨 위에 자동선택되어 있게 하기
$(document).ready(function(){
	// 처음 로드 시 한 번만 실행되게끔 플래그 변수 하나 만들어둠 
    let isFirstLoad = true;
    if (isFirstLoad) {
	// 가장 상단에 있는 sr의 appSrId를 자동으로 가져와서 loadDetails함수 호출함
	const firstSr = $("tr#tr-style").first();
		if(firstSr.length){
			const appSrId = firstSr.data("appsrid"); 		// 첫 번째 sr의 appSrId가져옴
			loadSrDetails(appSrId);				//처음 로드할 때 loadSrDetails 호출하면서 첫  SR선택시킴
			firstSr.addClass('selected-sr');
		}
		isFirstLoad = false; // 한 번 실행 후 false로 변경(안그러면 첫 번째 sr을 반복해서 계속 불러옴)
    }
})

/*SR요청 처리정보 - SR계획정보*/
function loadSrDetails(appSrId) {
	// 클릭한 SR 색 지정해서 구분시킴
	$('tr').removeClass('selected-sr');
	$(`tr[data-appsrid='${appSrId}']`).addClass('selected-sr');

    $.ajax({
        url: '/srm/prg/srPlan',
        type: 'POST',
        data: { appSrId: appSrId },
        success: function(response) {
            console.log("Ajax 통신 성공");
            $('#sr-container').html(response); // response로 받은 jsp를 sr-plan-form에 넣음
            
            // SR 클릭 시 무조건 계획정보 탭으로 활성화
            $('.nav-link.pg-tab').removeClass('active'); 	  // 모든 탭 active 클래스 제거
            $('.nav-link.pg-tab').first().addClass('active'); 
        },
        error: function() {
            console.log('Ajax 통신 실패');
        }
    });
    
    //목록 클릭 시 해당하는 상세정보를 우측 상세정보 div에 띄우기
	$.ajax({
		url:'/srm/prg/srDetail',
		type: 'POST',
		data: {appSrId: appSrId},
		success: function(response){
			console.log('Ajax 통신 성공');
			$('#sr-detail').html(response); //response로 받은 jsp를 sr-detail에 넣기
		},
		error: function() {
			console.log('Ajax 통신 실패');
		}
		
	});
}

/*SR계획정보 저장 버튼*/
$('#plan-btn').on('click', function(){
	// 폼 데이터 가져오기
    const formData = $('#sr-plan-form').serialize();
    
    $.ajax({
    	url: 'updateSrPlan',
    	type: 'post',
    	data: formData,
    	success: function(response){
    		alert(response);
    	},
    	error: function() {
            alert('저장 중 오류가 발생했습니다.');
        }
    });
});

$(document).ready(function() {
    const contextPath = getContextPath(); 	// contextPath를 동적으로 가져오기
    
    // 각 탭에 클릭 이벤트 설정
    $('.pg-tab').on('click', function(event){
        event.preventDefault();

        const appSrId = $(this).data('appsrid');
        // 각 탭에 따라 호출할 컨트롤러 URL 설정
        let url;
        if ($(this).text().trim() === "SR계획정보") {
            url = contextPath + "/prg/srPlan";
        } else if ($(this).text().trim() === "SR자원정보") {
            url = contextPath + "/prg/srHr";
        } else if ($(this).text().trim() === "SR진척율") {
            url = contextPath + "/prg/srRatio";
        }

        // ajax로 컨트롤러 URL을 호출하여 JSP 파일을 로드
        $.ajax({
            url: url,
            method: "GET",
            success: function(html) {
                $('#sr-container').html(html);
            },
            error: function() {
                console.error("JSP 삽입 실패");
            }
        });
    });
});
/*SR계획정보 - 담당자 필터링 검색*/
$('.modal-search-btn').on('click', function(e){
	e.preventDefault();  // form 기본 제출 막기

    const formData = $('#modal-search-box').serialize();
	$.ajax({
		url: '/srm/prg/searchMgr', 
        type: 'GET',
        data: formData,
        success: function(response) {
        	$('#modal-results-tbody').html(response);
        },
		error: function() {
			console.log('Ajax 통신 실패');
		}
	})
})
// 모달 - 등록 버튼 클릭 시 선택한 담당자 정보를 가져와서 설정함
$('.modal-last-btn').on('click', function() {
    const selectedPerson = $('input[name="selectedMgr"]:checked');  // 선택한 라디오 버튼
    const selectedMemNo = selectedPerson.val();  // 선택한 담당자 사번
    const selectedDept = selectedPerson.closest('tr').find('.col-2').text().trim();  // 부서명
    const selectedName = selectedPerson.closest('tr').find('.col-4').text().trim();  // 담당자명

    // 담당자의 부서, 이름, 사번을 srPlan.jsp의 계획정보 폼에 설정
    $('#team').val(selectedDept === '개발 1팀' ? 'DEV1' : 'DEV2');
    $('#person').val(selectedName);
    $('#memNo').val(selectedMemNo);

    // 모달 닫기
    $('#mgr-modal').modal('hide');
});



/* 현재 애플리케이션의 루트 경로를 가져옴*/
function getContextPath() {
    const path = window.location.pathname.split('/');
    return path.length > 1 ? `/${path[1]}` : '';
}

/*SR계획정보 - 담당자 찾기 클릭 시 담당자 전체 조회*/
/*$('#add-person-btn').on('click', function(){
	appSrId = $(this).data('appsrid')
	$.ajax({
		url: '/srm/prg/getMgr', 
        type: 'GET',
        data: { appSrId: appSrId },
        success: function(response) {
        	$('#modal-div').html(response);
        	$('#mgr-modal').modal('show');
        },
		error: function() {
			console.log('Ajax 통신 실패');
		}
	})
})*/


