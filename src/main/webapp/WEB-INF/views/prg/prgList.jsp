<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prg/prgList.css" />

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
                                   <input type="date" class="date-form prg-search"> -
                                   <input type="date" class="date-form prg-search">
                               </div>
                           </li>
                           <li class="li-style">
                               <div id="search-thing">관련 시스템</div>
                               <select class="select-style prg-search">
                                   <option>Value</option>
                               </select>
                           </li>
                           <li class="li-style">
                               <div id="search-thing">업무구분</div>
                               <select class="select-style prg-search">
                                   <option>Value</option>
                               </select>
                           </li>
                       </ul>
                   </div>
                   <div class="searchBox2">
                       <ul class="ul-style">
                           <li class="li-style first-li" >
                               <div id="search-thing">키워드</div>
                               <input type="text" class="prg prg-search">
                           </li>
                           <li class="li-style">
                               <div id="search-thing">진행상태</div>
                               <select class="select-style prg-search">
                                   <option>Value</option>
                               </select>
                           </li>

                           <li class="li-style">
                               <div id="search-thing">접수상태</div>
                               <select class="select-style prg-search">
                                   <option>Value</option>
                               </select>
                           </li>
                           <div class="btn-box">
                               <button id="search-btn" class="search-btn">검색</button>
                           </div>
                       </ul>
                   </div>
               </div>
           </div>

           <!-- SR 관리 -->
           <div id="sr-prg-mgmt">
               <!-- SR목록 -->
               <div id="sr-list">
                   <h2 id="sr-list-title">SR요청 목록</h2>
                   <hr>
                   <div id="table-container">
                       <table id="pg-table">
                           <thead>
                               <tr>
                                   <th class="col-1"></th>
                                   <th class="col-2">SR번호</th>
                                   <th class="col-3">시스템 구분</th>
                                   <th class="col-4">SR명</th>
                                   <th class="col-5">요청자</th>
                                   <th class="col-6">완료요청일</th>
                                   <th class="col-7">완료예정일</th>
                                   <th class="col-8">접수상태</th>
                                   <th class="col-9">진행상태</th>
                               </tr>
                           </thead>
                           <tbody>
                               <c:forEach items="${srList}" var="i" varStatus="status">
                               		<tr>
                               			<td class="col-1">${status.index + 1 }</td>
	                                    <td class="col-2">${i.appSrId }</td>
	                                    <td class="col-3">${i.relSys }</td>
	                                    <td class="col-4">${i.srTitle }</td>
	                                    <td class="col-5">아직 로그인x</td>
	                                    <td class="col-6">${i.reqDt }</td>
	                                    <td class="col-7">${i.dueDt }</td>
	                                    <td class="col-8">${i.rcpStat }</td>
	                                    <td class="col-9">${i.srStat }</td>
                               		</tr>
                               </c:forEach>
                              
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
               <!-- SR 상세 -->
               <div id="sr-mgmt">
                   <!-- SR 요청 상세 정보 -->
                   <div id="sr-detail">

                       <div id="title">
                           SR 요청 상세정보
                       </div>

                       <hr>
                       <form id="sr-detail-form">
                           <div class="detail-form-group">
                               <label for="srNumber">SR번호</label>
                               <input type="text" id="srNumber" class="detail-input" name="srNumber" value="SR_0005"
                                   readonly>

                               <label for="systemCategory">시스템 구분</label>
                               <input type="text" id="systemCategory" class="detail-input" name="systemCategory"
                                   value="pepero 시스템" readonly>
                           </div>

                           <div class="detail-form-group">
                               <label for="srTitle">SR제목</label>
                               <input type="text" id="srTitle" name="srTitle" value="타임아웃 기능에 오류 수정" readonly>
                           </div>

                           <div class="detail-form-group">
                               <label for="requestTeam">요청팀</label>
                               <input type="text" id="requestTeam" class="detail-input" name="requestTeam"
                                   value="개발 1팀" readonly>

                               <label for="requester">요청자</label>
                               <input type="text" id="requester" class="detail-input" name="requester" value="이민성"
                                   readonly>
                           </div>

                           <div class="detail-form-group">
                               <label for="requestDate">요청일</label>
                               <input type="text" id="requestDate" class="detail-input" name="requestDate"
                                   value="2024.10.10" readonly>

                               <label for="completionDate">완료 요청일</label>
                               <input type="text" id="completionDate" class="detail-input" name="completionDate"
                                   value="2024.10.25" readonly>
                           </div>

                           <div class="detail-form-group">
                               <label for="srRequestNumber">SR요청번호</label>
                               <input type="text" id="srRequestNumber" name="srRequestNumber" value="EI_SR_0005"
                                   readonly>
                           </div>

                           <div class="detail-form-group">
                               <label for="srContent">SR 내용</label>
                               <textarea id="srContent" name="srContent" rows="4" readonly>
                           </textarea>
                           </div>

                           <div class="detail-form-group">
                               <label for="attachment">첨부파일</label>
                               <input type="text" id="attachment" name="attachment" value="example.xls" readonly>
                           </div>
                       </form>
                   </div>


                   <!-- SR 요청 처리 정보 -->
                    <div id="sr-plan-info">
                        <div id="title">
                            SR 요청 처리정보
                        </div>
                        <hr>
                        <div class="tabs-container d-flex align-items-center">
                            <ul class="nav nav-tabs">
                                <li class="plan-nav-item">
                                    <a class="nav-link pg-tab active" data-bs-toggle="tab" href="#">SR계획정보</a>
                                </li>
                                <li class="plan-nav-item">
                                    <a class="nav-link pg-tab" data-bs-toggle="tab" href="#">SR자원정보</a>
                                </li>
                                <li class="plan-nav-item">
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
                </div>
            </div>

        </div>
    </div>
</body>
</html>