<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css"/>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common/header.css"  />
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/common/sideBar.css"  />
    
</head>

<body>
    <!-- 헤더 -->
    <div id="header">
        <div id="logo-container">
            <img src="${pageContext.request.contextPath}/resources/images/SRM-logo.png" class="logo">
        </div>
        <div id="info-container">
            <div class="user-profile">
                <span class="badge" id="user-role">개발자</span>
                <i class="bi bi-person-circle icon"></i>
                <div class="user-name">이민성 님</div>
                <i class="bi bi-box-arrow-right logout"></i>
            </div>
            
        </div>
    </div>
