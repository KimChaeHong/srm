/* ------------------------------ 자원 등록 - 모달에서 선택한 자원을 메인 테이블에 추가 ------------------*/
// 중복 방지를 위해 기존 이벤트 핸들러를 제거하고 다시 등록
$(document).off('click', '.hr-modal-add-btn').on('click', '.hr-modal-add-btn', function () {
    // 선택된 자원들의 memId, 이름, 역할을 배열로 저장
    let arr = [];

    $('#hr-modal-results-tbody .form-check-input:checked').each(function () {
        const memId = $(this).val();
        const memNm = $(this).closest('tr').find('.col-4').text().trim(); // 이름 가져오기
        const role1 = $(this).closest('tr').find('.col-3').text().trim(); // 역할 가져오기
        
        // 이미 추가된 memId인지 확인
        if ($('#hr-table tbody .form-check-input[value="' + memId + '"]').length === 0) {
        	arr.push({ memId: memId, memNm: memNm, role1: role1 });
        }
    });

    // 현재 테이블에 있는 행의 수를 기준으로 rnum 값 설정
    let currentRowCount = $('#hr-table tbody tr').length;

    // 선택한 자원을 메인 테이블에 추가
    arr.forEach(resource => {
        currentRowCount++; // rnum 값을 1씩 증가

        $('#hr-table tbody').append(`
            <tr>
                <td class="hr-col-1">${currentRowCount}</td> <!-- 증가된 rnum 값 사용 -->
                <td class="hr-col-2">
                    <input class="form-check-input" type="checkbox" value="${resource.memId}">
                </td>
                <td class="hr-col-3">${resource.memNm}</td>
                <td class="hr-col-4">${resource.role1}</td> <!-- 줄 바꿈 제거 -->
                <td class="hr-col-5">
                    <input type="number" name="plnMd" value="0" class="pln" min="0">
                </td>
                <td class="hr-col-6"></td>
                <td class="hr-col-7">
                    <i class="bi bi-journal"></i>
                </td>
            </tr>
        `);
    });

    $('#hr-modal').modal('hide');
});

$(document).ready(function() {
    // 저장 버튼 클릭 시 이벤트
    $('#save-btn').on('click', function(e) {
        e.preventDefault();

        const appSrId = $('#appSrId').val(); // 자원정보탭의 appSrId 값
        let arr = [];

        // 체크된 자원의 memId와 plnMd 값을 배열에 추가
        $('#hr-table .form-check-input:checked').each(function() {
            const memId = $(this).val(); 	// 체크된 자원의 memId
            const plnMd = $(this).closest('tr').find('.pln').val(); // 계획 공수(plnMd)

            arr.push({
                memId: memId,
                plnMd: parseInt(plnMd, 10) || 0 // 공수 값이 없으면 0으로
            });
        });

        if (arr.length === 0) {
            Swal.fire({
                title: '알림',
                text: '저장할 자원을 선택해 주세요.',
                icon: 'warning',
                confirmButtonText: '확인'
            });
            return;
        }

        const data = {
            appSrId: appSrId,
            memInfo: arr
        };

        console.log(data);
        
        // 서버로 JSON 데이터 전송
        $.ajax({
            url: '/srm/prg/updateHr',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function(response) {
                Swal.fire({
                    title: '성공!',
                    text: '자원 정보가 저장되었습니다!',
                    icon: 'success',
                    confirmButtonText: '확인'
                });
            },
            error: function(xhr, status, error) {
                Swal.fire({
                    title: '오류!',
                    text: '자원 정보 저장에 실패했습니다.',
                    icon: 'error',
                    confirmButtonText: '확인'
                });
            }
        });
    });

    // 삭제 버튼 클릭 시 이벤트
    $('#del-btn').on('click', function () {
        let arr = [];

        // 체크된 자원 수 확인
        const selectedResources = $('#hr-table .form-check-input:checked');
        if (selectedResources.length === 0) {
            Swal.fire({
                title: '알림',
                text: '삭제할 자원을 선택해 주세요.',
                icon: 'warning',
                confirmButtonText: '확인'
            });
            return; // 선택된 자원이 없으면 실행 중단
        }

        selectedResources.each(function () {
            const memId = $(this).val();
            arr.push({ memId: memId }); // 각 memId를 객체로 추가
            
            $(this).closest('tr').remove(); // UI에서 행 삭제
        });

        const appSrId = $('#appSrId').val();

        const data = {
            appSrId: appSrId,
            memInfo: arr
        };

        $.ajax({
            url: '/srm/prg/deleteHr',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(data),
            success: function (response) {
                Swal.fire({
                    title: '성공!',
                    text: '선택된 자원이 삭제되었습니다!',
                    icon: 'success',
                    confirmButtonText: '확인'
                });
            },
            error: function (xhr, status, error) {
                Swal.fire({
                    title: '오류!',
                    text: '자원 삭제에 실패했습니다.',
                    icon: 'error',
                    confirmButtonText: '확인'
                });
            }
        });
    });
    
});
