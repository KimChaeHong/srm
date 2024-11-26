<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<div id="title">
    SR 요청 상세정보
</div>

<hr>
<form id="sr-detail-form">
    <div class="detail-form-group ">
        <label for="srNumber">SR번호</label>
        <input type="text" id="srNumber" class="detail-input" name="srNumber" value="${appSrDetail.appSrId}"
            readonly>

        <label for="systemCategory">시스템 구분</label>
        <input type="text" id="systemCategory" class="detail-input" name="systemCategory"
            value="${appSrDetail.sysNm}" readonly>
    </div>

    <div class="detail-form-group mt-2">
        <label for="srTitle">SR제목</label>
        <input type="text" id="srTitle" name="srTitle" value="${appSrDetail.srTitle}" readonly>
    </div>

    <div class="detail-form-group mt-2">
        <label for="requestTeam">요청기관</label>
        <input type="text" id="requestTeam" class="detail-input" name="requestTeam"
            value="${appSrDetail.instNm}" readonly>

        <label for="requester">요청자</label>
        <input type="text" id="requester" class="detail-input" name="requester" value="${appSrDetail.memNm}" readonly>
    </div>

    <div class="detail-form-group mt-2">
        <label for="requestDate">요청일</label>
        <input type="text" id="requestDate" class="detail-input" name="requestDate"
        	value="<fmt:formatDate value="${appSrDetail.reqDt}" pattern="yyyy-MM-dd"/>" readonly>

        <label for="completionDate">완료 요청일</label>
        <input type="text" id="completionDate" class="detail-input" name="completionDate"
            value="<fmt:formatDate value="${appSrDetail.dueDt}" pattern="yyyy-MM-dd"/>" readonly>
    </div>

    <div class="detail-form-group mt-2">
        <label for="srRequestNumber">SR요청번호</label>
        <input type="text" id="srRequestNumber" name="srRequestNumber" value="${appSrDetail.srId}"
            readonly>
    </div>

    <div class="detail-form-group mt-2">
        <label for="srContent">SR 내용</label>
        <textarea id="srContent" name="srContent" rows="4" readonly>${appSrDetail.srCont}</textarea>
    </div>
</form>

</body>
</html>