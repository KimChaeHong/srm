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

<div id="detail-modal-body" class="modal-body">
	<div class="container-fluid">
	    <div class="row">
	        <div class="col-md-6">
				<input type="hidden" name="srId" value="${srDetail.srId}">
	            <div>
	                <label for="registrant">등록자</label>
	                <input type="text" id="registrant" name="firstInptId" value="${srDetail.memNm}" disabled>
	            </div>
	            <div>
	                <label for="registration-date">등록일</label>
	                <input type="date" id="registration-date" name="firstInptDt" value="<fmt:formatDate value="${srDetail.firstInptDt}" pattern="yyyy-MM-dd"/>" disabled>
	            </div>
	            <div class="form-row">
	                <label for="completion-date">요청일</label>
	                <input type="date" id="completion-date" name="reqDt" value="<fmt:formatDate value="${srDetail.reqDt}" pattern="yyyy-MM-dd"/>" disabled>
	            </div>
	        </div>
	
	        <div class="col-md-6">
	            <div class="form-row">
	                <label for="department">소속기관</label>
	                <input type="text" id="department" name="department" value="${srDetail.instNm}" disabled>
	            </div>
	            <div class="form-row">
	                <label for="sr-status">요청 상태</label>
	                <input type="text" id="sr-status" placeholder="요청" name="srStat" disabled
			            <c:choose>
		               		<c:when test="${srDetail.srStat == 'REGI'}">value="등록"</c:when>
		               		<c:when test="${srDetail.srStat == 'REQT'}">value="요청"</c:when>
		               		<c:when test="${srDetail.srStat == 'REJC'}">value="반려"</c:when>
		               		<c:when test="${srDetail.srStat == 'RECE'}">value="접수"</c:when>
		               		<c:when test="${srDetail.srStat == 'RERE'}">value="재검토"</c:when>
		               	</c:choose>>
	            </div>
	            <div class="form-row">
	                <label for="dueDt">완료(예정)일</label>
	                <input type="date" id="dueDt" name="dueDt" value="<fmt:formatDate value="${srDetail.dueDt}" pattern="yyyy-MM-dd"/>" ${srDetail.srStat != 'REGI' && srDetail.srStat != 'RERE' ? 'disabled' : ''}>
	            </div>
	        </div>
	
	        <div>
	            <div class="form-row">
	                <label for="sys-select">관련 시스템</label>
	                <select id="sys-select" name="relSys">
						<option value=''>선택</option>
						<c:forEach items="${sysList}" var="sysList">
							<option value="${sysList.cdId}" ${sysList.cdId == srDetail.relSys ? 'selected' : ''}>${sysList.cdNm}</option>
						</c:forEach>
					</select>
				</div>

	            <div class="form-row">
	                <label for="sr-title">SR 제목</label>
	                <input type="text" id="sr-title" name="srTitle" value="${srDetail.srTitle}" ${srDetail.srStat != 'REGI' && srDetail.srStat != 'RERE' ? 'disabled' : ''}>
	            </div>	
	
	            <div class="form-row">
	                <label for="sr-content">SR 내용</label>
	                <textarea id="sr-content" class="sr-content" name="srCont" ${srDetail.srStat != 'REGI' && srDetail.srStat != 'RERE' ? 'disabled' : ''}>${srDetail.srCont}</textarea>
	            </div>
	
	            <div class="form-row">
	            <label for="attachment">첨부파일</label>
	            <input type="file" id="attachment" name="attachment" disabled>
	        	</div>
	        </div>
	        <c:if test="${memInfo.role1 == 'ADMI' && srDetail.srStat == 'REQT' || srDetail.revCmt != null && srDetail.revCmt !=''}">
				<div>
					<div class="form-row">
						<label for="rev-stat">검토상태</label>
						<select class="form-select" id="rev-stat" name="srStat" ${srDetail.srStat != 'REQT' ? 'disabled' : ''}>
							<option>상태</option>
							<option value="RECE" ${srDetail.srStat == 'RECE' ? 'selected' : ''}>개발 승인</option>
							<option value="RERE" ${srDetail.srStat == 'RERE' ? 'selected' : ''}>재검토</option>
							<option value="REJC" ${srDetail.srStat == 'REJC' ? 'selected' : ''}>반려</option>
						</select>
					</div>
					<div class="form-row">
						<label for="rev-coment">검토의견</label>
						<textarea id="rev-coment" class="sr-content" name="revCmt" ${srDetail.srStat != 'REQT' ? 'disabled' : ''}>${srDetail.revCmt}</textarea>
					</div>
				</div>
	        </c:if>
		</div>
	</div>
</div>
<div class="modal-footer">
<c:if test="${(memInfo.role1 == 'GUSR' && srDetail.firstInptId == memInfo.memNo) && (srDetail.srStat == 'REGI' || srDetail.srStat == 'RERE')}">
    <button id="save-btn" type="button" class="btn btn-primary modal-btn">저장</button>
    <button id="req-btn" type="button" class="btn btn-primary modal-btn">접수요청</button>
</c:if>
<c:if test="${srDetail.firstInptId == memInfo.memNo && srDetail.srStat == 'REGI'}">
    <button id="delete-btn" type="button" class="btn btn-primary modal-btn">삭제</button>
</c:if>
<c:if test="${memInfo.role1 == 'ADMI' && srDetail.srStat == 'REQT'}">
	<button id="process-btn" type="button" class="btn btn-primary modal-btn">처리</button>
</c:if>
</div>
</body>
</html>