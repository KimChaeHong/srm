document.addEventListener("DOMContentLoaded", function() {
    function updateOptions() {
        const role = document.getElementById("role1").value;
        const instSelect = document.getElementById("instId");
        const deptSelect = document.getElementById("deptId");

        // 기관과 부서 옵션 초기화
        instSelect.innerHTML = '<option selected>선택</option>';
        deptSelect.innerHTML = '<option selected>선택</option>';

        // 역할에 따라 기관과 부서 옵션 추가
        if (role === "GUSR") {
            instSelect.innerHTML += '<option value="MOEL">고용노동부</option>';
            deptSelect.innerHTML += '<option value="EIT">고용보험팀</option><option value="WNT">워크넷팀</option><option value="HRDT">고용24팀</option>';
        } else if (role === "DEVE") {
            instSelect.innerHTML += '<option value="OTI3">OTI</option>';
            deptSelect.innerHTML += '<option value="DEV1">개발 1팀</option><option value="DEV2">개발 2팀</option>';
        } else if (role === "ADMI") {
            instSelect.innerHTML += '<option value="BD">관리부서</option>';
            deptSelect.innerHTML += '<option value="MNG">관리1팀</option>';
        }
    }

    // 역할 선택 시 기관 및 부서 옵션 업데이트
    document.getElementById("role1").addEventListener("change", updateOptions);
});
