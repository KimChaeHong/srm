<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
			<input type="hidden" name="srId" value="${srDetail.srId}">
            <div>
                <label for="registrant">등록자</label>
                <input type="text" id="registrant" name="firstInptId" value="${srDetail.firstInptId}">
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
                <input type="text" id="department" name="department" value="" disabled>
            </div>
            <div class="form-row">
                <label for="sr-status">요청 상태</label>
                <input type="text" id="sr-status" placeholder="요청" name="srStat" value="${srDetail.srStat}">
            </div>
            <div class="form-row">
                <label for="dueDt">완료(예정)일</label>
                <input type="date" id="dueDt" name="dueDt" value="${srDetail.dueDt}">
            </div>
        </div>

        <div>
            <div class="form-row">
                <label for="sr-title">SR 제목</label>
                <input type="text" id="sr-title" name="srTitle" value="${srDetail.srTitle}">
            </div>

            <div class="form-row">
                <label for="related-system">관련 시스템</label>
                <input type="text" id="related-system" name="relSys" value="${srDetail.relSys}">
            </div>

            <div class="form-row">
                <label for="sr-content">SR 내용</label>
                <textarea id="sr-content" name="srCont">${srDetail.srCont}</textarea>
            </div>

            <div class="form-row">
            <label for="attachment">첨부파일</label>
            <input type="file" id="attachment" name="attachment" disabled>
        </div>
        </div>
    
    </div>
</div>

</body>
</html>