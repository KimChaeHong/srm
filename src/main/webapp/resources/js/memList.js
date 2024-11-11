$(document).ready(function() {
	// 상세 버튼 클릭 시 모달에 데이터 채우기
	$('.detail-btn').on('click', function() {
		const memId = $(this).data('id'); // data-id 속성에서 memId 가져오기

		$.ajax({
			url : "/srm/member/memDetail", // 사용자 정보를 가져오는 URL
			type : 'GET',
			data : {
				memId : memId
			},
			success : function(data) {
				// 모달에 HTML 데이터 삽입
				$('#detail-modal .modal-content').html(data);
				$('#detail-modal').modal('show');
			},
			error : function() {
				alert("회원 정보를 가져오는 데 실패했습니다.");
			}
		});
	});

});