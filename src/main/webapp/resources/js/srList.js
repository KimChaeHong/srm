$('.detail-btn').on('click', function(){
	srId = $(this).data('srid')
	
	$.ajax({
		url:'/srm/sr/srDetail',
		type: 'POST',
		data: {srId: srId},
		success: function(response){
			console.log('Ajax 통신 성공');
			$('#detail-modal-body').html(response);
		},
		error: function() {
			console.log('Ajax 통신 실패');
		}
		
	});
});

$('#delete-btn').on('click', function(event){
	event.preventDefault();
	$('#detail-form').attr('action', '/srDelete'); // form의 action을 srDelete로 변경
	$('#detail-form').submit(); // form 제출
})

$('#appReq-btn').on('click', function(event){
	event.preventDefault();
	$('#detail-form').attr('action', '/srAppReq'); // form의 action을 srAppReq로 변경
	$('#detail-form').submit(); // form 제출
})