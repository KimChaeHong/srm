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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prg/searchHr.css" />

</head>
<body>
	<!-- Button trigger modal -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
        모달 띄우기
    </button>
  
    <!-- Modal -->
    <div class="modal modal-lg fade" id="exampleModal" tabindex="-1" aria-hidden="true"
    aria-labelledby="staticBackdropLabel" data-bs-backdrop="static" data-bs-keyboard="false">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header ps-3">
                    <span class="modal-title">담당자 검색</span>
                    <button id="close-btn" type="button" data-bs-dismiss="modal">
                        <i class="bi bi-x-square"></i>
                    </button>
                </div>
                <div class="modal-body p-3">
                    <div id="search-box" class="d-flex justify-content-between align-items-center">
                        <div id="dept-select" class="d-flex justify-content-center align-items-center">
                            <label for="hr-select" class="me-3">부서</label>
                            <select class="hr-select form-select">
                                <option>선택</option>
                                <option value="서비스 개발 1팀">서비스 개발 1팀</option>
                                <option value="서비스 개발 2팀">서비스 개발 2팀</option>
                                <option value="서비스 개발 3팀">서비스 개발 3팀</option>
                            </select>
                        </div>
                        <div id="name-search" class="d-flex justify-content-center align-items-center">
                            <label for="hr-input" class="me-3">담당자 명</label>
                            <input type="text" class="hr-input form-control">
                        </div>
                        <button class="btn btn-sm search-btn">검색</button>
                    </div>
                    <span class="modal-title ms-2">조회 결과</span>
                    <table id="task-table">
                        <thead>
                            <tr>
                                <th class="col-1">
                                    <input class="form-check-input" type="checkbox" value="">
                                </th>
                                <th class="col-2">부서</th>
                                <th class="col-3">역할</th>
                                <th class="col-4">직원명</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="col-1">
                                    <input class="form-check-input" type="checkbox" value="">
                                </td>
                                <td class="col-2">서비스 개발 1팀</td>
                                <td class="col-3">개발자</td>
                                <td class="col-4">이민성</td>
                            </tr>
                            <tr>
                                <td class="col-1">
                                    <input class="form-check-input" type="checkbox" value="">
                                </td>
                                <td class="col-2">서비스 개발 1팀</td>
                                <td class="col-3">개발자</td>
                                <td class="col-4">이민성</td>
                            </tr>
                            <tr>
                                <td class="col-1">
                                    <input class="form-check-input" type="checkbox" value="">
                                </td>
                                <td class="col-2">서비스 개발 1팀</td>
                                <td class="col-3">개발자</td>
                                <td class="col-4">이민성</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn last-btn">등록</button>
                    <button type="button" class="btn last-btn" data-bs-dismiss="modal">닫기</button>
                </div>
            </div>
        </div>
    </div>
</body>
</html>