<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%-- <!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" />

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prg/searchHr.css" />
   <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js" defer></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js" defer></script>

</head>
<body>
	<!-- Button trigger modal -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#mgrModal">추가</button>
   --%>
<!-- Modal -->
<div class="modal modal-lg fade" id="mgr-modal" tabindex="-1"
	aria-hidden="true" aria-labelledby="staticBackdropLabel"
	data-bs-backdrop="static" data-bs-keyboard="false">
	<div class="modal-dialog">
		<div class="modal-content">
			<div class="modal-header ps-3">
				<span class="modal-title">담당자 검색</span>
				<button id="modal-close-btn" type="button" data-bs-dismiss="modal">
					<i class="bi modal-bi-x-square"></i>
				</button>
			</div>
			<div class="modal-body p-3">
				
				<form id="modal-search-box" action="searchMgr" method="GET" 
						class="d-flex justify-content-between align-items-center">
					
					<div id="modal-dept-select" class="d-flex justify-content-center align-items-center">
						<label for="modal-hr-select" class="me-3 modal-label">부서</label> 
						<select id="modal-hr-select" class="modal-hr-select form-select" name="deptId">
							<option value="DEV1">개발 1팀</option>
							<option value="DEV2">개발 2팀</option>
						</select>
					</div>
					<div id="modal-name-search"
						class="d-flex justify-content-center align-items-center">
						<label for="modal-hr-input" class="me-3 modal-label">담당자명</label>
						<input type="text" id="modal-hr-input" class="modal-hr-input form-control" name="memNm">
					</div>
					<button class="btn btn-sm modal-search-btn" type="submit">검색</button>
				</form>
				
				<span class="modal-title ms-2">조회 결과</span>
				<table id="modal-task-table" class="modal-table table">
					<thead class="modal-thead">
						<tr class="modal-tr">
							<th class="modal-col-1"><input class="form-check-input"
								type="checkbox"></th>
							<th class="modal-col-2">부서</th>
							<th class="modal-col-3">역할</th>
							<th class="modal-col-4">직원명</th>
						</tr>
					</thead>
					<tbody class="modal-tbody" id="modal-results-tbody">
						<c:forEach items="${mgrs }" var="mgr">
							<tr>
								<td class="col-1"><input class="form-check-input"
									type="checkbox" value=""></td>
								<td class="col-2">
									<c:choose>
										<c:when test="${mgr.deptId == 'DEV1'}">개발 1팀</c:when>
										<c:when test="${mgr.deptId == 'DEV2'}">개발 2팀</c:when>
									</c:choose>
								</td>
								<td class="col-3">
									<c:choose>
										<c:when test="${mgr.role1 == 'DEVE'}">개발자</c:when>
									</c:choose>
								</td>
								<td class="col-4">${mgr.memNm }</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn modal-last-btn">등록</button>
				<button type="button" class="btn modal-last-btn"
					data-bs-dismiss="modal">닫기</button>
			</div>
		</div>
	</div>
</div>
<script src="${pageContext.request.contextPath}/resources/js/prgList.js"></script>