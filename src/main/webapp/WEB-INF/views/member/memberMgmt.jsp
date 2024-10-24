<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SRM</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js" defer></script>
<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js" defer></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memMgmt.css"/>

</head>
<body>
        <!-- section -->
        <div id="section">
            <!-- SR목록 -->
            <div id="sr-list">
                <div>
                    <h2 id="member-list-title">가입 요청 관리</h2>
                    <hr>
                </div>
                <div class="container">
                    <div class="request">
                        <div class="input-div">
                            <label>이름</label>
                            <input type="text" name="mem-name" required>
                        </div>
                        <div class="input-div">
                            <label>아이디</label>
                            <input type="text" name="mem-name" required>
                        </div>
                        <div class="input-div">
                            <label>사번</label>
                            <input type="text" name="mem-name" required>
                        </div>
                        <div class="input-div">
                            <label>소속</label>
                            <input type="text" name="mem-name" required>
                        </div>
                        <div class="input-div">
                            <label>부서</label>
                            <input type="text" name="mem-name" required>
                        </div>
                        <div class="input-div">
                            <label>사용자 역할</label>
                            <input type="text" name="mem-name" required>
                        </div>
                        <div class="input-div">
                            <label>팀 역할</label>
                            <input type="text" name="mem-name" required>
                        </div>
                        <div class="input-div">
                            <label>가입 요청일</label>
                            <input type="text" name="mem-name" required>
                        </div>
                
                        <div class="btn">
                            <button type="submit" id="ok">가입승인</button>
                            <button type="submit" id="reject">거부</button>
                        </div>
                        
                    </div>
                </div>
                
            </div>
        </div>


</body>
</html>