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
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myportal/wkHour.css" />
</head>

<body>
	<!-- Button trigger modal -->
    <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#exampleModal">
        모달 띄우기
    </button>
  
    <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" aria-hidden="true">
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
                                <th class="col-7">10/21(월)</th>
                                <th class="col-8">10/22(화)</th>
                                <th class="col-9">10/23(수)</th>
                                <th class="col-10">10/24(목)</th>
                                <th class="col-11">10/25(금)</th>
                                <th class="col-12">10/26(토)</th>
                                <th class="col-13">10/27(일)</th>
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
    </div>
</body>
</html>