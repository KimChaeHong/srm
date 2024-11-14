$(document).ready(function() {
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

    // 상세보기 데이터 불러오는 함수
    function loadDetail(srId) {
        $.ajax({
            url: '/srm/sr/srDetail',
            type: 'POST',
            data: { srId: srId },
            success: function(response) {
                console.log('상세보기 Ajax 통신 성공');
                $('#detail-form').html(response); // response로 받은 jsp를 detail-form에 넣기
            },
            error: function() {
                console.log('Ajax 통신 실패');
            }
        });
    }

    // 상세보기 버튼 클릭 시 srId를 로컬 변수로 설정하여 상세보기 불러오기
    $(document).on('click', '.detail-btn', function() {
        const srId = $(this).data('srid');
        loadDetail(srId);
    });

    // 저장 버튼 클릭 시 폼 데이터 제출 (AJAX 요청)
    $(document).off('click', '#save-btn').on('click', '#save-btn', function() {
        const form = $('#detail-form')[0];
        const formData = new FormData(form);
        const file = formData.get('attachment')
        
        $.ajax({
            url: '/srm/sr/srUpdate',
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                console.log('저장 요청 성공');
                if (response == 1) {
                    Toast.fire({
                        icon: 'success',
                        title: '저장이 완료되었습니다.'
                    });
                    loadDetail(formData.get('srId')); // 저장 후 상세보기 갱신
                }
            },
            error: function() {
                console.log('저장 요청 실패');
            }
        });
    });

    // 삭제 확인 후 폼 제출
    $(document).on('click', '#delete-btn', function() {
        Swal.fire({
            text: '정말로 삭제 하시겠습니까?',
            icon: 'warning',
            showCancelButton: true,
            confirmButtonColor: '#d33',
            cancelButtonColor: '#D9D9D9',
            confirmButtonText: '삭제',
            cancelButtonText: '취소',
        }).then(result => {
            if (result.isConfirmed) {
                $('#detail-form').attr('action', 'srDelete').submit();
            }
        });
    });

    // 접수 요청 및 처리 요청 버튼 클릭 시 AJAX로 폼 데이터 제출
    $(document).off('click', '#req-btn, #process-btn').on('click', '#req-btn, #process-btn', function() {
        const action = $(this).is('#req-btn') ? 'srAppReq' : 'srProcess';
        const form = $('#detail-form')[0];
        const formData = new FormData(form);
        const stat = formData.get('srStat');
        let successMessage = null;
        if(stat == 'RECE'){
        	successMessage = '승인처리 되었습니다.'
        }else if(stat == 'REJC'){
        	successMessage = '반려처리 되었습니다.'    	
        }else if(stat == 'RERE'){
        	successMessage = '재검토처리 되었습니다.'    	
        }else if(stat == 'REQT'){
        	successMessage = '접수요청이 완료되었습니다.'    	
        }

        $.ajax({
            url: `/srm/sr/${action}`,
            type: 'POST',
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                console.log(`${action} Ajax 통신 성공`);
                if (response == 1) {
                    Toast.fire({
                        icon: 'success',
                        title: successMessage
                    });
                }
                loadDetail(formData.get('srId')); // 성공 후 상세보기 갱신
            },
            error: function() {
                console.log(`${action} Ajax 통신 실패`);
            }
        });
    });

    // 첨부파일 삭제 버튼 클릭 시 AJAX로 삭제 요청
    $(document).off('click', '.delete-attach').on('click', '.delete-attach', function() {
        const attachId = $(this).data('attachid');
        const oname = $(this).data('oname');

        $.ajax({
            url: '/srm/sr/deleteAttach',
            type: 'GET',
            data: { attachId: attachId },
            dataType: 'text',
            success: function() {
                console.log('첨부파일 삭제 ajax 성공');
                $(`#${attachId}`).remove();

                Toast.fire({
                    icon: 'success',
                    title: `${oname} 파일이 삭제되었습니다.`
                });
            },
            error: function() {
                console.log('첨부파일 삭제 ajax 실패');
            }
        });
    });
});
