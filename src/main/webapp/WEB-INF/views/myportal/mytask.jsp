<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myportal/mytask.css" />

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
		<div id="table-container">
			<table id="task-table">
				<thead>
					<tr>
						<th>요청 번호</th>
						<th>제목</th>
						<th>관련 시스템</th>
						<th>등록자</th>
						<th>소속</th>
						<th>개발부서</th>
						<th>상태</th>
						<th>요청일</th>
						<th>완료(예정)일</th>
						<th>상세보기</th>
					</tr>
				</thead>
				<tbody>
					<tr>
						<td>SR1008_001</td>
						<td>화면 기능 수정해주세요.</td>
						<td>고용 보험</td>
						<td>이민성</td>
						<td>고용노동부</td>
						<td>서비스 개발 2팀</td>
						<td>반려</td>
						<td>24/10/09</td>
						<td>24/10/16</td>
						<td><button class="detail-btn">요청 상세</button></td>
					</tr>
					<tr>
						<td>SR1008_001</td>
						<td>화면 기능 수정해주세요.</td>
						<td>고용 보험</td>
						<td>이민성</td>
						<td>고용노동부</td>
						<td>서비스 개발 2팀</td>
						<td>반려</td>
						<td>24/10/09</td>
						<td>24/10/16</td>
						<td><button class="detail-btn">요청 상세</button></td>
					</tr>
					<tr>
						<td>SR1008_001</td>
						<td>화면 기능 수정해주세요.</td>
						<td>고용 보험</td>
						<td>이민성</td>
						<td>고용노동부</td>
						<td>서비스 개발 2팀</td>
						<td>반려</td>
						<td>24/10/09</td>
						<td>24/10/16</td>
						<td><button class="detail-btn">요청 상세</button></td>
					</tr>

				</tbody>
			</table>
		</div>

		<div id="pagination">
			<a class="btn page-btn shadow-sm"> <i class="bi bi-chevron-left"></i>
			</a> <a class="btn page-btn shadow-sm active">1</a> <a
				class="btn page-btn shadow-sm">2</a> <a
				class="btn page-btn shadow-sm">3</a> <a
				class="btn page-btn shadow-sm"> <i class="bi bi-chevron-right"></i>
			</a> <select class="row-select form-select">
				<option value="10">10</option>
				<option value="20">20</option>
				<option value="30">30</option>
				<option value="40">40</option>
				<option value="50">50</option>
			</select>
		</div>

	</div>
</div>
</div>
</body>
</html>