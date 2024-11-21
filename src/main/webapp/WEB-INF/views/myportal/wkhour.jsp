<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myportal/wkhour.css" />
</head>

<body>

    <span id="coment">*투입실적은 1일(8시간 기준) 합계 1.0으로 입력 바랍니다.(연장근무 시 2.0이내 초과입력 가능)</span>
    <form id="wkhour-form">
    	<input type="hidden" id="hidden-mem-id" value="${memId}" />
	    <table id="wkhour-table">
	        <thead>
	            <tr>
	                <th class="col-1" rowspan="2">SR 번호</th>
	                <th class="col-2" rowspan="2">목표 시작일</th>
	                <th class="col-3" rowspan="2">목표 완료일</th>
	                <th class="col-4" rowspan="2">계획 공수</th>
	                <th class="col-5" rowspan="2">실적 공수</th>
	                <th class="col-6" colspan="7">투입 실적</th>
	            </tr>
	            <tr>
	            	 <c:forEach items="${dayList}" var="day" varStatus="status">
		                 <th class="col-${status.index + 7}">
		                 	<fmt:formatDate value="${day}" pattern="MM/dd(E)"/>
		                 </th>
	            	</c:forEach>
	            </tr>
	        </thead>
	        <tbody>
		        <c:forEach var="sr" items="${assignedSrList}" varStatus="outerStatus">
		            <tr>
		                <!-- SR 기본 정보 -->
		                <td>${sr.appSrId}</td>
		                <td><fmt:formatDate value="${sr.trgStDt}" pattern="yyyy-MM-dd"/></td>
		                <td><fmt:formatDate value="${sr.trgEndDt}" pattern="yyyy-MM-dd"/></td>
		                <td>${sr.plnMd}</td>
		                <td>${sr.actualMd}</td>
		
		                <!-- 날짜별 작업 시간 -->
		                <c:forEach var="work" items="${wkhourList[outerStatus.index]}">
		                    <td>
		                    	<input class="wkhour-input" name="wkhour" type="number"
		                    		value="<fmt:formatNumber pattern="0.0">${work.wkHour != null ? work.wkHour : 0}</fmt:formatNumber>" min="0" max="2"
		                    		data-appsrid="${sr.appSrId}" data-wkdt="<fmt:formatDate value="${work.wkDt}" pattern="yyyy-MM-dd"/>">
		                    </td>
		                </c:forEach>
		            </tr>
		        </c:forEach>
	            <tr class="sum-row">
	                <td class="col-1"></td>
	                <td class="col-2"></td>
	                <td class="col-3">일 합계</td>
	                <td class="col-4 sum-col">0.0</td>
	                <td class="col-5 sum-col">0.0</td>
	                <td class="col-7 sum-col">0.0</td>
	                <td class="col-8 sum-col">0.0</td>
	                <td class="col-9 sum-col">0.0</td>
	                <td class="col-10 sum-col">0.0</td>
	                <td class="col-11 sum-col">0.0</td>
	                <td class="col-12 sum-col">0.0</td>
	                <td class="col-13 sum-col">0.0</td>
	            </tr>
	        </tbody>
	    </table>
    </form>

</body>

</html>