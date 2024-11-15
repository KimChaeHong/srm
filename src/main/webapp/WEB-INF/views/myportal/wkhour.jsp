<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Calendar" %>
<%@ page import="java.util.Date" %>

<%
    // 오늘 날짜 기준
    Calendar cal = Calendar.getInstance();

    // 주의 첫날(월요일)로 설정
    cal.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

    // 날짜 포맷팅
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    // 월~일 날짜 배열 생성
    String[] weekDays = new String[7];
    for (int i = 0; i < 7; i++) {
        Date currentDay = cal.getTime(); // 현재 날짜
        weekDays[i] = sdf.format(currentDay); // 포맷팅 후 저장
        cal.add(Calendar.DAY_OF_MONTH, 1); // 하루 추가
    }
%>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myportal/wkhour.css" />
</head>

<body>

<div class="modal-dialog">
    <div class="modal-content">
        <div class="modal-header ps-3">
            <span class="modal-title">SR실적등록</span>
            <button id="close-btn" type="button" data-bs-dismiss="modal">
                <i class="bi bi-x-square"></i>
            </button>
        </div>
        <div class="modal-body p-3">
            <span id="coment">*투입실적은 1일(8시간 기준) 합계 1.0으로 입력 바랍니다.(연장근무 시 2.0이내 초과입력 가능)</span>
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
                    	 <c:forEach items="${dayList}" var="day">
	                        <th class="col-7">
	                        	<fmt:formatDate value="${day}" pattern="MM-dd(E)"/>
	                        	<input type="hidden" name="wkDt" value="<fmt:formatDate value="${day}" pattern="yyyy-MM-dd"/>" />
	                        </th>
                    	</c:forEach>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="col-1">SR1008_001</td>
                        <td class="col-2">2024.12.02</td>
                        <td class="col-3">2024.12.17</td>
                        <td class="col-4">3.0</td>
                        <td class="col-5">0.0</td>
                        <td class="col-7">0</td>
                        <td class="col-8">0</td>
                        <td class="col-9">0</td>
                        <td class="col-10">0</td>
                        <td class="col-11">0</td>
                        <td class="col-12">0</td>
                        <td class="col-13">0</td>
                    </tr>
                    <tr>
                        <td class="col-1"></td>
                        <td class="col-2">일 합계</td>
                        <td class="col-3"></td>
                        <td class="col-4">3.0</td>
                        <td class="col-5">0.0</td>
                        <td class="col-7">0</td>
                        <td class="col-8">0</td>
                        <td class="col-9">0</td>
                        <td class="col-10">0</td>
                        <td class="col-11">0</td>
                        <td class="col-12">0</td>
                        <td class="col-13">0</td>
                    </tr>
                </tbody>
            </table>
        </div>
        <div class="modal-footer">
            <button type="button" class="btn last-btn">저장</button>
            <button type="button" class="btn last-btn" data-bs-dismiss="modal">닫기</button>
        </div>
    </div>
</div>

</body>

</html>