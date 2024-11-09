<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<link href="${pageContext.request.contextPath}/resources/css/prg/srRatio.css" rel="stylesheet" type="text/css" />
<form id="prg-ratio-form">
	<div id="pg-table-container">
	    <table id="pg-table">
	        <thead>
	            <tr>
	                <th class="pg-col-1"></th>
	                <th class="pg-col-2">작업구분</th>
	                <th class="pg-col-3">시작일</th>
	                <th class="pg-col-4">완료일</th>
	                <th class="pg-col-5">진척율(%)</th>
	            </tr>
	        </thead>
	        <tbody>
	        	<c:forEach items="${prgRatioList}" var="prgRatio" varStatus="status">
		            <tr>
		                <td class="pg-col-1">${prgRatio.rnum}</td>
		                <td class="pg-col-2">
		                    ${prgRatio.taskTName}
		                    <input type="hidden" name="taskType[${status.index}]" value="${prgRatio.taskType}">
		                </td>
		                <td class="pg-col-3">
		                	<input type="date" class="form-date" name="stDt[${status.index}]" value="<fmt:formatDate value='${prgRatio.stDt}' pattern='yyyy-MM-dd'/>">
		                </td>
		                <td class="pg-col-4">
		                	<input type="date" class="form-date" name="endDt[${status.index}]" value="<fmt:formatDate value='${prgRatio.endDt}' pattern='yyyy-MM-dd'/>">
		                </td>
		                <td class="pg-col-5">
		                	<input type="number" class="form-input" name="prg[${status.index}]" value="${prgRatio.prg}" min="0" max="100">
		                </td>
		            </tr>
	        	</c:forEach>
	       </tbody>
	    </table>
	</div>
</form>
	<button type="button" id="ratio-save-btn" data-appsrid="${prgRatioList[0].appSrId}">저장</button>
