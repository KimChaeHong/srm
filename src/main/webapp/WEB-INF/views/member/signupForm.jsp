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
						<label>이름</label> <input type="text" name="memNm"
							placeholder="이름을 입력해 주세요." required>
					</div>
					<div class="input-div">
						<label>아이디</label> <input value="${memberDto.memId}" type="text"
							name="memId" placeholder="아이디를 입력해 주세요." required>
					</div>
					<div class="input-div">
						<label>비밀번호</label> <input type="password" name="memPw"
							placeholder="비밀번호를 입력해 주세요." required>
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
							<option value="GUSR">일반사용자</option>
							<option value="DEVE">개발자</option>
							<option value="ADMI">관리자</option>
						</select>
					</div>

					<div class="select-div">
						<label>기관</label> 
						<select name="instId" id="instId"
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
</html>