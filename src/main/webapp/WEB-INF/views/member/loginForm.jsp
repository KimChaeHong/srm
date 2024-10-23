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

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css"
	rel="stylesheet" />

<script
	src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"
	defer></script>
<script
	src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js"
	defer></script>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/login.css" />


</head>
<body>
	<div class="login-container">
		<span>SRM 시스템 로그인</span>
		<form method="post" action="${pageContext.request.contextPath}/login">
			<input id="mem-id" type="text" name="mem_id"
				placeholder="ID를 입력해 주세요." required>
			<div id="id-message"></div>

			<input id="mem-pw" type="password" name="mem_pw"
				placeholder="PW를 입력해 주세요." required>
			<div id="pw-message"></div>
			<button type="submit" id="btn-login">로그인</button>
		</form>

		<div class="btn">
			<button type="submit" id="btn-signup">회원가입</button>
			<div class="line">|</div>
			<button type="submit" id="btn-search">아이디 & 비밀번호 찾기</button>
		</div>
	</div>
</body>
</html>