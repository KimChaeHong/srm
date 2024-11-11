<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<script src="${pageContext.request.contextPath}/resources/js/prgList.js"></script>
<%-- <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prg/srPlan.css" /> --%>


<!-- ------------------------SR계획정보 폼-------------------------- -->
<form id="sr-plan-form" action="updateSrPlan" method="post">
	<input type="hidden" name="appSrId" value="${srPlan.appSrId}">
	<input type="hidden" id="memNo" name="mgr" value="${srPlan.mgr }">
	
	<div class="form-group">
		<label for="request-type">요청 구분</label> <select id="request-type"
			class="form-select" name="srType">
			<option value="IMPR" ${srPlan.srType == 'IMPR' ? 'selected' : ''}>개선</option>
			<option value="NEW" ${srPlan.srType == 'NEW' ? 'selected' : ''}>신규</option>
			<option value="ERRO" ${srPlan.srType == 'ERRO' ? 'selected' : ''}>오류</option>
			<option value="OTHR" ${srPlan.srType == 'OTHR' ? 'selected' : ''}>기타</option>
		</select>
	</div>

	<div class="form-group">
		<label for="team">처리팀</label> 
		<select id="team" name="deptId" class="form-select">
			<option value="DEV1" ${srPlan.deptId == 'DEV1' ? 'selected' : ''}>개발 1팀</option>
			<option value="DEV2" ${srPlan.deptId == 'DEV2' ? 'selected' : ''}>개발 2팀</option>
		</select>
	</div>

	<div class="form-group">
		<label for="work-type">업무 구분</label> <select id="work-type"
			class="form-select" name="wkType">
			<option value="UNEM" ${srPlan.wkType == 'UNEM' ? 'selected' : ''}>실업급여</option>
			<option value="EMST" ${srPlan.wkType == 'EMST' ? 'selected' : ''}>고용안정</option>
			<option value="WRKP" ${srPlan.wkType == 'WRKP' ? 'selected' : ''}>사업장</option>
			<option value="COLL" ${srPlan.wkType == 'COLL' ? 'selected' : ''}>징수</option>
			<option value="HOME" ${srPlan.wkType == 'HOME' ? 'selected' : ''}>홈페이지</option>
			<option value="UNWR" ${srPlan.wkType == 'UNWR' ? 'selected' : ''}>실업자/근로자</option>
			<option value="EMPL" ${srPlan.wkType == 'EMPL' ? 'selected' : ''}>사업주</option>
			<option value="INTE" ${srPlan.wkType == 'INTE' ? 'selected' : ''}>연계</option>
			<option value="EXNT" ${srPlan.wkType == 'EXNT' ? 'selected' : ''}>외부망</option>
			<option value="MOBI" ${srPlan.wkType == 'MOBI' ? 'selected' : ''}>모바일</option>
			<option value="CARE" ${srPlan.wkType == 'CARE' ? 'selected' : ''}>직업진로/사이버</option>
		</select>
	</div>

	<div id="person-group" class="form-group">
	    <label for="person" id="dam">담당자</label>
	    <div class="input-button-group">
	        <input type="text" id="person" value="${srPlan.mgr}" disabled>
	        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#mgr-modal" 
	        	data-appsrid="${srPlan.appSrId }" id="add-person-btn">추가</button>
	        	<%-- <!-- 실제 사번을 저장할 숨겨진 필드 -->
        		<input type="hidden" name="mgr" id="mgr-hidden" value="${srPlan.mgr}"> --%>
	    </div>
	</div>

	<div class="form-group">
		<label for="start-date">목표 시작일</label> <input type="date"
			id="start-date" name="trgStDt"
			value="<fmt:formatDate value='${srPlan.trgStDt}' pattern='yyyy-MM-dd'/>">

	</div>

	<div class="form-group">
		<label for="end-date">목표 완료일</label> <input type="date"
			id="start-date" name="trgEndDt"
			value="<fmt:formatDate value='${srPlan.trgEndDt}' pattern='yyyy-MM-dd'/>">
	</div>

	<div class="form-group">
		<label for="status">접수 상태</label> <select id="status"
			class="form-select" name="rcpStat">
			<option value="DECE" ${srPlan.rcpStat == 'DECE' ? 'selected' : ''}>접수</option>
			<option value="CANC" ${srPlan.rcpStat == 'CANC' ? 'selected' : ''}>취소</option>
			<option value="HOLD" ${srPlan.rcpStat == 'HOLD' ? 'selected' : ''}>보류</option>
		</select>
	</div>

	<div class="form-group">
		<label for="total-hours">총계획공수</label> <input type="text"
			id="total-hours" disabled>
	</div>

	<div class="form-group">
		<label for="review">검토 내용</label>
		<textarea id="review" name="rvwCont">${srPlan.rvwCont }</textarea>
	</div>
	
	<c:if test="${memInfo != null && memInfo.role1 == 'ROLE_DEVE'}">
	    <button id="plan-btn" type="button" class="btn-save">저장</button>
	</c:if>
	<%-- <p>Role: ${memInfo.role1}</p> --%>


</form>
