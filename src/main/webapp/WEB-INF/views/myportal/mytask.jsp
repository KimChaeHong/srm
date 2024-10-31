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

<!-- JavaScript 파일 로드 -->
<script src="${pageContext.request.contextPath}/resources/js/pagination.js"></script>



<!-- section -->
<div id="section">
	<!-- SR목록 -->
	<div id="sr-list">
		<div class="task-line">
			<h2 id="h2-style">나의 할 일</h2>
		</div>
		<div class="tabs-container">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link tb-tab active"
					data-bs-toggle="tab" href="#">요청<span class="row-cnt">(0)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link tb-tab"
					data-bs-toggle="tab" href="#">등록<span class="row-cnt">(0)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link tb-tab"
					data-bs-toggle="tab" href="#">반려/재검토<span class="row-cnt">(0)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link tb-tab"
					data-bs-toggle="tab" href="#">접수<span class="row-cnt">(0)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link tb-tab"
					data-bs-toggle="tab" href="#">개발중<span class="row-cnt">(0)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link tb-tab"
					data-bs-toggle="tab" href="#">개발완료<span class="row-cnt">(0)</span></a>
				</li>
			</ul>
		</div>
		<div id="table-container" class="overflow-auto">
			<table id="task-table">
				<thead>
					<tr>
						<th class="mytask-1">No.</th>
						<th class="mytask-2">요청 번호</th>
						<th class="mytask-3">제목</th>
						<th class="mytask-4">관련 시스템</th>
						<th class="mytask-5">등록자</th>
						<th class="mytask-6">소속</th>
						<th class="mytask-7">개발부서</th>
						<th class="mytask-8">상태</th>
						<th class="mytask-9">요청일</th>
						<th class="mytask-10">완료(예정)일</th>
						<th class="mytask-11">상세보기</th>
					</tr>
				</thead>

				<c:forEach items="${mySrList}" var="sr001mt">
					<tbody>
						<tr>
							<td>${sr001mt.rnum}</td>
							<td>${sr001mt.srId}</td>
							<td>${sr001mt.srTitle}</td>
							<td>
								<c:choose>
							        <c:when test="${sr001mt.relSys == 'EMPL'}">고용보험</c:when>
							        <c:when test="${sr001mt.relSys == 'HRDV'}">HRD</c:when>
							        <c:when test="${sr001mt.relSys == 'WORK'}">워크넷</c:when>
							    </c:choose>
							</td>
							<td>등록자</td>
							<td>소속</td>
							<td>부서</td>
							<td>
							    <c:choose>
							        <c:when test="${sr001mt.srStat == 'REGI'}">등록</c:when>
							        <c:when test="${sr001mt.srStat == 'REQT'}">요청</c:when>
							        <c:when test="${sr001mt.srStat == 'REJC'}">반려</c:when>
							        <c:when test="${sr001mt.srStat == 'RECE'}">접수</c:when>
							        <c:when test="${sr001mt.srStat == 'RERE'}">재검토</c:when>
							    </c:choose>
							</td>

							<td><fmt:formatDate value="${sr001mt.reqDt}"
									pattern="yy/MM/dd" /></td>
							<td><fmt:formatDate value="${sr001mt.dueDt}"
									pattern="yy/MM/dd" /></td>
							<td><button class="detail-btn" data-bs-toggle="modal"
									data-bs-target="#detail-modal">요청 상세</button></td>
						</tr>
					</tbody>
				</c:forEach>
			</table>
		</div>

		<div id="pagination">
			<!-- 이전 그룹 -->
			<c:if test="${pager.groupNo>1}">
				<a href="mytask?pageNo=${pager.startPageNo-1}" class="btn page-btn shadow-sm">
					<i class="bi bi-chevron-left"></i> 
				</a>
			</c:if>
			
			<!-- 페이지 이동 -->
			<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1" var="i">
			    <c:if test="${pager.pageNo == i}">
			        <a class="btn page-btn shadow-sm active" 
			           href="mytask?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}">${i}</a>
			    </c:if>
			    <c:if test="${pager.pageNo != i}">
			        <a class="btn page-btn shadow-sm"
			           href="mytask?pageNo=${i}&rowsPerPage=${pager.rowsPerPage}">${i}</a>
			    </c:if>
			</c:forEach>
			<!-- 다음 그룹 -->
			<c:if test="${pager.groupNo <= pager.totalGroupNo}">
			    <a href="mytask?pageNo=${pager.endPageNo + 1}" class="btn page-btn shadow-sm">
			        <i class="bi bi-chevron-right"></i>
			    </a>
			</c:if>

			<!-- 행 수 선택 -->
		    <select class="row-select form-select" id="rowsPerPageSelect">
		        <option value="10" ${pager.rowsPerPage == 10 ? 'selected' : ''}>10</option>
		        <option value="20" ${pager.rowsPerPage == 20 ? 'selected' : ''}>20</option>
		        <option value="30" ${pager.rowsPerPage == 30 ? 'selected' : ''}>30</option>
		        <option value="40" ${pager.rowsPerPage == 40 ? 'selected' : ''}>40</option>
		        <option value="50" ${pager.rowsPerPage == 50 ? 'selected' : ''}>50</option>
		    </select>  
		    <!-- 현재 페이지를 JavaScript에 전달하기 위한 숨겨진 필드 -->
    		<input type="hidden" id="currentPage" value="${pager.pageNo}" />	    
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
				<p class="modal-title" id="exampleModalLabel">개발계획입력</p>
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
									id="attachment" name="attachment">
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







</div>
</body>
</html>