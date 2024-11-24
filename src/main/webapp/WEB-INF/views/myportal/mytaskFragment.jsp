<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib uri="http://www.springframework.org/security/tags" prefix="sec"%>

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

<sec:authorize access="hasRole('ROLE_DEVE')">
			
	
                
                        
                        <tbody>
                            <tr>
                            	<td>1</td>
                                <td>SR1008_001</td>
                                <td>화면 기능 수정해주세요.</td>
                                <td>고용 보험</td>
                                <td>이민성</td>
                                <td>고용노동부</td>
                                
                                <td>24/10/09</td>
                                <td>24/10/16</td>
                                <td>설계</td>
                            </tr>
                               <tr>
                            	<td>2</td>
                                <td>SR1008_002</td>
                                <td>화면 기능 수정해주세요.</td>
                                <td>고용 보험</td>
                                <td>이민성</td>
                                <td>고용노동부</td>
                                
                                <td>24/10/09</td>
                                <td>24/10/16</td>
                                <td>설계</td>
                            </tr>
                           <tr>
                            	<td>3</td>
                                <td>SR1008_301</td>
                                <td>화면 기능 수정해주세요.</td>
                                <td>고용 보험</td>
                                <td>이민성</td>
                                <td>고용노동부</td>
                                
                                <td>24/10/09</td>
                                <td>24/10/16</td>
                                <td>설계</td>
                            </tr>
                             <tr>
                            	<td>4</td>
                                <td>SR1008_411</td>
                                <td>화면 기능 수정해주세요.</td>
                                <td>고용 보험</td>
                                <td>이민성</td>
                                <td>고용노동부</td>
                                
                                <td>24/10/09</td>
                                <td>24/10/16</td>
                                <td>설계</td>
                            </tr>
    						 <tr>
                            	<td>5</td>
                                <td>SR1008_581</td>
                                <td>화면 기능 수정해주세요.</td>
                                <td>고용 보험</td>
                                <td>이민성</td>
                                <td>고용노동부</td>
                                
                                <td>24/10/09</td>
                                <td>24/10/16</td>
                                <td>설계</td>
                            </tr>
                        </tbody>
                 
              
</sec:authorize>