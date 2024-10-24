<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SR 요청 상세 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="${pageContext.request.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/prg/srDetial.css" rel="stylesheet" type="text/css" />

</head>
<body>

    <div id="sr-detail">
      
            <div id="title">
                SR 요청 상세정보
            </div>
        
        <hr>
        <form id="sr-detail-form">
            <div class="form-group">
                <label for="srNumber">SR번호</label>
                <input type="text" id="srNumber" name="srNumber" value="SR_0005" readonly>
    
                <label for="systemCategory">시스템 구분</label>
                <input type="text" id="systemCategory" name="systemCategory" value="pepero 시스템" readonly>
            </div>
    
            <div class="form-group">
                <label for="srTitle">SR제목</label>
                <input type="text" id="srTitle" name="srTitle" value="타임아웃 기능에 오류 수정" readonly>
            </div>
    
            <div class="form-group">
                <label for="requestTeam">요청팀</label>
                <input type="text" id="requestTeam" name="requestTeam" value="개발 1팀" readonly>
    
                <label for="requester">요청자</label>
                <input type="text" id="requester" name="requester" value="이민성" readonly>
            </div>
    
            <div class="form-group">
                <label for="requestDate">요청일</label>
                <input type="text" id="requestDate" name="requestDate" value="2024.10.10" readonly>
    
                <label for="completionDate">완료 요청일</label>
                <input type="text" id="completionDate" name="completionDate" value="2024.10.25" readonly>
            </div>
    
            <div class="form-group">
                <label for="srRequestNumber">SR요청번호</label>
                <input type="text" id="srRequestNumber" name="srRequestNumber" value="EI_SR_0005" readonly>
            </div>
    
            <div class="form-group">    
                <label for="srContent">SR 내용</label>
                <textarea id="srContent" name="srContent" rows="4" readonly>
                </textarea>
            </div>
    
            <div class="form-group">
                <label for="attachment">첨부파일</label>
                <input type="text" id="attachment" name="attachment" value="example.xls" readonly>
            </div>
        </form>
    </div>

    
</body>
</html>