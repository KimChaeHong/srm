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
            $('#sr-plan-info').html(response); // response로 받은 jsp를 sr-plan-form에 넣음
            
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

//appSrId와 일치하는 진척율을 처리정보에 띄우는 함수
function loadPrgRatio(appSrId) {	
	
	$.ajax({
		url:'/srm/prg/srRatio',
		type: 'POST',
		data: {appSrId: appSrId},
		success: function(response){
			console.log('진척율 Ajax 통신 성공');
			$('#sr-container').html(response); //response로 받은 jsp를 sr-container에 넣기
		},
		error: function() {
			console.log('Ajax 통신 실패');
		}
		
	});	
}


$(document).on('click','#sr-ratio-tab', function(){
	appSrId = $(this).data('appsrid');
	loadPrgRatio(appSrId);
});

$(document).ready(function(){
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
	
	$(document).off('click', '#ratio-save-btn').on('click', '#ratio-save-btn', function() {
		var formData = $('#prg-ratio-form').serializeArray();
		var jsonData = [];
		var appSrId = $(this).data('appsrid');
		
		var groupData = {};
		formData.forEach(function(field) {
			var name = field.name;
			var value = field.value;
			
			// 배열 형식으로 묶기
			if (name.includes('[')) {
				var key = name.split('[')[0];
				var index = parseInt(name.match(/\[(\d+)\]/)[1], 10);
				
				if (!groupData[index]) {
					groupData[index] = { appSrId: appSrId }; // 공통 데이터 추가
				}
				groupData[index][key] = value;
			}
		});
		
		// 객체를 배열로 변환
		for (var key in groupData) {
			jsonData.push(groupData[key]);
		}
		
		$.ajax({
			url: '/srm/prg/updatePrgRatio',
			type: 'POST',
			contentType: 'application/json',
			data: JSON.stringify(jsonData),
			success: function(response) {
				console.log('진척율 Update Ajax 통신 성공');
				loadPrgRatio(appSrId);
				Toast.fire({
					icon: 'success',
					title: '진척율이 저장되었습니다.'
				});
			},
			error: function() {
				console.log('Ajax 통신 실패');
			}
		});
		
	});
	
});

