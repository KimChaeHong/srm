<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항</title>
<link
    href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css"
    rel="stylesheet">
<script
    src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
<link rel="stylesheet"
    href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<link rel="stylesheet"
    href="${pageContext.request.contextPath}/resources/css/myportal/selectNotice.css" />


</head>
<body>
    <div id="section">
        <!-- SR목록 -->
        <div id="container">
            <div class="line">
                <h2 id="h2-style">공지사항</h2>
                <c:if test="${memRole1  != null &&  memRole1 == 'ROLE_ADMI'}">
                    <a href="${pageContext.request.contextPath}/myportal/addNotice"
                        class="btn-register">공지사항 등록</a>
                </c:if>
            </div>
            <div class="notice-container">
                <table class="notice-table">
                    <thead>
                        <tr>
                            <th>글번호</th>
                            <th>제목</th>
                            <th>등록일자</th>
                            <th>작업</th>
                        </tr>
                    </thead>
                </table>
                <!-- 스크롤 추가 -->
                <div class="table-body">
                    <table class="notice-table">
           	            <tbody>
                            <c:forEach var="notice" items="${notices}">
                                <tr class="clickable-row" onclick="window.location='${pageContext.request.contextPath}/myportal/detailNotice/${notice.noticeId}'">
                                    <td>${notice.noticeId}</td>
                                    <td>${notice.noticeTitle}</td>
                                    <td><fmt:formatDate value="${notice.firstInptDt}" pattern="yyyy-MM-dd" /></td>
                                    <td>
                                        <div class="action-buttons">
                                            <a href="${pageContext.request.contextPath}/myportal/noticeDetail/${notice.noticeId}" class="btn-edit">수정</a>
                                            <form action="${pageContext.request.contextPath}/myportal/deleteNotice/${notice.noticeId}" method="post" style="display:inline;">
                                                <button type="submit" class="btn-delete">삭제</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach> 
                        </tbody>
                    </table>
                </div>
            </div>
            <%-- <!-- 페이지네이션 추가 -->
			<div class="pagination">
			    <c:if test="${pager.startPage > 1}">
			        <a href="?pageNo=${pager.startPage - 1}" class="page-link">&laquo;</a>
			    </c:if>
			    <c:forEach var="i" begin="${pager.startPage}" end="${pager.endPage}">
			        <a href="?pageNo=${i}" class="page-link ${i == pager.pageNo ? 'active' : ''}">${i}</a>
			    </c:forEach>
			    <c:if test="${pager.endPage < pager.totalPages}">
			        <a href="?pageNo=${pager.endPage + 1}" class="page-link">&raquo;</a>
			    </c:if>
			</div> --%>
        </div>
        
    </div>

</body>
</html>
