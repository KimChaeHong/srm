<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/member/memList.css" />
	
<!-- jQuery 라이브러리 추가 (CDN) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- JavaScript 파일 로드 -->
<script src="${pageContext.request.contextPath}/resources/js/memList.js"></script>


<!-- section -->
<div id="section">
	<!-- 검색창 -->
	<div id="search-container">
		<div id="search-box">
			<div class="searchBox1">
				<ul class="ul-style">
					<li class="li-style first-li">
						<div id="search-thing">소속</div> <select
						class="select-style prg-search">
							<option>Value</option>
					</select>
					</li>
					<li class="li-style">
						<div id="search-thing">부서</div> <select
						class="select-style dept prg-search">
							<option>Value</option>
					</select>
					</li>
					<li class="li-style">
						<div id="search-thing">가입 일자</div>
						<div class="div-style">
							<input type="date" class="date-form date1 prg-search"> -
							<input type="date" class="date-form prg-search">
						</div>
					</li>

				</ul>
			</div>
			<div class="searchBox2">
				<ul class="ul-style">
					<li class="li-style first-li">
						<div id="search-thing">권한</div> <select
						class="select-style prg-search">
							<option>Value</option>
					</select>
					</li>
					<li class="li-style">
						<div id="search-thing">승인여부</div> <select
						class="select-style prg-search">
							<option>Value</option>
					</select>
					</li>
					<li class="li-style">
						<div id="search-thing">이름 검색</div> <input id="search-name"
						type="text">
					</li>
					<div class="btn-box">
						<button id="search-btn" class="search-btn">검색</button>
					</div>
				</ul>
			</div>
		</div>
	</div>
	<!-- 회원목록 -->
	<div id="member-list">
		<h2 id="mem-list-title">회원 목록</h2>
		<hr id="mem-list-hr">
		<div id="table-container" class="overflow-auto">
			<table id="pg-table">
				<thead>
					<tr>
						<th class="col-1">이름</th>
						<th class="col-2">사번</th>
						<th class="col-3">소속</th>
						<th class="col-4">부서</th>
						<th class="col-5">사용자</th>
						<th class="col-6">직급</th>
						<th class="col-7">가입일</th>
						<th class="col-8">승인 여부</th>
						<th class="col-9">회원상세</th>
					</tr>
				</thead>
				<tbody id="allmember">
					<c:forEach items="${memberList}" var="mb001mt">
						<tr>
							<td class="col-1">${mb001mt.memNm}</td>
							<td class="col-2">${mb001mt.memNo}</td>
							<td class="col-3">${mb001mt.instNm}</td>
							<td class="col-4">${mb001mt.deptNm}</td>
							<td class="col-5">${mb001mt.role1Nm}</td>
							<td class="col-6">${mb001mt.role2Nm}</td>
							<td class="col-7"><fmt:formatDate
									value="${mb001mt.firstInptDt}" pattern="yy/MM/dd" /></td>
							<td class="col-8">${mb001mt.appYn}</td>
							<td class="col-9">
								<button class="detail-btn" data-id="${mb001mt.memId}"
								data-bs-toggle="modal" id="detial-btn"
									data-bs-target="#detail-modal">회원 상세</button>
							</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<!-- 페이지 버튼 -->
		<div id="pagination">
			<c:if test="${pager.groupNo > 1}">
				<a class="btn page-btn shadow-sm"
					data-page="${pager.startPageNo - 1}"> <i
					class="bi bi-chevron-left"></i>
				</a>
			</c:if>

			<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}"
				step="1" var="i">
				<a href="${pageContext.request.contextPath}/member/list?pageNo=${i}"
					class="btn page-btn shadow-sm ${pager.pageNo == i ? 'active' : ''}"
					data-page="${i}">${i}</a>
			</c:forEach>

			<c:if test="${pager.groupNo < pager.totalGroupNo}">
				<a class="btn page-btn shadow-sm" data-page="${pager.endPageNo + 1}">
					<i class="bi bi-chevron-right"></i>
				</a>
			</c:if>

			<select class="row-select form-select" id="rowsPerPageSelect">
				<option value="10" ${pager.rowsPerPage == 10 ? 'selected' : ''}>10</option>
				<option value="20" ${pager.rowsPerPage == 20 ? 'selected' : ''}>20</option>
				<option value="30" ${pager.rowsPerPage == 30 ? 'selected' : ''}>30</option>
				<option value="40" ${pager.rowsPerPage == 40 ? 'selected' : ''}>40</option>
			</select> <input type="hidden" id="currentPage" value="${pager.pageNo}" />

		</div>
	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="detail-modal" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="detail-modalLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<p class="modal-title" id="exampleModalLabel">가입 요청 관리</p>
				<button class="close-btn ms-auto" type="button"
					data-bs-dismiss="modal">
					<i class="bi bi-x-square"></i>
				</button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<form>
						<div id="sr-list">
							<div class="container">
								<div class="request">
									<div class="input-div">
										<label>이름</label> <input type="text" id="mem-name"
											name="mem-name" required>
									</div>
									<div class="input-div">
										<label>아이디</label> <input type="text" id="mem-id"
											name="mem-id" required>
									</div>
									<div class="input-div">
										<label>사번</label> <input type="text" id="mem-no" name="mem-no"
											required>
									</div>
									<div class="input-div">
										<label>소속</label> <input type="text" id="inst-id"
											name="inst-id" required>
									</div>
									<div class="input-div">
										<label>부서</label> <input type="text" id="dept-id"
											name="dept-id" required>
									</div>
									<div class="input-div">
										<label>사용자 역할</label> <input type="text" id="role1"
											name="role1" required>
									</div>
									<div class="input-div">
										<label>팀 역할</label> <input type="text" id="role2" name="role2"
											required>
									</div>
									<div class="input-div">
										<label>가입 요청일</label> <input type="text" id="first-inpt-dt"
											name="first-inpt-dt" required>
									</div>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button type="submit" id="ok">가입승인</button>
				<button type="submit" id="reject">거부</button>
			</div>
		</div>
	</div>
</div>
</div>
</body>
</html>