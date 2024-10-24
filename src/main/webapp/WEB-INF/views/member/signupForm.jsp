<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SRM</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js" defer></script>
<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js" defer></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/signupForm.css"/>

</head>
<body>
	<div id="signup-container">
        <span>SRM 시스템 회원가입</span>
        <form method="post" action="${pageContext.request.contextPath}/signup">
            <div class="d-flex">
                <div id="right-side">
                    <div class="input-div">
                        <label>이름</label>
                        <input type="text" name="mem-name" placeholder="이름을 입력해 주세요." required>
                    </div>
                    <div class="input-div">
                        <label>아이디</label>
                        <input type="text" name="mem-id" placeholder="ID를 입력해 주세요." required>
                    </div>
                    <div class="input-div">
                        <label>비밀번호</label>
                        <input type="text" name="mem-pw" placeholder="PW를 입력해 주세요." required>
                    </div>
                    <div class="input-div">
                        <label>비밀번호 확인</label>
                        <input type="text" name="mem-pw-confirm" placeholder="PW를 다시 입력해 주세요." required>
                    </div>
                </div>
                <div id="left-side">
                    <div class="select-div">
                        <label>역할</label>
                        <select id="role1" class="form-select">
                            <option>선택</option>
                            <option value="일반사용자">일반사용자</option>
                            <option value="개발자">개발자</option>
                            <option value="관리자">관리자</option>
                        </select>
                    </div>
                    <div class="select-div">
                        <label>부서</label>
                        <select class="form-select">
                            <option selected>선택</option>
                            <option value="부서1">부서1</option>
                            <option value="부서2">부서2</option>
                            <option value="부서3">부서3</option>
                        </select>
                    </div>
                </div>
            </div>
            <div class="d-flex justify-content-center">
                <button class="btn btn-sm btn-signup">가입신청</button>
            </div>
        </form>
    </div>

</body>
</html>