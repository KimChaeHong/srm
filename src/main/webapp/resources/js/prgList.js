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
            $('#sr-plan-form').html(response); // response로 받은 jsp를 srPlan에 넣음
        },
        error: function() {
            console.log('Ajax 통신 실패');
        }
    });
}
