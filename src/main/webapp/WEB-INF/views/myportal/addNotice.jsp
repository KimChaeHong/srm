<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
	rel="stylesheet">
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myportal/addNotice.css" />

</head>
<body>
	<div id="section">
		<div id="container">
			<div class="line">
				<h2 id="h2-style">공지사항 등록 / 수정</h2>
			</div>
			<div class="notice-container">
				<div class="notice-body">

					<form
						action="${pageContext.request.contextPath}/myportal/${noticeDto != null ? 'updateNotice' : 'addNotice'}"
						method="post">

						<!-- 수정 -->
						<c:if test="${noticeDto != null}">
							<input type="hidden" name="noticeId" value="${noticeDto.noticeId}" />
						</c:if>

						<table class="form-table">
							<tr>
								<th>제목</th>
								<td><input type="text" id="noticeTitle" name="noticeTitle"
									class="form-control" placeholder="제목을 입력하세요" maxlength="250"
									required
									value="${noticeDto != null ? noticeDto.noticeTitle : ''}"
									oninput="updateCharCount()" /> </td>
							</tr>
							<tr>
								<th>내용</th>
								<td><textarea id="noticeContent" name="noticeContent"
										class="form-control" placeholder="공지사항에 대한 내용을 입력하세요" rows="8"
										required>${noticeDto != null ? noticeDto.noticeContent : ''}</textarea>
								</td>
							</tr>
						</table>

						<div class="form-actions">
							<a href="${pageContext.request.contextPath}/myportal/selectNotice" class="btn-list">목록</a>
							<button type="submit" class="btn-submit">${noticeDto != null ? '수정 완료' : '등록'}</button>
						</div>
					</form>

				</div>
			</div>


		</div>

	</div>
</body>
</html>