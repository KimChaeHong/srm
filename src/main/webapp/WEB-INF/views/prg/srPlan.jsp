<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SR 계획 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

	<link href="${pageContext.request.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/prg/srPlan.css" rel="stylesheet" type="text/css" />
    

</head>

<body>
    <div id="sr-plan-info"> 

        <div id="title">
            SR 요청 처리정보
        </div>
        <hr>
        <div class="tabs-container d-flex align-items-center">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                    <a class="nav-link pg-tab active" data-bs-toggle="tab" href="#">SR계획정보</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link pg-tab" data-bs-toggle="tab" href="#">SR자원정보</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link pg-tab" data-bs-toggle="tab" href="#">SR진척율</a>
                </li>
            </ul>

            <button id="plan-btn" type="button" class="btn-save">저장</button>
        </div>
        
        <!-- ------------------------SR계획정보 폼-------------------------- -->
        <form id="sr-plan-form">
            <div class="form-group">
                <label for="request-type">요청 구분</label>
                <select id="request-type" class="form-select" name="srType">
		            <option value="IMPR" ${srPlan.srType == 'IMPR' ? 'selected' : ''}>개선</option>
		            <option value="NEW" ${srPlan.srType == 'NEW' ? 'selected' : ''}>신규</option>
		            <option value="ERRO" ${srPlan.srType == 'ERRO' ? 'selected' : ''}>오류</option>
		            <option value="OTHR" ${srPlan.srType == 'OTHR' ? 'selected' : ''}>기타</option>
		        </select>
            </div>

            <div class="form-group">
                <label for="team">처리팀</label>
                <input type="text" id="team" name="deptId" 
           			value="${srPlan.deptId == 'DEV1' ? '개발 1팀' : srPlan.deptId == 'DEV2' ? '개발 2팀' : ''}" >
            </div>

            <div class="form-group">
                <label for="work-type">업무 구분</label>
                <select id="work-type" class="form-select" name="wkType">
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

            <div class="form-group">
                <label for="person">담당자</label>
                <input type="text" id="person" name="mgr" value="${srPlan.mgr }">
            </div>

            <div class="form-group">
                <label for="start-date">목표 시작일</label>
                <input type="text" id="start-date" name="trgStDt" value="${srPlan.trgStDt}">
            </div>

            <div class="form-group">
                <label for="end-date">목표 완료일</label>
                <input type="text" id="end-date" name="trgEndDt" value="${srPlan.trgEndDt }">
            </div>

            <div class="form-group">
                <label for="status">접수 상태</label>
                <select id="status" class="form-select" name="rcpStat">
                    <option value="RECE" ${srPlan.rcpStat == 'RECE' ? 'selected' : ''}>접수</option>
                    <option value="CANC" ${srPlan.rcpStat == 'CANC' ? 'selected' : ''}>취소</option>
                    <option value="HOLD" ${srPlan.rcpStat == 'HOLD' ? 'selected' : ''}>보류</option>
                </select>
            </div>

            <div class="form-group">
                <label for="total-hours">총계획공수</label>
                <input type="text" id="total-hours">
            </div>

            <div class="form-group">
                <label for="review">검토 내용</label>
                <textarea id="review" name="rvwCont">${srPlan.rvwCont }</textarea>
            </div>
        </form>
    </div>

</body>

</html>