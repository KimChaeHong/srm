<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>

<div id="main-content">
	<!-- 사이드바 -->
	<div id="side-bar" class="col-md-2">
		<div id="chart" class="side-nav-item">
			<a class="side-nav-link disabled sidebar-content"
				aria-disabled="true">My portal</a>
			<hr class="navbar-vertical-divider" id="sr-hr">
		</div> 
		<a class="side-nav-link" id="sr-request"
			href="${pageContext.request.contextPath}/myportal/mytask"> 
			<i id="chart" class="bi bi-collection"></i>
			나의 할 일 <i id="chevron"
			class="bi bi-chevron-right"></i>
		</a>
		<div id="chart" class="side-nav-item">
			<a class="side-nav-link disabled sidebar-content"
				aria-disabled="true">SR 관리</a>
			<hr class="navbar-vertical-divider" id="sr-hr">
		</div>
		<sec:authorize access="hasRole('ROLE_GUSR')">
			<a class="side-nav-link" id="sr-request"
				href="${pageContext.request.contextPath}/sr/list"> <i id="chart"
				class="bi bi-clipboard-plus"></i>SR 요청 접수 <i id="chevron"
				class="bi bi-chevron-right"></i>
			</a>
			<a class="side-nav-link" id="sr-prg"
				href="${pageContext.request.contextPath}/prg/list"> <i
				id="chart" class="bi bi-clipboard-data-fill"></i>SR 진척 조회 <i
				id="chevron" class="bi bi-chevron-right"></i>
			</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_DEVE')">
			<a class="side-nav-link" id="sr-request"
				href="${pageContext.request.contextPath}/sr/list"> <i id="chart"
				class="bi bi-journal-check"></i> SR 요청 조회 <i id="chevron"
				class="bi bi-chevron-right"></i>
			</a>
			<a class="side-nav-link" id="sr-prg"
				href="${pageContext.request.contextPath}/prg/list"> <i
				id="chart" class="bi bi-bar-chart-fill"></i> SR 진척 관리 <i
				id="chevron" class="bi bi-chevron-right"></i>
			</a>
		</sec:authorize>
		<sec:authorize access="hasRole('ROLE_ADMI')">
			<a class="side-nav-link" id="sr-request" 
				href="${pageContext.request.contextPath}/sr/list"> <i id="chart"
				class="bi bi-clipboard-check"></i> SR 요청 관리 <i id="chevron"
				class="bi bi-chevron-right"></i>
			</a>
			<a class="side-nav-link" id="sr-prg"
				href="${pageContext.request.contextPath}/prg/list"> <i
				id="chart" class="bi bi-clipboard-data-fill"></i> SR 진척 조회 <i
				id="chevron" class="bi bi-chevron-right"></i>
			</a>


			<div id="chart" class="side-nav-item">
				<a class="side-nav-link disabled sidebar-content"
					aria-disabled="true">회원관리</a>
				<hr class="navbar-vertical-divider" id="sr-hr">
			</div>
			<a class="side-nav-link" id="sr-request" href="${pageContext.request.contextPath}/member/list"> <i id="chart"
				class="bi bi-person-lines-fill"></i> 회원 목록 <i id="chevron"
				class="bi bi-chevron-right"></i>
			</a>
			<a class="side-nav-link" id="sr-request" href="${pageContext.request.contextPath}/member/list"> 
				<i id="chart" class="bi bi-person-fill-add"></i>
				가입 요청 목록 <i id="chevron"
				class="bi bi-chevron-right"></i>
			</a>
		</sec:authorize>

		<div id="chart" class="side-nav-item">
			<a class="side-nav-link disabled sidebar-content"
				aria-disabled="true">게시판</a>
			<hr class="navbar-vertical-divider" id="sr-hr">
		</div>
		<a class="side-nav-link" id="sr-request" href="#"> <i id="chart"
			class="bi bi-book-half"></i>공지사항 <i id="chevron"
			class="bi bi-chevron-right"></i>
		</a>
	</div>