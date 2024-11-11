/* ------------------------------ 자원 등록 - 모달에서 선택한 자원을 메인 테이블에 추가 ------------------*/
$(document).on('click', '.hr-modal-add-btn', function () {
    // 선택된 자원들의 memId, 이름, 역할을 배열로 저장
    let selectedResources = [];

    $('#hr-modal-results-tbody .form-check-input:checked').each(function () {
        const memId = $(this).val();
        const memNm = $(this).closest('tr').find('.col-4').text().trim(); // 이름 가져오기
        const role1 = $(this).closest('tr').find('.col-3').text().trim(); // 역할 가져오기
        selectedResources.push({ memId: memId, memNm: memNm, role1: role1 });
    });

    // 현재 테이블에 있는 행의 수를 기준으로 rnum 값 설정
    let currentRowCount = $('#hr-table tbody tr').length;

    // 선택한 자원을 메인 테이블에 추가
    selectedResources.forEach(resource => {
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

    // 모달 닫기
    $('#hr-modal').modal('hide');
});


$(document).ready(function() {
    // 저장 버튼 클릭 시 이벤트
    $('#save-btn').on('click', function(e) {
        e.preventDefault();

        const appSrId = $('#appSrId').val(); // 자원정보탭의 appSrId 값
        console.log("appSrId--------------", appSrId);
        let arr = [];

        // 테이블의 각 행에 있는 memId와 plnMd 값 수집
        $('#hr-table tbody tr').each(function() {
            const memId = $(this).find('.form-check-input').val();
            const plnMd = $(this).find('.pln').val();

            arr.push({
                memId: memId,
                plnMd: parseInt(plnMd, 10) || 0
            });
        });

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
                alert("자원 정보가 저장되었습니다!");
            },
            error: function(xhr, status, error) {
                alert("자원 정보 저장에 실패했습니다.");
            }
        });
    });
});
