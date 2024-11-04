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

//등록 시 첨부파일

let selectedFiles = [];

// 파일 선택 시 배열에 파일을 추가
$("#attachment").on("change", function(event) {
    const files = event.target.files;
    for (let i = 0; i < files.length; i++) {
        selectedFiles.push(files[i]);
    }
});

function submitForm() {
	const formData = new FormData(document.getElementById('register-form'));

    selectedFiles.forEach(file => {
        formData.append("files", file);
    });

    $.ajax({
        url: "srm/sr/registerSr",
        type: "POST",
        data: formData,
        processData: false,
        contentType: false,
        success: function(response) {
            alert("파일 업로드 성공");
        },
        error: function(xhr, status, error) {
            console.error("업로드 실패:", error);
        }
    });
}
