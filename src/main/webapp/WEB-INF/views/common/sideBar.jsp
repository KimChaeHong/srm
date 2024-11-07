<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec" %>

<div id="main-content">
<!-- 사이드바 -->
<div id="side-bar" class="col-md-2">
    <div id="chart" class="side-nav-item">
        <a class="side-nav-link disabled sidebar-content" aria-disabled="true">My portal</a>
        <hr class="navbar-vertical-divider" id="sr-hr">
    </div>
    <a class="side-nav-link" id="sr-request" href="${pageContext.request.contextPath}/myportal/mytask">
        <i id="chart" class="bi bi-clipboard-check"></i>나의 할 일
        <i id="chevron" class="bi bi-chevron-right"></i>
    </a>
    <div id="chart" class="side-nav-item">
        <a class="side-nav-link disabled sidebar-content" aria-disabled="true">SR 관리</a>
        <hr class="navbar-vertical-divider" id="sr-hr">
    </div>
    
    <c:choose>
	     <c:when test="${mb001mt.role1 == 'guser'}">
		    <a class="side-nav-link" id="sr-request" href="${pageContext.request.contextPath}/sr/list">
		        <i id="chart" class="bi bi-clipboard-plus"></i>SR 요청 접수
		        <i id="chevron" class="bi bi-chevron-right"></i>
		    </a>
		    <a class="side-nav-link" id="sr-prg" href="${pageContext.request.contextPath}/prg/list">
		        <i id="chart" class="bi bi-clipboard-data-fill"></i>SR 진척 조회
		        <i id="chevron" class="bi bi-chevron-right"></i>
		    </a>
	     </c:when>
	     <c:when test="${mb001mt.role1 == 'deve'}">
		    <a class="side-nav-link" id="sr-request" href="${pageContext.request.contextPath}/sr/list">
		        <i id="chart" class="bi bi-clipboard-plus"></i>: SR 요청 조회
		        <i id="chevron" class="bi bi-chevron-right"></i>
		    </a>
		    <a class="side-nav-link" id="sr-prg" href="${pageContext.request.contextPath}/prg/list">
		        <i id="chart" class="bi bi-clipboard-data-fill"></i>SR 진척 관리
		        <i id="chevron" class="bi bi-chevron-right"></i>
		    </a>
	    </c:when>
	     <c:when test="${mb001mt.role1 == 'admi'}">
		    <a class="side-nav-link" id="sr-request" href="${pageContext.request.contextPath}/sr/list">
		        <i id="chart" class="bi bi-clipboard-plus"></i>SR 요청 관리
		        <i id="chevron" class="bi bi-chevron-right"></i>
		    </a>
		    <a class="side-nav-link" id="sr-prg" href="${pageContext.request.contextPath}/prg/list">
		        <i id="chart" class="bi bi-clipboard-data-fill"></i>SR 진척 조회
		        <i id="chevron" class="bi bi-chevron-right"></i>
		    </a>
	    </c:when>
    </c:choose>

    <div id="chart" class="side-nav-item">
        <a class="side-nav-link disabled sidebar-content" aria-disabled="true">게시판</a>
        <hr class="navbar-vertical-divider" id="sr-hr">
    </div>
    <a class="side-nav-link" id="sr-request" href="#">
        <i id="chart"  class="bi bi-book-half"></i>공지사항
        <i id="chevron" class="bi bi-chevron-right"></i>
    </a>
</div>