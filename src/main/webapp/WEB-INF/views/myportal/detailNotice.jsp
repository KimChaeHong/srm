<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 상세 보기</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myportal/addNotice.css" />
</head>
<body>
	<div id="section">
		<div id="container">
			<div class="line">
				<h2 id="h2-style">공지사항 상세 보기</h2>
			</div>
			<div class="notice-container">
				<div class="notice-body">

					<!-- 제목 및 내용 표시 -->
					<table class="form-table">
						<tr>
							<th>제목</th>
							<td><input type="text" id="noticeTitle" name="noticeTitle"
								class="form-control" value="${notice.noticeTitle}" readonly /></td>
						</tr>
						<tr>
							<th>내용</th>
							<td><textarea id="noticeContent" name="noticeContent"
									class="form-control" rows="8" readonly>${notice.noticeContent}</textarea></td>
						</tr>
					</table>

					<div class="form-actions">
						<!-- 목록 버튼 -->
						<a href="${pageContext.request.contextPath}/myportal/selectNotice" class="btn-list">목록</a>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
