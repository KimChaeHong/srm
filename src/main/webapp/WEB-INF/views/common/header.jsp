<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
    <!-- 부트스트랩 아이콘 -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <!-- 부트스트랩 css -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- 부트스트랩 js -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

    <!-- 개별 css -->
	<link href="${pageContext.request.contextPath}/resources/css/common/header.css" rel="stylesheet" type="text/css" />

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
</body>

</html>