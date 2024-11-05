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

// delete-attach(첨부파일 우측 X버튼) 클릭시 DB에서 첨부파일 삭제 및 첨부파일 목록에서 div도 삭제
$(document).on('click', '.delete-attach', function() {
	const attachId = $(this).data('attachid');
	
	$.ajax({
		url:'/srm/sr/deleteAttach',
		type:'GET',
		data:{attachId : attachId},
		dataType:'text',
		success:function(){
			console.log('첨부파일 삭제 ajax 성공')
			$(`#${attachId}`).remove();
		},
		error: function(){
			console.log('첨부파일 삭제 ajax 실패')			
		}
	});
});