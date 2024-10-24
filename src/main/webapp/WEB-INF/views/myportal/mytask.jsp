<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SRM</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js" defer></script>
<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js" defer></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css"/>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myportal/mytask.css"/>
<link href="${pageContext.request.contextPath}/resources/css/common/header.css" rel="stylesheet" type="text/css" />

</head>
<body>
    <!-- 헤더 -->
    <div id="header">
        <div id="logo-container">
            <img src="${pageContext.request.contextPath}/resources/images/SRM-logo.png" class="logo">
        </div>
        <div id="info-container">
            <div class="user-profile">
                <span class="badge" id="user-role">개발자</span>
                <i class="bi bi-person-circle icon"></i>
                <div class="user-name">이민성 님</div>
                <i class="bi bi-box-arrow-right logout"></i>
            </div>
            
        </div>
    </div>

    <div id="main-content">
        <!-- 사이드바 -->
        <div id="side-bar">
            <div id="chart" class="nav-item">
                <a class="nav-link disabled" aria-disabled="true" id="sr-mgmt">My portal</a>
                <hr class="navbar-vertical-divider" id="sr-hr">
            </div>
            <a class="nav-link" id="sr-request" href="${pageContext.request.contextPath}">
                <i id="chart" class="bi bi-clipboard-check"></i>나의 할 일
                <i id="chevron" class="bi bi-chevron-right"></i>
            </a>
            <div id="chart" class="nav-item">
                <a class="nav-link disabled" aria-disabled="true" id="sr-mgmt">SR 관리</a>
                <hr class="navbar-vertical-divider" id="sr-hr">
            </div>
            <a class="nav-link" id="sr-request" href="${pageContext.request.contextPath}/sr/list">
                <i id="chart" class="bi bi-clipboard-plus"></i>SR 요청 접수
                <i id="chevron" class="bi bi-chevron-right"></i>
            </a>
            <a class="nav-link" id="sr-prg" href="${pageContext.request.contextPath}/prg/list">
                <i id="chart" class="bi bi-clipboard-data-fill"></i>SR 진척 조회
                <i id="chevron" class="bi bi-chevron-right"></i>
            </a>
            <div id="chart" class="nav-item">
                <a class="nav-link disabled" aria-disabled="true" id="sr-mgmt">게시판</a>
                <hr class="navbar-vertical-divider" id="sr-hr">
            </div>
            <a class="nav-link" id="sr-request" href="#">
                <i id="chart"  class="bi bi-book-half"></i>공지사항
                <i id="chevron" class="bi bi-chevron-right"></i>
            </a>
        </div>

        <!-- section -->
        <div id="section">
            <!-- SR목록 -->
            <div id="sr-list">
                <div class="task-line">
                    <h2 id="h2-style">나의 할 일</h2>
                </div>

                <div class="tabs-container">
                    <ul class="nav nav-tabs">
                        <li class="nav-item">
                          <a class="nav-link tb-tab active" data-bs-toggle="tab" href="#">요청<span class="row-cnt">(0)</span></a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link tb-tab" data-bs-toggle="tab" href="#">등록<span class="row-cnt">(0)</span></a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link tb-tab" data-bs-toggle="tab" href="#">반려/재검토<span class="row-cnt">(0)</span></a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link tb-tab" data-bs-toggle="tab"href="#">접수<span class="row-cnt">(0)</span></a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link tb-tab" data-bs-toggle="tab" href="#">개발중<span class="row-cnt">(0)</span></a>
                        </li>
                        <li class="nav-item">
                          <a class="nav-link tb-tab" data-bs-toggle="tab" href="#">개발완료<span class="row-cnt">(0)</span></a>
                        </li>
                      </ul>
                </div>
                <div id="table-container">
                    <table id="task-table">
                        <thead>
                            <tr>
                                <th>요청 번호</th>
                                <th>제목</th>
                                <th>관련 시스템</th>
                                <th>등록자</th>
                                <th>소속</th>
                                <th>개발부서</th>
                                <th>상태</th>
                                <th>요청일</th>
                                <th>완료(예정)일</th>
                                <th>상세보기</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>SR1008_001</td>
                                <td>화면 기능 수정해주세요.</td>
                                <td>고용 보험</td>
                                <td>이민성</td>
                                <td>고용노동부</td>
                                <td>서비스 개발 2팀</td>
                                <td>반려</td>
                                <td>24/10/09</td>
                                <td>24/10/16</td>
                                <td><button class="detail-btn">요청 상세</button></td>
                            </tr>
                            <tr>
                                <td>SR1008_001</td>
                                <td>화면 기능 수정해주세요.</td>
                                <td>고용 보험</td>
                                <td>이민성</td>
                                <td>고용노동부</td>
                                <td>서비스 개발 2팀</td>
                                <td>반려</td>
                                <td>24/10/09</td>
                                <td>24/10/16</td>
                                <td><button class="detail-btn">요청 상세</button></td>
                            </tr>
                            <tr>
                                <td>SR1008_001</td>
                                <td>화면 기능 수정해주세요.</td>
                                <td>고용 보험</td>
                                <td>이민성</td>
                                <td>고용노동부</td>
                                <td>서비스 개발 2팀</td>
                                <td>반려</td>
                                <td>24/10/09</td>
                                <td>24/10/16</td>
                                <td><button class="detail-btn">요청 상세</button></td>
                            </tr>
    
                        </tbody>
                    </table>
                </div>
                
                <div id="pagination">
                    <a class="btn page-btn shadow-sm">
                        <svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" fill="currentColor" class="bi bi-chevron-left" viewBox="0 0 16 16">
                        <path fill-rule="evenodd" d="M11.354 1.646a.5.5 0 0 1 0 .708L5.707 8l5.647 5.646a.5.5 0 0 1-.708.708l-6-6a.5.5 0 0 1 0-.708l6-6a.5.5 0 0 1 .708 0"/>
                        </svg>
                    </a>
                    <a class="btn page-btn shadow-sm active">1</a>
                    <a class="btn page-btn shadow-sm">2</a>
                    <a class="btn page-btn shadow-sm">3</a>
                    <a class="btn page-btn shadow-sm">
                        <svg xmlns="http://www.w3.org/2000/svg" width="16" height="16" fill="currentColor" class="bi bi-chevron-right" viewBox="0 0 16 16">
                            <path fill-rule="evenodd" d="M4.646 1.646a.5.5 0 0 1 .708 0l6 6a.5.5 0 0 1 0 .708l-6 6a.5.5 0 0 1-.708-.708L10.293 8 4.646 2.354a.5.5 0 0 1 0-.708"/>
                        </svg>
                    </a>
                    <select class="row-select form-select">
                        <option value="10">10</option>
                        <option value="20">20</option>
                        <option value="30">30</option>
                        <option value="40">40</option>
                        <option value="50">50</option>
                    </select>
                </div>

            </div>
        </div>
    </div>
</body>
</html>