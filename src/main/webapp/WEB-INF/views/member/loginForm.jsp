<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SRM</title>
    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js" defer></script>

    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

	<!-- Custom CSS -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/login.css" />

</head>
<body>
	<div class="login-container">
		<span>SRM 시스템 로그인</span>
		
		<c:if test="${not empty loginError}">
		    <div class="alert alert-danger mb-2" role="alert" style="width: 350px; text-align: center; margin: 0 auto;">
		        ${loginError}
		    </div>
		</c:if>
		
		<form method="post" action="${pageContext.request.contextPath}/login">
			<input id="mem-id" type="text" name="mem_id"
				placeholder="ID를 입력해 주세요." required>
			<div id="id-message"></div>

			<input id="mem-pw" type="password" name="mem_pw"
				placeholder="PW를 입력해 주세요." required>
			<div id="pw-message"></div>
			<button type="submit" id="btn-login" class="btn">로그인</button>
		</form>

		<div id="btn-container" class="d-flex align-items-center justify-content-center">
			<a id="btn-signup" href="${pageContext.request.contextPath}/member/signupform" class="btn">회원가입</a>
			<div class="line">|</div>
			<a id="btn-search" class="btn">아이디 & 비밀번호 찾기</a>
		</div>
	</div>
</body>
</html>