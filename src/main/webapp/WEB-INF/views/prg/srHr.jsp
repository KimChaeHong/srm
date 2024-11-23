<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%-- <script src="${pageContext.request.contextPath}/resources/js/prgList.js"></script> --%>
<script src="${pageContext.request.contextPath}/resources/js/srHr.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prg/srHr.css" />

<form id="sr-hr-form" action="" method="post">
    <input type="hidden" id="appSrId" value="${appSrId}" />
    <div id="hr-table-container">
        <table id="hr-table">
            <thead>
                <tr>
                    <th class="hr-col-1"></th>
                    <th class="hr-col-2"></th>
                    <th class="hr-col-3">담당자명</th>
                    <th class="hr-col-4">역할</th>
                    <th class="hr-col-5">계획공수(M/D)</th>
                    <th class="hr-col-6">실적공수(M/D)</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${hrList}" var="hr">
                    <tr>
                        <td class="hr-col-1">${hr.rnum}</td>
                        <td class="hr-col-2">
                            <input class="form-check-input" type="checkbox" value="${hr.memId}" 
                                <c:if test="${memInfo == null || (memInfo.role2 != 'LEAD' && memInfo.role2 != 'MEMB')}">disabled</c:if>>
                        </td>
                        <td class="hr-col-3">${hr.memNm}</td>
                        <td class="hr-col-4">
                            <c:choose>
                                <c:when test="${hr.role2 == 'LEAD'}">개발팀장</c:when>
                                <c:when test="${hr.role2 == 'MEMB'}">개발팀원</c:when>
                            </c:choose>
                        </td>
                        <td class="hr-col-5">
                            <input type="number" name="plnMd" value="${hr.plnMd}" 
                                class="pln" min="0" 
                                <c:if test="${memInfo == null || (memInfo.role2 != 'LEAD')}">disabled</c:if>>
                        </td>
                        <td class="hr-col-6">${hr.wkHour}</td>
                        
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
    
    <div class="btn-container">
	    <c:choose>
	        <%-- 팀장인 경우 모든 버튼 표시 --%>
	        <c:when test="${memInfo != null && memInfo.role2 == 'LEAD'}">
	            <button id="add-btn" class="btn srpg-btn" data-bs-toggle="modal" 
	                data-bs-target="#hr-modal" type="button">추가</button>
	            <button id="del-btn" class="btn srpg-btn" type="button">선택삭제</button>
	            <button id="save-btn" class="btn srpg-btn" type="button">저장</button>
	        </c:when>
	        <%-- 팀원이면 저장 버튼만 표시
	        <c:when test="${memInfo != null && memInfo.role2 == 'MEMB'}">
	            <button id="save-btn" class="btn srpg-btn" type="button" style="margin-left: 100px;">저장</button>
	        </c:when> --%>
	    </c:choose>
	</div>

</form>

