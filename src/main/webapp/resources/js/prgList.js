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
    $.ajax({
        url: '/srm/prg/srPlan',
        type: 'POST',
        data: { appSrId: appSrId },
        success: function(response) {
            console.log("Ajax 통신 성공");
            $('#sr-plan-info').html(response); // response로 받은 jsp를 sr-plan-form에 넣음
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
            alert('업데이트 중 오류가 발생했습니다.');
        }
    });
});



