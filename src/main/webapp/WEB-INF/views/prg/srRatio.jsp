<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Insert title here</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">

    <link href="${pageContext.request.contextPath}/resources/css/reset.css" rel="stylesheet" type="text/css" />
    <link href="${pageContext.request.contextPath}/resources/css/prg/pg.css" rel="stylesheet" type="text/css" />
    
</head>

<body>
    <div id="srpg">
        <div id="title">
            SR 요청 처리정보
        </div>
        <hr>
        <div class="pg-tabs-container d-flex align-items-center">
            <ul class="nav nav-tabs">
                <li class="nav-item">
                  <a class="nav-link pg-tab active" data-bs-toggle="tab" href="#">SR계획정보</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link pg-tab" data-bs-toggle="tab" href="#">SR자원정보</a>
                </li>
                <li class="nav-item">
                  <a class="nav-link pg-tab" data-bs-toggle="tab" href="#">SR진척율</a>
                </li>
              </ul>
              <button id="save-btn" class="btn ms-auto">저장</button>
        </div>
        <div id="pg-table-container">
            <table id="pg-table">
                <thead>
                    <tr>
                        <th class="pg-col-1"></th>
                        <th class="pg-col-2">작업구분</th>
                        <th class="pg-col-3">시작일</th>
                        <th class="pg-col-4">완료일</th>
                        <th class="pg-col-5">진척율%(누적)</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td class="pg-col-1">1</td>
                        <td class="pg-col-2">분석</td>
                        <td class="pg-col-3">2024.10.01</td>
                        <td class="pg-col-4">2024.10.04</td>
                        <td class="pg-col-5">10</td>
                    </tr>
                    <tr>
                        <td class="pg-col-1">2</td>
                        <td class="pg-col-2">설계</td>
                        <td class="pg-col-3">2024.10.04</td>
                        <td class="pg-col-4">2024.10.10</td>
                        <td class="pg-col-5">30</td>
                    </tr>
                    <tr>
                        <td class="pg-col-1">3</td>
                        <td class="pg-col-2">구현</td>
                        <td class="pg-col-3">2024.10.10</td>
                        <td class="pg-col-4">2024.10.16</td>
                        <td class="pg-col-5">60</td>
                    </tr>
                    <tr>
                        <td class="pg-col-1">4</td>
                        <td class="pg-col-2">시험</td>
                        <td class="pg-col-3">2024.10.16</td>
                        <td class="pg-col-4">2024.10.18</td>
                        <td class="pg-col-5">80</td>
                    </tr>
                    <tr>
                        <td class="pg-col-1">5</td>
                        <td class="pg-col-2">반영요청</td>
                        <td class="pg-col-3">2024.10.18</td>
                        <td class="pg-col-4">2024.10.19</td>
                        <td class="pg-col-5">90</td>
                    </tr>
                    <tr>
                        <td class="pg-col-1">6</td>
                        <td class="pg-col-2">운영반영</td>
                        <td class="pg-col-3">2024.10.19</td>
                        <td class="pg-col-4">2024.10.21</td>
                        <td class="pg-col-5">100</td>
                    </tr>
                </tbody>
            </table>
        </div>

    </div>
</body>

</html>