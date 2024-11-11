<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memList.css" />

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
		<div id="table-container">
			<table id="pg-table">
				<thead>
					<tr>
						<th class="col-1">이름</th>
						<th class="col-2">사번</th>
						<th class="col-3">소속</th>
						<th class="col-4">부서</th>
						<th class="col-5">사용자역할</th>
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
							<td class="col-3">${mb001mt.instId}</td>
							<td class="col-4">${mb001mt.deptId}</td>
							<td class="col-5">${mb001mt.role1}</td>
							<td class="col-6">${mb001mt.role2}</td>
							<td class="col-7"><fmt:formatDate value="${mb001mt.firstInptDt}" pattern="yy/MM/dd" /></td>
							<td class="col-8">${mb001mt.appYn}</td>
							<td class="col-9">
								<button class="detail-btn" data-bs-toggle="modal"
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
				<a href="${pageContext.request.contextPath}/member/list?pageNo=${i}" class="btn page-btn shadow-sm ${pager.pageNo == i ? 'active' : ''}"
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
				<p class="modal-title" id="exampleModalLabel">요청 상세</p>
				<button class="close-btn ms-auto" type="button"
					data-bs-dismiss="modal">
					<i class="bi bi-x-square"></i>
				</button>
			</div>
			<div class="modal-body">
				<div class="container-fluid">
					<form>
						<div class="row">
							<div class="col-md-6">
								<div>
									<label for="registrant">등록자</label> <input type="text"
										id="registrant" placeholder="이민성" disabled>
								</div>
								<div>
									<label for="registration-date">등록일</label> <input type="date"
										id="registration-date" name="registration-date"
										placeholder="2024.10.01" disabled>
								</div>
								<div class="form-row">
									<label for="completion-date">요청일</label> <input type="date"
										id="completion-date" name="completion-date"
										placeholder="2024.10.01" disabled>
								</div>

							</div>
							<div class="col-md-6">
								<div class="form-row">
									<label for="department">부서</label> <input type="text"
										id="department" name="department" placeholder="고용노동부" disabled>
								</div>
								<div class="form-row">
									<label for="sr-status">요청 상태</label> <input type="text"
										id="sr-status" name="related-system" placeholder="요청" disabled>
								</div>
								<div class="form-row">
									<label for="completion-date">완료(예정)일</label> <input type="date"
										id="completion-date" name="completion-date"
										placeholder="2024.10.01" disabled>
								</div>
							</div>

							<div>
								<div class="form-row">
									<label for="sr-title">SR 제목</label> <input type=" text"
										id="sr-title" name="related-system" placeholder="고용 24 화면 개선"
										disabled>
								</div>

								<div class="form-row">
									<label for="related-system">관련 시스템</label> <input type="text"
										id="related-system" name="related-system" placeholder="고용 보험"
										disabled>
								</div>

								<div class="form-row">
									<label for="sr-content">SR 내용</label>
									<textarea id="sr-content" name="sr-content" disabled>
    1. 목적:

    2. 개선 내용:
    
    3. 고려 사항:
                                            </textarea>
								</div>

								<div class="form-row">
									<label for="attachment">첨부파일</label> <input type="file"
										id="attachment" name="attachment" disabled>
								</div>
							</div>
						</div>
					</form>
				</div>
			</div>
			<div class="modal-footer">
				<button id="save-btn" type="button" class="btn btn-primary">처리</button>
			</div>

		</div>
	</div>
</div>
</div>
</body>
</html>