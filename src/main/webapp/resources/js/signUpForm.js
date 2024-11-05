document.addEventListener("DOMContentLoaded", function() {
    // 역할 선택 시 기관 드롭다운의 옵션 설정
    document.getElementById('role1').addEventListener('change', function() {
        const role = this.value;
        const instSelect = document.getElementById('instId');
        const deptSelect = document.getElementById('deptId');
        
        if (role === 'GUSR') {
            // GUSR 선택 시 기관 목록 가져오기
            instSelect.innerHTML = '<option selected>선택</option>';
            deptSelect.innerHTML = '<option selected>선택</option>';

            // AJAX 요청으로 기관 목록 가져오기
            fetch(`/srm/member/institutions`)
                .then(response => response.json())
                .then(data => {
                    data.forEach(inst => {
                        instSelect.innerHTML += `<option value="${inst.instId}">${inst.instNm}</option>`;
                    });
                })
                .catch(error => console.error('Error fetching institutions:', error));

        } else if (role === 'DEVE') {
            // 개발자 선택 시 고정된 기관 및 부서 설정
            instSelect.innerHTML = '<option value="OTI3" selected>OTI3</option>';
            deptSelect.innerHTML = `
                <option value="DEV1">개발 1팀</option>
                <option value="DEV2">개발 2팀</option>
            `;

        } else if (role === 'ADMI') {
            // 관리자 선택 시 고정된 기관 및 부서 설정
            instSelect.innerHTML = '<option value="BD" selected>버디</option>';
            deptSelect.innerHTML = '<option value="MNG">관리 1팀</option>';
            
        } else {
            // 다른 역할 선택 시 기관 및 부서 드롭다운 초기화
            instSelect.innerHTML = '<option selected>선택</option>';
            deptSelect.innerHTML = '<option selected>선택</option>';
        }
    });

    // 기관 선택 시 부서 목록을 가져오는 함수
    document.getElementById('instId').addEventListener('change', function() {
        const instId = this.value;
        const deptSelect = document.getElementById('deptId');
        deptSelect.innerHTML = '<option selected>선택</option>';

        // AJAX 요청으로 부서 목록 가져오기
        fetch(`/srm/member/departments?instId=${instId}`)
            .then(response => response.json())
            .then(data => {
                data.forEach(dept => {
                    deptSelect.innerHTML += `<option value="${dept.cdId}">${dept.cdNm}</option>`;
                });
            })
            .catch(error => console.error('Error fetching departments:', error));
    });
});
