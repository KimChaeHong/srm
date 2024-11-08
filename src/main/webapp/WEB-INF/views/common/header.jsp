<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SRM</title>

    <!-- jQuery -->
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js" defer></script>

    <!-- SweetAlert2 -->
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
	
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- Custom CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common/header.css"  />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common/sideBar.css"  />
    
</head>

<body>
    <!-- 헤더 -->
		<div id="header">
		    <div id="logo-container">
		        <img src="${pageContext.request.contextPath}/resources/images/OTI-logo.png" class="logo" 
		       	onclick="location.href='${pageContext.request.contextPath}'">
		    </div>
		    
			<sec:authorize access="isAuthenticated()"><!-- 로그인 했다는 뜻 -->
			    <div id="info-container">
			        <div class="user-profile">
			            <span class="badge" id="user-role">일반 사용자</span>
			            <i class="bi bi-person-circle icon"></i>
			            <div class="user-name"><sec:authentication property="principal.userDto.memNm"/></div>
			            
			            <a href="${pageContext.request.contextPath}/member/logout"><i class="bi bi-box-arrow-right logout"></i></a>
			        </div>
			    </div>     
		    </sec:authorize>
		</div>
