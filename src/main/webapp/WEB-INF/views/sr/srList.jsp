<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
    <link href="${pageContext.request.contextPath}/resources/css/sr/srList.css" rel="stylesheet" type="text/css" />

</head>

        <!-- section -->
        <div id="section">
            <!-- 검색창 -->
            <div id="search-container">
                <div id="search-box">
                    <div class="searchBox1">
                        <ul class="ul-style">
                            <li class="li-style first-li">
                                <div id="search-thing">조회기간</div>
                                <div class="date-style">
                                    <input id="prg-search" type="date" class="date-form"> -
                                    <input id="prg-search" type="date" class="date-form">
                                </div>
                            </li>
                            <li class="li-style">
                                <div id="search-thing">관련 시스템</div>
                                <select id="prg-search" class="select-style">
                                    <option>Value</option>
                                </select>
                            </li>
                            <li class="li-style">
                                <div id="search-thing">진행상태</div>
                                <select id="prg-search" class="select-style">
                                    <option>Value</option>
                                </select>
                            </li>
                        </ul>
                    </div>
                    <div class="searchBox2">
                        <ul class="ul-style">
                            <li class="li-style first-li">
                                <div id="search-thing">등록자 소속</div>
                                <input id="search-dept" type="text">
                            </li>
                            <li class="li-style">
                                <div id="search-thing">개발부서</div>
                                <select id="prg-search" class="select-style">
                                    <option>Value</option>
                                </select>
                            </li>
                            <li class="li-style">
                                <div id="search-thing">제목</div>
                                <input id="prg-search" type="text">
                            </li>
                            <div class="btn-box">
                                <button id="search-btn" class="search-btn">검색</button>
                            </div>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- SR목록 -->
            <div id="sr-list">
                <div class="d-flex align-items-center">
                	<p id="sr-list-title">SR요청 목록</p>
                	<button id="reg-btn" class="search-btn ms-auto" data-bs-toggle="modal" data-bs-target="#reg-modal">SR 등록</button>
                </div>
                <hr id="sr-list-hr">
                <div id="table-container">
                    <table id="pg-table">
                        <thead>
                            <tr>
                                <th class="col-1"></th>
                                <th class="col-2">요청번호</th>
                                <th class="col-3">SR 제목</th>
                                <th class="col-4">관련 시스템</th>
                                <th class="col-5">등록자</th>
                                <th class="col-6">소속</th>
                                <th class="col-7">개발부서</th>
                                <th class="col-8">상태</th>
                                <th class="col-9">요청일</th>
                                <th class="col-10">완료(예정)일</th>
                                <th class="col-11">상세보기</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td class="col-1">1</td>
                                <td class="col-2">SR_0001</td>
                                <td class="col-3">이런저런거 수정 부탁드립니다.</td>
                                <td class="col-4">고용보험</td>
                                <td class="col-5">정준범</td>
                                <td class="col-6">오티아이</td>
                                <td class="col-7">개발1팀</td>
                                <td class="col-8">등록</td>
                                <td class="col-9">2024.10.22</td>
                                <td class="col-10">2024.10.30</td>
                                <td class="col-11">
                                    <button class="detail-btn" data-bs-toggle="modal" data-bs-target="#detail-modal">상세보기</button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div id="pagination">
                    <a class="btn page-btn shadow-sm">
                        <i class="bi bi-chevron-left"></i>
                    </a>
                    <a class="btn page-btn shadow-sm active">1</a>
                    <a class="btn page-btn shadow-sm">2</a>
                    <a class="btn page-btn shadow-sm">3</a>
                    <a class="btn page-btn shadow-sm">
                        <i class="bi bi-chevron-right"></i>
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
        <!-- 상세보기 Modal -->
        <div class="modal fade" id="detail-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
            aria-labelledby="detail-modalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <p class="modal-title" id="exampleModalLabel">요청 상세</p>
                        <button class="close-btn ms-auto" type="button" data-bs-dismiss="modal">
                            <i class="bi bi-x-square"></i>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="container-fluid">
                            <form>

                                <div class="row">
                                    <div class="col-md-6">
                                        <div>
                                            <label for="registrant">등록자</label>
                                            <input type="text" id="registrant" placeholder="이민성" disabled>
                                        </div>
                                        <div>
                                            <label for="registration-date">등록일</label>
                                            <input type="date" id="registration-date" name="registration-date" placeholder="2024.10.01" disabled>
                                        </div>
                                        <div class="form-row">
                                            <label for="completion-date">요청일</label>
                                            <input type="date" id="completion-date" name="completion-date" placeholder="2024.10.01" disabled>
                                        </div>

                                    </div>
                                    <div class="col-md-6">
                                        <div class="form-row">
                                            <label for="department">부서</label>
                                            <input type="text" id="department" name="department"  placeholder="고용노동부" disabled>
                                        </div>
                                        <div class="form-row">
                                            <label for="sr-status">요청 상태</label>
                                            <input type="text" id="sr-status" name="related-system" placeholder="요청"disabled>
                                        </div>
                                        <div class="form-row">
                                            <label for="completion-date">완료(예정)일</label>
                                            <input type="date" id="completion-date" name="completion-date" placeholder="2024.10.01" disabled>
                                        </div>
                                    </div>

                                    <div>
                                        <div class="form-row">
                                            <label for="sr-title">SR 제목</label>
                                        <input type=" text" id="sr-title" name="related-system" placeholder="고용 24 화면 개선" disabled>
                                        </div>

                                        <div class="form-row">
                                            <label for="related-system">관련 시스템</label>
                                            <input type="text" id="related-system" name="related-system" placeholder="고용 보험"disabled>
                                        </div>

                                        <div class="form-row">
                                            <label for="sr-content">SR 내용</label>
                                            <textarea id="sr-content" name="sr-content" disabled>
		1. 목적:
		
		2. 개선 내용:
		
		3. 고려 사항:
                                        </textarea>
                                        </div>

                                        <div class="form-row">
                                            <label for="attachment">첨부파일</label>
                                            <input type="file" id="attachment" name="attachment" disabled>
                                        </div>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="save-btn" type="button" class="btn btn-primary">등록</button>
                    </div>

                </div>
            </div>
        </div>
            
        <!-- 등록 Modal -->
		<div class="modal fade" id="reg-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
		    aria-labelledby="staticBackdropLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <p class="modal-title" id="exampleModalLabel">SR 등록</p>
		                <button class="close-btn ms-auto" type="button" data-bs-dismiss="modal">
		                    <i class="bi bi-x-square"></i>
		                </button>
		            </div>
		            <form method="post" action="registerSr">
			            <div class="modal-body">
			                <div class="container-fluid">
			                    <div class="row">
			                        <div class="col-md-6">
			                            <div>
			                                <label for="registrant">등록자</label>
			                                <input type="text" id="registrant" name="firstInptId">
			                            </div>
			                            <div>
			                                <label for="registration-date">등록일</label>
			                                <input type="date" id="registration-date" name="firstInptDt" disabled>
			                            </div>
			                            <div class="form-row">
			                                <label for="completion-date">요청일</label>
			                                <input type="date" id="completion-date" name="reqDt" disabled>
			                            </div>
			                        </div>
			
			                        <div class="col-md-6">
			                            <div class="form-row">
			                                <label for="department">부서</label>
			                                <input type="text" id="department" name="department" disabled>
			                            </div>
			                            <div class="form-row">
			                                <label for="sr-status">요청 상태</label>
			                                <input type="text" id="sr-status" placeholder="요청" name="srStat">
			                            </div>
			                            <div class="form-row">
			                                <label for="dueDt">완료(예정)일</label>
			                                <input type="date" id="dueDt" name="dueDt">
			                            </div>
			                        </div>
			
			                        <div>
			                            <div class="form-row">
			                                <label for="sr-title">SR 제목</label>
			                                <input type="text" id="sr-title" name="srTitle">
			                            </div>
			
			                            <div class="form-row">
			                                <label for="related-system">관련 시스템</label>
			                                <input type="text" id="related-system" name="relSys">
			                            </div>
			
			                            <div class="form-row">
			                                <label for="sr-content">SR 내용</label>
			                                <textarea id="sr-content" name="srCont"></textarea>
			                            </div>
			
			                            <div class="form-row">
			                            <label for="attachment">첨부파일</label>
			                            <input type="file" id="attachment" name="attachment" disabled>
			                        </div>
			                        </div>
			                    
			                    </div>
			                </div>
			            </div>
			            <div class="modal-footer">
			                <button id="save-btn" type="submit" class="btn btn-primary">저장</button>
			            </div>
		            </form>
		        </div>
		    </div>
		</div>
    </div>

</body>

</html>