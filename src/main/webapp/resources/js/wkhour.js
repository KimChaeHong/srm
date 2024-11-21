$(document).ready(function () {
    // Toast 알림 설정
    let Toast = Swal.mixin({
        toast: true,
        position: 'center',
        showConfirmButton: false,
        timer: 2000,
        timerProgressBar: true,
        showClass: { popup: '' },
        hideClass: { popup: '' },
        didOpen: (toast) => {
            toast.addEventListener('mouseenter', Swal.stopTimer);
            toast.addEventListener('mouseleave', Swal.resumeTimer);
        }
    });

    // 실적등록 불러오는 함수
    function loadWkhour() {
        $.ajax({
            url: '/srm/myportal/wkhour',
            type: 'POST',
            success: function (response) {
                console.log('실적등록 Ajax 통신 성공');
                $('#wkhour-modal-body').html(response); // response로 받은 jsp를 wkhour-modal에 넣기
                updateColumnSums(); // 데이터를 로드한 뒤 합계를 계산
            },
            error: function () {
                console.log('Ajax 통신 실패');
            }
        });
    }

    // 모든 열의 합계를 계산하고 업데이트
    function updateColumnSums() {
        const columnSums = [];

        // 테이블의 모든 행 반복 (합계 행 제외)
        $('#wkhour-table tbody tr:not(.sum-row)').each(function (rowIndex, row) {
            $(row).find('td').each(function (colIndex, cell) {
                const $cell = $(cell);
                if (colIndex >= 3) { // '계획 공수'(3번 열)와 이후 열부터 합산
                    const value = $cell.find('input').length
                        ? parseFloat($cell.find('input').val()) || 0
                        : parseFloat($cell.text()) || 0;

                    columnSums[colIndex] = (columnSums[colIndex] || 0) + value;
                }
            });
        });

        // 합계 행에 합계 값 업데이트
        const $sumRow = $('#wkhour-table tbody tr.sum-row');
        $sumRow.find('td').each(function (colIndex, cell) {
            if (colIndex >= 3) { // '계획 공수'(3번 열)와 이후 열 업데이트
                const sum = columnSums[colIndex] || 0;
                $(cell).text(sum.toFixed(1)); // 소수점 이하 1자리로 설정
            }
        });

        return columnSums; // 열 합계를 반환
    }

    // 입력 필드 값 변경 시 합계 업데이트
    $(document).on('change', '.wkhour-input', function () {
        updateColumnSums();
    });

    // 입력 값 제한 및 Toast 알림
    $(document).on('change', '.wkhour-input', function () {
        const maxValue = 2.0; // 최대값
        const minValue = 0.0; // 최소값
        let value = parseFloat($(this).val()) || 0.0;

        if (value < minValue) {
            value = minValue;
            Toast.fire({
                icon: 'warning',
                title: "0.0 이상의 값을 입력해주세요."
            });
        } else if (value > maxValue) {
            value = maxValue;
            Toast.fire({
                icon: 'warning',
                title: "2.0 이하의 값을 입력해주세요."
            });
        }

        $(this).val(value.toFixed(1)); // 소수점 1자리 유지
        updateColumnSums();
    });

    // 저장 버튼 클릭 시 데이터 전송
    $('#wkhour-save-btn').on('click', function () {
        const wkhourData = [];
        const memId = $('#hidden-mem-id').val();
        const columnSums = updateColumnSums(); // 합계 재계산

        // 열 합계가 2.0을 초과하는지 확인
        for (let i = 5; i < columnSums.length; i++) { // 3번 열부터 체크
            if (columnSums[i] > 2.0) {
                Toast.fire({
                    icon: 'error',
                    title: '일 합계는 2.0을 초과할 수 없습니다.'
                });
                return; // 저장 중단
            }
        }

        // 입력 데이터를 수집
        $('.wkhour-input').each(function () {
            const appSrId = $(this).data('appsrid');
            const wkDt = $(this).data('wkdt');
            const wkHour = $(this).val();

            wkhourData.push({
                memId: memId,
                appSrId: appSrId,
                wkDt: wkDt,
                wkHour: wkHour
            });
        });

        $.ajax({
            url: '/srm/myportal/updateWkhour',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(wkhourData),
            success: function (updateCount) {
                loadWkhour();
                Toast.fire({
                    icon: 'success',
                    title: '실적 저장이 완료되었습니다.'
                });
            },
            error: function () {
                alert('저장 실패: 서버 오류');
            }
        });
    });

    // 모달 버튼 클릭 시 실적 등록 로드
    $(document).on('click', '#wkhour-modal-btn', function () {
        loadWkhour();
    });

    // 초기 합계 계산
    updateColumnSums();
});
