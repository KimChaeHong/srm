<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SR 계획 정보</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link href="../css/reset.css" rel="stylesheet">
    <link href="../css/srPlan.css" rel="stylesheet">

</head>

<body>
    <div id="sr-plan-info">

        <div id="title">
            SR 요청 처리정보
        </div>
        <hr>
        <div class="tabs-container d-flex align-items-center">
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

            <button id="plan-btn" type="button" class="btn-save">저장</button>
        </div>
        <form id="sr-plan-form">
            <div class="form-group">
                <label for="request-type">요청 구분</label>
                <select id="request-type" class="form-select">
                    <option selected>선택</option>
                    <option value="1">개선</option>
                    <option value="2">신규</option>
                    <option value="3">오류</option>
                    <option value="4">기타</option>
                </select>
            </div>

            <div class="form-group">
                <label for="team">처리팀</label>
                <input type="text" id="team" value="개발 1팀">
            </div>

            <div class="form-group">
                <label for="work-type">업무 구분</label>
                <select id="work-type" class="form-select">
                    <option selected>선택</option>
                    <option value="1">111</option>
                    <option value="2">222</option>
                    <option value="3">333</option>
                    <option value="4">444</option>
                </select>
            </div>

            <div class="form-group">
                <label for="person">담당자</label>
                <input type="text" id="person" value="정준범">
            </div>

            <div class="form-group">
                <label for="start-date">목표 시작일</label>
                <input type="text" id="start-date" value="2024. 10. 26">
            </div>

            <div class="form-group">
                <label for="end-date">목표 완료일</label>
                <input type="text" id="end-date" value="2024. 10. 26">
            </div>

            <div class="form-group">
                <label for="status">접수 상태</label>
                <select id="status" class="form-select">
                    <option selected>선택</option>
                    <option>접수</option>
                    <option>취소</option>
                    <option>보류</option>
                </select>
            </div>

            <div class="form-group">
                <label for="total-hours">총계획공수</label>
                <input type="text" id="total-hours">
            </div>

            <div class="form-group">
                <label for="review">검토 내용</label>
                <textarea id="review"></textarea>
            </div>
        </form>
    </div>

</body>

</html>