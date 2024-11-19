<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SRM</title>

<!-- jQuery -->
<script
	src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"
	defer></script>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Bootstrap Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- Bootstrap JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/member/signupForm.css" />

<!-- JavaScript 파일 로드 -->
<script
	src="${pageContext.request.contextPath}/resources/js/signUpForm.js"
	defer></script>

</head>
<body>
	<div id="signup-container">
		<span>SRM 시스템 회원가입</span>
		<form method="post" action="signup">
			<div class="d-flex">
				<div id="right-side">
					<div class="input-div">
						<div class="label">
							<label>이름</label>
						</div>
						<div>
							<input type="text" name="memNm" placeholder="이름을 입력해 주세요."
								required>
						</div>
					</div>

					<div class="input-div">
						<div class="label">
							<label>아이디</label>
						</div>
						<div>
							<div class="input-id">
								<input value="${memberDto.memId}" type="text" name="memId"
									placeholder="아이디를 입력해 주세요." required>
							</div>
							<div class="check-id">
								<p>사용 불가능한 아이디 입니다.</p>
							</div>
						</div>
					</div>

					<div class="input-div">
						<div>
							<label>비밀번호</label>
						</div>
						<div>
							<div class="input-pw">
								<input type="password" name="memPw" placeholder="비밀번호를 입력해 주세요."
									required>
							</div>
							<div class="check-pw">
								<p>사용 불가능한 비밀번호 입니다.</p>
							</div>
						</div>
					</div>




					<!-- <div class="input-div">
                        <label>비밀번호 확인</label>
                        <input 
                        	type="text" 
                        	name="mem-pw-confirm" 
                        	placeholder="비밀번호를 다시 입력해 주세요." required>
                    </div> -->

					<div class="input-div">
						<label>이메일</label> <input value="${memberDto.memEmail}"
							type="email" name="memEmail" placeholder="이메일을 입력하세요." required>
					</div>

				</div>
				<div id="left-side">
					<div class="select-div">
						<label>사용자</label> <select name="role1" id="role1"
							class="form-select">
							<option>선택</option>
							<option value="ROLE_GUSR">일반사용자</option>
							<option value="ROLE_DEVE">개발자</option>
							<option value="ROLE_ADMI">관리자</option>
						</select>
					</div>

					<div class="select-div">
						<label>기관</label> <select name="instId" id="instId"
							class="form-select">
							<option selected>선택</option>
						</select>
					</div>

					<div class="select-div">
						<label>부서</label> <select name="deptId" id="deptId"
							class="form-select">
							<option selected>선택</option>
						</select>
					</div>
				</div>
				<div id="submit-mem" class="d-flex justify-content-center">
					<button type="submit" class="btn btn-sm btn-signup">가입신청</button>
				</div>
		</form>
	</div>
</body>
<script>
document.addEventListener("DOMContentLoaded", function () {
    const form = document.querySelector("form");
    const memIdInput = document.querySelector("input[name='memId']");
    const memPwInput = document.querySelector("input[name='memPw']");
    const memIdError = document.querySelector(".check-id p");
    const memPwError = document.querySelector(".check-pw p");

    // 초기에는 에러 메시지를 숨김
    memIdError.style.display = "none";
    memPwError.style.display = "none";

    // 아이디 유효성 검사
    memIdInput.addEventListener("input", function () {
        const memId = memIdInput.value.trim();
        if (memId.length < 5 || memId.length > 20) {
            memIdError.textContent = "아이디는 5자 이상, 20자 이하로 입력해주세요.";
            memIdError.style.display = "block";
        } else if (!/^[a-zA-Z0-9_]+$/.test(memId)) {
            memIdError.textContent = "아이디는 영문, 숫자, 밑줄(_)만 사용할 수 있습니다.";
            memIdError.style.display = "block";
        } else {
            memIdError.style.display = "none";
        }
    });

    // 비밀번호 유효성 검사
    memPwInput.addEventListener("input", function () {
        const memPw = memPwInput.value.trim();
        if (memPw.length < 8) {
            memPwError.textContent = "비밀번호는 8자 이상이어야 합니다.";
            memPwError.style.display = "block";
        } else if (!/(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}/.test(memPw)) {
            memPwError.textContent = "비밀번호는 문자, 숫자, 특수문자를 포함해야 합니다.";
            memPwError.style.display = "block";
        } else {
            memPwError.style.display = "none";
        }
    });

    // 폼 제출 전 최종 확인
    form.addEventListener("submit", function (e) {
        const memId = memIdInput.value.trim();
        const memPw = memPwInput.value.trim();

        if (memId.length < 5 || memId.length > 20 || !/^[a-zA-Z0-9_]+$/.test(memId)) {
            e.preventDefault();
            alert("아이디를 올바르게 입력해주세요.");
        }

        if (memPw.length < 8 || !/(?=.*[A-Za-z])(?=.*\d)(?=.*[@$!%*#?&])[A-Za-z\d@$!%*#?&]{8,}/.test(memPw)) {
            e.preventDefault();
            alert("비밀번호를 올바르게 입력해주세요.");
        }
    });
});
</script>

</html>