$('.detail-btn').on('click', function(){
	srId = $(this).data('srid')
	
	$.ajax({
		url:'/srm/sr/srDetail',
		type: 'POST',
		data: {srId: srId},
		success: function(response){
			console.log('Ajax 통신 성공');
			$('#detail-form').html(response); //response로 받은 jsp를 detail-form에 넣기
		},
		error: function() {
			console.log('Ajax 통신 실패');
		}
		
	});
});

$(document).ready(function(){
	$(document).on('click', '#save-btn', function(event){
		$('#detail-form').attr('action', 'srUpdate'); // form의 action을 srUpdate로 변경
		$('#detail-form').submit(); // form 제출
	})

	$(document).on('click', '#delete-btn', function(event){
		$('#detail-form').attr('action', 'srDelete'); // form의 action을 srDelete로 변경
		$('#detail-form').submit(); // form 제출
	})
	
	$(document).on('click', '#req-btn', function(event){
		console.log('접수요청')
		$('#detail-form').attr('action', 'srAppReq'); // form의 action을 srAppReq로 변경
		$('#detail-form').submit(); // form 제출
	})

	$(document).on('click', '#process-btn', function(event){
		console.log('처리')
		$('#detail-form').attr('action', 'srProcess'); // form의 action을 srProcess로 변경
		$('#detail-form').submit(); // form 제출
	})
});
