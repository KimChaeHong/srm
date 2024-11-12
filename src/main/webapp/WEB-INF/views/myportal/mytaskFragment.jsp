<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!-- 테이블 데이터 행 부분 -->
<div>
	<tbody id="mytask">
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
				<td>${sr001mt.registerName}</td>
				<td>${sr001mt.institutionName}</td>
				<td>${sr001mt.departmentName}</td>
				<td><c:choose>
						<c:when test="${sr001mt.srStat == 'REGI'}">등록</c:when>
						<c:when test="${sr001mt.srStat == 'REQT'}">요청</c:when>
						<c:when test="${sr001mt.srStat == 'REJC'}">반려</c:when>
						<c:when test="${sr001mt.srStat == 'RECE'}">접수</c:when>
						<c:when test="${sr001mt.srStat == 'RERE'}">재검토</c:when>
						<c:otherwise>기타</c:otherwise>
					</c:choose></td>
				<td><fmt:formatDate value="${sr001mt.reqDt}" pattern="yy/MM/dd" /></td>
				<td><fmt:formatDate value="${sr001mt.dueDt}" pattern="yy/MM/dd" /></td>
				<td>
					<button class="detail-btn" data-bs-toggle="modal"
						data-bs-target="#detail-modal">요청 상세</button>
				</td>
			</tr>
		</c:forEach>
	</tbody>
</div>
