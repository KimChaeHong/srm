<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js" defer></script>
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js" defer></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prg/srHr.css" />

</head>
<body>
	<div id="srpg">
        <div id="title">
            SR 요청 처리정보
        </div>
        <hr>
        <div class="hr-tabs-container d-flex align-items-center">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                  <a class="nav-link pg-tab" data-bs-toggle="tab" href="#">SR계획정보</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link pg-tab active" data-bs-toggle="tab" href="#">SR자원정보</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link pg-tab" data-bs-toggle="tab" href="#">SR진척율</a>
                </li>
              </ul>
              <div class="btn-container d-flex ms-auto ">
                  <button id="add-btn" class="btn srpg-btn">추가</button>
                  <button id="del-btn" class="btn srpg-btn">선택삭제</button>
                  <button id="save-btn" class="btn srpg-btn">저장</button>
              </div>
        </div>
        <div id="hr-table-container">
            <table id="hr-table">
                <thead>
                    <tr>
                        <th class="hr-col-1"></th>
                        <th class="hr-col-2">
                            <input class="form-check-input" type="checkbox" value="">
                        </th>
                        <th class="hr-hr-col-3">담당자명</th>
                        <th class="hr-col-4">역할</th>
                        <th class="hr-col-5">계획공수(M/D)</th>
                        <th class="hr-col-6">실적공수(M/D)</th>
                        <th class="hr-col-7">일자별실적조회</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="hr-col-1">1</td>
                        <td class="hr-col-2">
                            <input class="form-check-input" type="checkbox" value="">
                        </td>
                        <td class="hr-col-3">김채홍</td>
                        <td class="hr-col-4">팀장</td>
                        <td class="hr-col-5">5.0</td>
                        <td class="hr-col-6">3.0</td>
                        <td class="hr-col-7">
                            <i class="bi bi-journal"></i>
                        </td>
                    </tr>
                    
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>