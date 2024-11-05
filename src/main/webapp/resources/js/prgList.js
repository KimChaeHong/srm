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

/*SR요청 처리정보 - SR계획정보*/
function loadSrDetails(appSrId) {
	// 클릭한 SR 색 지정해서 구분시킴
	$('tr').removeClass('selected-sr');
    $(event.currentTarget).addClass('selected-sr');

    $.ajax({
        url: '/srm/prg/srPlan',
        type: 'POST',
        data: { appSrId: appSrId },
        success: function(response) {
            console.log("Ajax 통신 성공");
            $('#sr-container').html(response); // response로 받은 jsp를 sr-plan-form에 넣음
            /*$('#sr-plan-form :input').prop('disabled', false);*/
         // SR 클릭 시 무조건 계획정보 탭으로 활성화
            $('.nav-link.pg-tab').removeClass('active'); 	  // 모든 탭 active 클래스 제거
            $('.nav-link.pg-tab').first().addClass('active'); // SR계획정보 탭에 active 클래스 추가
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
/* 현재 애플리케이션의 루트 경로를 가져옴*/
function getContextPath() {
    const path = window.location.pathname.split('/');
    return path.length > 1 ? `/${path[1]}` : '';
}

$(document).ready(function() {
    const contextPath = getContextPath(); 	// contextPath를 동적으로 가져오기
    /*disableForm();*/
    
    // 각 탭에 클릭 이벤트 설정
    $('.pg-tab').on('click', function(event){
        event.preventDefault();

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
                /*$('#sr-plan-form :input').prop('disabled', false);*/
            },
            error: function() {
                console.error("JSP 삽입 실패");
            }
        });
    });
    
});

/*//기본 폼을 비활성화 상태로 설정하는 함수
function disableForm() {
    $('#sr-plan-form :input').prop('disabled', true);
}*/


