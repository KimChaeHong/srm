<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myportal/mytask.css" />
<link
	href="${pageContext.request.contextPath}/resources/css/sr/srForm.css"
	rel="stylesheet" type="text/css" />

<!-- jQuery 라이브러리 추가 (CDN) -->
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- JavaScript 파일 로드 -->
<script src="${pageContext.request.contextPath}/resources/js/myTask.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/wkhour.js"></script>

<script
	src="${pageContext.request.contextPath}/resources/js/librarys.js" defer></script>

<!-- FullCalendar CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.css"
	rel="stylesheet">
<!-- FullCalendar JavaScript -->
<script
	src="https://cdn.jsdelivr.net/npm/fullcalendar@5.11.0/main.min.js"></script>

<!-- Vue -->
<script src="https://cdn.jsdelivr.net/npm/vue/dist/vue.js"></script>

<!-- My portal -->
<div>
	<!-- section -->
	<div id="section">
		<!-- SR목록 -->
		<div id="sr-list">
			<div class="task-line">
				<h2 class="h2-style">나의 할 일</h2>
			</div>
			<div class="tabs-container">
				<sec:authorize access="hasRole('ROLE_GUSR')">
					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link tb-tab active"
							data-bs-toggle="tab" data-srstat="ALL">전체<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="REGI">등록<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="REQT">요청<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="REJC">반려<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="RERE">재검토<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="RECE">접수<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="DEVING">개발중<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="DEVDONE">개발완료<span
								class="row-cnt"></span></a></li>
					</ul>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_ADMI')">
					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link tb-tab active"
							data-bs-toggle="tab" data-srstat="ALL">전체<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="RECE">접수<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="REJC">반려<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="RERE">재검토<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="DEVING">개발중<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="DEVDONE">개발완료<span
								class="row-cnt"></span></a></li>
					</ul>
				</sec:authorize>
				<sec:authorize access="hasRole('ROLE_DEVE')">
					<ul class="nav nav-tabs">
						<li class="nav-item"><a class="nav-link tb-tab active"
							data-bs-toggle="tab" data-srstat="ALL">전체 <span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="ANAL">분석<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="DESI">설계<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="IMPL">구현<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="TEST">시험<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="OPER">반영요청<span
								class="row-cnt"></span></a></li>
						<li class="nav-item"><a class="nav-link tb-tab"
							data-bs-toggle="tab" data-srstat="REFL">운영반영<span
								class="row-cnt"></span></a></li>
					</ul>
				</sec:authorize>
			</div>

			<div id="table-container" class="overflow-auto">
				<table id="task-table">
					<thead>
						<tr>

							<sec:authorize access="hasRole('ROLE_DEVE')">
								<th class="mytask-1">No.</th>
								<th class="mytask-2">SR 번호</th>
								<th class="mytask-3">관련 시스템</th>
								<th class="mytask-4">업무 구분</th>
								<th class="mytask-5">제목</th>
								<th class="mytask-6">요청자</th>
								<th class="mytask-7">완료 요청일</th>
								<th class="mytask-8">완료 예정일</th>
								<th class="mytask-9">접수상태</th>
							</sec:authorize>

							<sec:authorize access="hasAnyRole('ROLE_GUSR', 'ROLE_ADMI')">
								<th class="mytask-1">No.</th>
								<th class="mytask-2">SR 번호</th>
								<th class="mytask-3">관련 시스템</th>
								<th class="mytask-4">제목</th>
								<th class="mytask-5">등록자</th>
								<th class="mytask-6">소속</th>
								<th class="mytask-7">개발부서</th>
								<th class="mytask-8">상태</th>
								<th class="mytask-9">요청일</th>
								<th class="mytask-10">완료(예정)일</th>
								<th class="mytask-11">상세보기</th>
							</sec:authorize>

						</tr>
					</thead>
					<tbody id="mytask">
						<!-- AJAX로 불러온 데이터가 여기에 추가됩니다 -->
						<c:forEach items="${mySrList}" var="sr001mt">
							<tr>
								<td>${sr001mt.rnum}</td>
								<td>${sr001mt.srId}</td>
								<td>${sr001mt.srTitle}</td>
								<td><c:choose>
										<c:when test="${sr001mt.relSys == 'EMPL'}">고용보험</c:when>
										<c:when test="${sr001mt.relSys == 'HRDV'}">HRD</c:when>
										<c:when test="${sr001mt.relSys == 'WORK'}">워크넷</c:when>
										<c:otherwise>기타</c:otherwise>
									</c:choose></td>
								<td>등록자</td>
								<td>소속</td>
								<td>부서</td>
								<td><c:choose>
										<c:when test="${sr001mt.srStat == 'REGI'}">등록</c:when>
										<c:when test="${sr001mt.srStat == 'REQT'}">요청</c:when>
										<c:when test="${sr001mt.srStat == 'REJC'}">반려</c:when>
										<c:when test="${sr001mt.srStat == 'RECE'}">접수</c:when>
										<c:when test="${sr001mt.srStat == 'RERE'}">재검토</c:when>
										<c:otherwise>기타</c:otherwise>
									</c:choose></td>
								<td><fmt:formatDate value="${sr001mt.reqDt}"
										pattern="yy/MM/dd" /></td>
								<td><fmt:formatDate value="${sr001mt.dueDt}"
										pattern="yy/MM/dd" /></td>
								<td>
									<button class="detail-btn" data-bs-toggle="modal"
										data-bs-target="#detail-modal">요청 상세</button>
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
					<a
						class="btn page-btn shadow-sm ${pager.pageNo == i ? 'active' : ''}"
						data-page="${i}">${i}</a>
				</c:forEach>

				<c:if test="${pager.groupNo < pager.totalGroupNo}">
					<a class="btn page-btn shadow-sm"
						data-page="${pager.endPageNo + 1}"> <i
						class="bi bi-chevron-right"></i>
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

	<div id="footer-container" class="d-flex">
		<!-- sr 일정 달력 -->

		<div id="calendar-container">
			<div class="d-flex">
				<div id="calendar-box">
					<div id="calendar"></div>
				</div>
				<div id="progress">
					<div>
						<h2 id="process-title">현재 진행중인 SR</h2>
					</div>
					<div id="task-processbar">
						<div class="progressbar-container overflow-auto">

							<progressbar v-for="(item, index) in items" :key="index"
								:target="item.value" :border-color="item.color"
								:start-date="item.startDate" :end-date="item.endDate">
							<div class="progress-value" slot-scope="props">
								<span class="lang">{{ item.key }}</span> <span>{{
									item.value }}%</span>
							</div>
							</progressbar>
						</div>
					</div>
				</div>
			</div>
		</div>

		<div class="myportalNotice-container">
			<div class="notice-container">
				<div class="notice-header">공지사항</div>
				<div class="notice-body">
					<table class="notice-table">
						<thead>
							<tr>
								<th>글번호</th>
								<th>제목</th>
								<th>등록일자</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach var="notice" items="${notices}">
								<tr class="clickable-row" id="notice-tr"
									onclick="window.location='${pageContext.request.contextPath}/myportal/detailNotice/${notice.noticeId}'">
									<td>${notice.noticeId}</td>
									<td>${notice.noticeTitle}</td>
									<td><fmt:formatDate value="${notice.firstInptDt}"
											pattern="yyyy-MM-dd" /></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>




</div>

<!-- Modal -->
<div class="modal fade" id="detail-modal" data-bs-backdrop="static"
	data-bs-keyboard="false" tabindex="-1"
	aria-labelledby="staticBackdropLabel" aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header">
				<p class="modal-title" id="exampleModalLabel">요청상세</p>
				<button id="close-btn" type="button" data-bs-dismiss="modal">
					<i class="bi bi-x-square"></i>
				</button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<div class="row">
						<div class="col-md-6">
							<div>
								<label for="registrant">등록자</label> <input type="text"
									id="registrant" name="registrant">
							</div>
							<div>
								<label for="registration-date">등록일</label> <input type="date"
									id="registration-date" name="registration-date">
							</div>
							<div class="form-row">
								<label for="completion-date">요청일</label> <input type="date"
									id="completion-date" name="completion-date">
							</div>

						</div>

						<div class="col-md-6">
							<div class="form-row">
								<label for="department">부서</label> <input type="text"
									id="department" name="department">
							</div>
							<div class="form-row">
								<label for="sr-status">요청 상태</label> <input type="text"
									id="sr-status" placeholder="요청" name="related-system" disabled>
							</div>
							<div class="form-row">
								<label for="completion-date">완료(예정)일</label> <input type="date"
									id="completion-date" name="completion-date">
							</div>
						</div>

						<div>
							<div class="form-row">
								<label for="sr-title"">SR 제목</label> <input type=" text"
									id="sr-title" name="related-system">
							</div>

							<div class="form-row">
								<label for="related-system">관련 시스템</label> <input type="text"
									id="related-system" name="related-system">
							</div>

							<div class="form-row">
								<label for="sr-content">SR 내용</label>
								<textarea id="sr-content" name="sr-content">
        1. 목적:

        2. 개선 내용:
        
        3. 고려 사항:
                                </textarea>
							</div>

							<div class="form-row">
								<label for="attachment">첨부파일</label> <input type="file"
									class="form-control form-control-sm" id="attachment"
									name="attachment" multiple>
							</div>
						</div>

					</div>
				</div>
			</div>
			<div class="modal-footer">
				<button id="save-btn" type="button" class="btn btn-primary">저장</button>
			</div>
		</div>
	</div>
</div>

<!-- 실적등록 모달 버튼 -->
<c:if test="${userRole == 'ROLE_DEVE'}">
	<button id="wkhour-modal-btn" type="button" class="btn btn-primary"
		data-bs-toggle="modal" data-bs-target="#wkhour-modal">실적등록</button>
</c:if>
<!-- 실적등록 Modal -->
<div class="modal fade" id="wkhour-modal" tabindex="-1"
	aria-hidden="true">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header ps-3">
				<span class="modal-title">SR실적등록</span>
				<button id="close-btn" type="button" data-bs-dismiss="modal">
					<i class="bi bi-x-square"></i>
				</button>
			</div>
			<div id="wkhour-modal-body" class="modal-body p-3"></div>

			<div class="modal-footer">
				<button id="wkhour-save-btn" type="button" class="btn last-btn">저장</button>
				<button type="button" class="btn last-btn" data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>

</div>

</body>
</html>