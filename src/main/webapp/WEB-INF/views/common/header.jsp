<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>SRM</title>

<!-- jQuery -->
<script
	src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js"
	defer></script>

<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet">

<!-- SweetAlert2 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css" defer>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11" defer></script>

	
<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

<!-- Bootstrap Icons -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

<!-- Bootstrap JS -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<!-- Custom CSS -->
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common/header.css" />
<link rel="stylesheet" type="text/css"
	href="${pageContext.request.contextPath}/resources/css/common/sideBar.css" />
<script src="${pageContext.request.contextPath}/resources/js/sidebar.js"></script>

</head>

<body>
	<!-- 헤더 -->
	<div id="header">
		<div id="logo-container">
			<img
				src="${pageContext.request.contextPath}/resources/images/OTI-logo.png"
				class="logo"
				onclick="location.href='${pageContext.request.contextPath}'">
		</div>

		<sec:authorize access="isAuthenticated()">
			<!-- 로그인 했다는 뜻 -->
			<div id="info-container">
				<div class="user-profile">
					<span class="badge" id="user-role"><sec:authentication property="principal.member.role1Nm" /></span>				
					<i class="bi bi-person-circle icon"></i>
					<div class="user-name">
						<sec:authentication property="principal.member.memNm" />
					</div>
					<a href="${pageContext.request.contextPath}/member/logout">
						<i class="bi bi-box-arrow-right logout"></i>
					</a>
				</div>
			</div>
		</sec:authorize>
	</div>