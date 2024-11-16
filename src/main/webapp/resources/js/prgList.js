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

//전역 범위에 플래그 변수 선언
//let isFirstLoad = true;

$(document).ready(function() {
	let isFirstLoad = true;
    // 첫 번째 <tr> 요소를 자동으로 선택하는 로직
    if (isFirstLoad) {
        let firstRow = $('tbody tr').first();
        if (firstRow.length > 0) {
            let appSrId = firstRow.data('appsrid');
            loadSrDetails(appSrId);

            firstRow.addClass('selected-sr');
        }
        
        isFirstLoad = false;
    }
});


let selectedAppSrId = null;
/*SR요청 처리정보 - SR계획정보*/
function loadSrDetails(appSrId) {
	console.log("loadSrDetails 호출 - appSrId:", appSrId); 
	selectedAppSrId = appSrId;
    // 클릭한 SR 색 지정해서 구분시킴
    $('tr').removeClass('selected-sr');
    $(`tr[data-appsrid='${appSrId}']`).addClass('selected-sr');

    $.ajax({
        url: '/srm/prg/srPlan',
        type: 'POST',
        data: { appSrId: appSrId },
        success: function(response) {
            console.log("Ajax 통신 성공");
            $('#sr-container').html(response); // response로 받은 jsp를 sr-container에 넣음
            
            // SR 클릭 시 무조건 계획정보 탭으로 활성화
            $('.nav-link.pg-tab').removeClass('active');
            $('.nav-link.pg-tab').first().addClass('active');

            // 이벤트 핸들러를 다시 등록
            $('#plan-btn').off('click').on('click', function(){
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

            $('.modal-search-btn').off('click').on('click', function(e){
                e.preventDefault(); // form 기본 제출 막기
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
                });
            });

            $('.modal-last-btn').off('click').on('click', function() {
                const selectedPerson = $('input[name="selectedMgr"]:checked');
                const selectedMemNo = selectedPerson.val();
                const selectedDept = selectedPerson.closest('tr').find('.col-2').text().trim();
                const selectedName = selectedPerson.closest('tr').find('.col-4').text().trim();

                $('#team').val(selectedDept === '개발 1팀' ? 'DEV1' : 'DEV2');
                $('#person').val(selectedName);
                $('#memNo').val(selectedMemNo);

                $('#mgr-modal').modal('hide');
            });
        },
        error: function() {
            console.log('Ajax 통신 실패');
        }
    });

    // 목록 클릭 시 해당하는 상세정보를 우측 상세정보 div에 띄우기
    $.ajax({
        url:'/srm/prg/srDetail',
        type: 'POST',
        data: {appSrId: appSrId},
        success: function(response){
            console.log('Ajax 통신 성공');
            $('#sr-detail').html(response);
        },
        error: function() {
            console.log('Ajax 통신 실패');
        }
    });
}
//----------------------자원 정보 로드 함수------------------
function loadSrHr(appSrId) {
    $.ajax({
        url: '/srm/prg/srHr',
        type: 'POST',
        data: { appSrId: appSrId },
        success: function(response) {
            console.log('자원정보 Ajax 통신 성공');
            console.log(appSrId);
            $('#sr-container').html(response); // response로 받은 srHr.JSP를 sr-container에 넣기
            
            $('.hr-modal-search-btn').off('click').on('click', function(e){
                e.preventDefault(); // form 기본 제출 막기
                const formData = $('#hr-modal-search-box').serialize();
                $.ajax({
                    url: '/srm/prg/searchHr',
                    type: 'GET',
                    data: formData,
                    success: function(response) {
                        $('#hr-modal-results-tbody').html(response);
                    },
                    error: function() {
                        console.log('Ajax 통신 실패');
                    }
                });
            });
        },
        error: function() {
            console.log('자원정보 Ajax 통신 실패');
        }
    });
}

//---------------------진척율--------------------------
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
//탭 클릭 이벤트 설정
$(document).on('click', '.pg-tab', function() {
    const tabId = $(this).attr('id'); // 클릭한 탭의 id를 가져옴
    console.log("클릭된 탭 ID:", tabId);
    
    if (selectedAppSrId) {
        // 탭 id에 따라 해당하는 정보 로드
        if (tabId === 'sr-ratio-tab') {
            loadPrgRatio(selectedAppSrId);
        } else if (tabId === 'sr-resource-tab') {
        	console.log("자원 정보 탭 클릭, appSrId:", selectedAppSrId);
            loadSrHr(selectedAppSrId);
        } else {
            loadSrDetails(selectedAppSrId);
        }
    } else {
        console.log('선택된 SR이 없습니다.');
    }
});

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
/* 모달 - 등록 버튼 클릭 시 선택한 담당자 정보를 가져와서 설정함 */
$('.modal-last-btn').on('click', function() {
    const selectedPerson = $('input[name="selectedMgr"]:checked');
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

/*내가 담당한 SR만 보기*/
function filterMySRs() {
    const onlyMySr = $("#my-sr-filter").is(":checked");
    const form = $("#search-container form");
    
    // 폼 데이터를 직렬화하여 현재 폼의 모든 검색 조건을 유지
    const formData = form.serialize() + "&onlyMySr=" + onlyMySr;

    location.href = "list?" + formData;
    
}



/* 현재 애플리케이션의 루트 경로를 가져옴*/
function getContextPath() {
    const path = window.location.pathname.split('/');
    return path.length > 1 ? `/${path[1]}` : '';
}

/*//진척율 탭 클릭 이벤트
$(document).on('click', '#sr-ratio-tab', function() {
    if (selectedAppSrId) {
        loadPrgRatio(selectedAppSrId); // 저장된 selectedAppSrId를 사용하여 함수 호출
    } else {
        console.log('선택된 SR이 없습니다.');
    }
});*/
/*$(document).on('click','#sr-ratio-tab', function(){
	appSrId = $(this).data('appsrid');
	loadPrgRatio(appSrId);
});*/


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
	    var isValid = true;
	    var previousValue = 0;

	    formData.forEach(function(field) {
	        var name = field.name;
	        var value = parseInt(field.value, 10);

	        if (name.startsWith('prg[')) {
	            if (isNaN(value)) {
	                return; // null 값은 검증 제외
	            }
	            if (value <= previousValue || value > 100) {
	            	Toast.fire({
		                icon: 'error',
		                title: '유효하지 않은 진척율입니다.'
		            });
	                isValid = false;
	                return false;
	            }
	            previousValue = value;
	        }

	        if (name.includes('[')) {
	            var key = name.split('[')[0];
	            var index = parseInt(name.match(/\[(\d+)\]/)[1], 10);

	            if (!groupData[index]) {
	                groupData[index] = { appSrId: appSrId }; 
	            }
	            groupData[index][key] = field.value;
	        }
	    });

	    if (!isValid) {
	        return;
	    }

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
// 검색 조건 초기화
$(document).ready(function() {
    // 초기화 버튼 클릭 이벤트
    $('#reset-btn').on('click', function(event) {
        event.preventDefault();
        $('#search-box input[type="text"]').val('');
        $('#search-box input[type="date"]').val('');
        $('#search-box select').prop('selectedIndex', 0);	//셀렉트 박스 첫 번째 옵션 선택함
    });
});

