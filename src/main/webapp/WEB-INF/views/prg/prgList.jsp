<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prg/prgList.css" />
<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js" defer></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/prgList.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prg/srHr.css" />


       <!-- section -->
       <div id="section">
           <!-- ------------------------------검색창 ------------------------------------>
           <div id="search-container">
	           <form action="list" method="get">
	               <div id="search-box">
	                   <div class="searchBox1">
	                       <ul class="ul-style">
	                           <li class="li-style first-li">
	                               <div id="search-thing">조회기간</div>
	                               <div class="date-style">
	                                   <input type="date" class="prg-search" name="startDate"
	                                   		value="<fmt:formatDate value="${searchCont.searchDto.startDate}" pattern="yyyy-MM-dd"/>"> -
	                                   <input type="date" class="prg-search" name="endDate"
	                                   		value="<fmt:formatDate value="${searchCont.searchDto.endDate}" pattern="yyyy-MM-dd"/>">
	                               </div>
	                           </li>
	                           <li class="li-style">
	                               <div id="search-thing">관련 시스템</div>
	                               <select class="select-style prg-search" name="relSys" onchange="changeRelSys(this)"> 
	                               		<option value="" <c:if test="${sys.cdId==''}">selected</c:if>>전체</option>
										<c:forEach items="${listSys}" var="sys">
				                       		<option value="${sys.cdId}" <c:if test="${sys.cdId==searchDto.relSys}">selected</c:if>>${sys.cdNm}</option>
										</c:forEach>				                       
	                               </select>
	                           </li>
	                           <li class="li-style">
	                               <div id="search-thing">업무구분</div>	
	                               <select class="select-style prg-search" name="wkType" id="wkType">
	                               		<option value="" <c:if test="${oper.cdId==''}">selected</c:if>>전체</option>
	                               		<c:forEach items="${listOper}" var="oper">
				                       		<option value="${oper.cdId}" <c:if test="${oper.cdId==searchDto.wkType}">selected</c:if>>${oper.cdNm}</option>
				                       	</c:forEach>		
	                               </select>
	                           </li>
	                           <button type="button" id="reset-btn" onclick="resetForm()">초기화</button>
	                       </ul>
	                   </div>
	                   <div class="searchBox2">
	                       <ul class="ul-style">
	                           <li class="li-style first-li" id="ul2">
	                               <!-- <div id="search-thing">제목</div> -->
	                               <select id="search-key" name="searchKey">
	                               		<option value="title" ${searchCont.searchDto.searchKey == 'title' ? 'seleted' : ''}>SR제목</option>
	                               		<option value="srid" ${searchCont.searchDto.searchKey == 'srid'? 'selected' : ''}>SR번호</option>
	                               		<option value="name" ${searchCont.searchDto.searchKey == 'name'? 'selected' : ''}>이름</option>
	                                	<option value="content" ${searchCont.searchDto.searchKey == 'content'? 'selected' : ''}>내용</option>
	                               </select>
	                               <input type="text" class="prg prg-search" name="keyword" value="${searchCont.searchDto.keyword }">
	                           </li>
	                           <li class="li-style">
	                               <div id="search-thing">진행상태</div>		<!-- 분석, 설계, 구현, 시험, 반영요청, 운영반영 -->
	                               <select class="select-style prg-search" name="tkType">
	                               	   <option value="" <c:if test="${searchDto.tkType==''}">selected</c:if>>전체</option>
	                                   <option value="ANAL" <c:if test="${searchDto.tkType=='ANAL'}">selected</c:if>>분석</option>
	                                   <option value="DESI" <c:if test="${searchDto.tkType=='DESI'}">selected</c:if>>설계</option>
	                                   <option value="IMPL" <c:if test="${searchDto.tkType=='IMPL'}">selected</c:if>>구현</option>
	                                   <option value="TEST" <c:if test="${searchDto.tkType=='TEST'}">selected</c:if>>시험</option>
	                                   <option value="REFL" <c:if test="${searchDto.tkType=='REFL'}">selected</c:if>>반영요청</option>
	                                   <option value="OPER" <c:if test="${searchDto.tkType=='OPER'}">selected</c:if>>운영반영</option>
	                               </select>
	                           </li>
	
	                           <li class="li-style">
	                               <div id="search-thing">접수상태</div>		<!-- 접수, 취소, 보류 -->
	                               <select class="select-style prg-search" name="rcpStat">
	                               	   <option value="" <c:if test="${searchDto.rcpStat==''}">selected</c:if>>전체</option>
	                                   <option value="DECE" <c:if test="${searchDto.rcpStat=='DECE'}">selected</c:if>>접수</option>
	                                   <option value="CANC" <c:if test="${searchDto.rcpStat=='CANC'}">selected</c:if>>취소</option>
	                                   <option value="HOLD" <c:if test="${searchDto.rcpStat=='HOLD'}">selected</c:if>>보류</option>
	                               </select>
	                           </li>
	                           <div class="btn-box">
	                               <button id="search-btn" class="search-btn" type="submit">검색</button>
	                           </div>
	                       </ul>
	                   </div>
	               </div>
               </form>
           </div>

           <!-- 승인된 SR 목록 -->
           <div id="sr-prg-mgmt">
               <!-- ---------------------------------SR처리 목록-------------------------------------- -->
               <div id="sr-list">
                   <div id="sr-header-container">
					   <h2 id="sr-list-title">SR처리 목록</h2>
					   <div id="filter-container">
						   <c:if test="${memInfo != null && memInfo.role1 == 'ROLE_DEVE'}">
							    <span id="my-sr">내가 담당한 SR만 보기</span>
							    <input type="checkbox" id="my-sr-filter" onclick="filterMySRs()" 
							           <c:if test="${onlyMySr}">checked="checked"</c:if> />
							</c:if>

				           
					   </div>
				   </div>
                   <hr>
                   <div id="table-container" class="overflow-auto">
                       <table id="pg-table">
                           <thead>
                               <tr>
                                   <th class="col-1"></th>
                                   <th class="col-2">SR번호</th>
                                   <th class="col-3">시스템 구분</th>
                                   <th class="col-4">SR제목</th>
                                   <th class="col-5">요청자</th>
                                   <th class="col-6">완료요청일</th>
                                   <th class="col-7">완료예정일</th>
                                   <th class="col-8">접수상태</th>
                                   <th class="col-9">진행상태</th>
                               </tr>
                           </thead>
                           <tbody>
                               <c:forEach items="${srList}" var="sr002MT">
                               		<tr onclick="loadSrDetails('${sr002MT.appSrId }')" id="tr-style" data-appsrid="${sr002MT.appSrId}">
                               			<td class="col-1">${sr002MT.rnum }</td>
	                                    <td class="col-2">${sr002MT.appSrId }</td>
		                                <td class="col-3">	<!-- 관련시스템 -->
		                                    <c:choose>
										        <c:when test="${sr002MT.relSys == 'EMPL'}">
										            <span class="btn-relSys relSys-empl">고용보험</span>
										        </c:when>
										        <c:when test="${sr002MT.relSys == 'HRDV'}">
										            <span class="btn-relSys relSys-hrdv">HRD</span>
										        </c:when>
										        <c:when test="${sr002MT.relSys == 'WORK'}">
										            <span class="btn-relSys relSys-work">워크넷</span>
										        </c:when>
										    </c:choose>
	                                    </td>
	                                    <td class="col-4">${sr002MT.srTitle }</td>
	                                    <td class="col-5">${sr002MT.memNm }</td>
	                                    <td class="col-6">
	                                    	<fmt:formatDate value="${sr002MT.reqDt }" pattern="yyyy-MM-dd"/>
	                                    </td>
	                                    <td class="col-7">
	                                    	<fmt:formatDate value="${sr002MT.dueDt }" pattern="yyyy-MM-dd" />
	                                    </td>
	                                    <td class="col-8">	<!-- 접수상태 -->
	                                    	<c:choose>
										        <c:when test="${sr002MT.rcpStat == 'DECE' }">
										            <span class="btn1 status-dece">접수</span>
										        </c:when>
										        <c:when test="${sr002MT.rcpStat == 'CANC' }">
										            <span class="btn1 status-canc">취소</span>
										        </c:when>
										        <c:when test="${sr002MT.rcpStat == 'HOLD' }">
										            <span class="btn1 status-hold">보류</span>
										        </c:when>
										    </c:choose>
										</td>
	                                    <td class="col-9">	<!-- 진행상태(작업구분) -->
	                                    	<c:choose>
										        <c:when test="${sr002MT.taskType == 'ANAL'}">
										            <span class="btn-task task-anal">분석</span>
										        </c:when>
										        <c:when test="${sr002MT.taskType == 'DESI'}">
										            <span class="btn-task task-desi">설계</span>
										        </c:when>
										        <c:when test="${sr002MT.taskType == 'IMPL'}">
										            <span class="btn-task task-impl">구현</span>
										        </c:when>
										        <c:when test="${sr002MT.taskType == 'TEST'}">
										            <span class="btn-task task-test">시험</span>
										        </c:when>
										        <c:when test="${sr002MT.taskType == 'REFL'}">
										            <span class="btn-task task-refl">반영요청</span>
										        </c:when>
										        <c:when test="${sr002MT.taskType == 'OPER'}">
										            <span class="btn-task task-oper">운영반영</span>
										        </c:when>
										    </c:choose>
	                                    </td> 
                               		</tr>
                               </c:forEach>
                              
                           </tbody>
                       </table>
                   </div>
                   
                   <div id="pagination">
	                    <c:if test="${searchCont.pager.groupNo>1}">
		                    <a class="btn page-btn shadow-sm" href="list?pageNo=${searchCont.pager.startPageNo - 1}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.search.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.search.relSys}&srStat=${searchCont.search.srStat}&searchKey=${searchCont.search.searchKey}&keyword=${searchCont.search.keyword}&instId=${searchCont.search.instId}">
		                        <i class="bi bi-chevron-left"></i>
		                    </a>
						</c:if>
	                    <c:forEach begin="${searchCont.pager.startPageNo}" end="${searchCont.pager.endPageNo}" step="1" var="i">
	                    	<c:if test="${searchCont.pager.pageNo == i}">
								<a class="btn page-btn shadow-sm active"
								href="list?pageNo=${i}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.searchDto.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.searchDto.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.searchDto.relSys}&tkType=${searchCont.searchDto.tkType}&keyword=${searchCont.searchDto.keyword}&wkType=${searchCont.searchDto.wkType}&rcpStat=${searchCont.searchDto.rcpStat}">${i}</a>
							</c:if>
							<c:if test="${searchCont.pager.pageNo != i}">
								<a class="btn page-btn shadow-sm"
								href="list?pageNo=${i}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.searchDto.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.searchDto.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.searchDto.relSys}&tkType=${searchCont.searchDto.tkType}&keyword=${searchCont.searchDto.keyword}&wkType=${searchCont.searchDto.wkType}&rcpStat=${searchCont.searchDto.rcpStat}">${i}</a>
							</c:if>
	                    </c:forEach>
	                    <c:if test="${searchCont.pager.groupNo < searchCont.pager.totalGroupNo}">
		                    <a class="btn page-btn shadow-sm" href="list?pageNo=${searchCont.pager.endPageNo + 1}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.search.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.search.relSys}&srStat=${searchCont.search.srStat}&searchKey=${searchCont.search.searchKey}&keyword=${searchCont.search.keyword}&instId=${searchCont.search.instId}">
		                        <i class="bi bi-chevron-right"></i>
		                    </a>
						</c:if>
	                    
		                <form id="row-select" action="list" method="get">
						    <!-- 검색값  유지를 위한 숨겨진 태그들 -->
						    <input type="hidden" name="startDate" value="<fmt:formatDate value="${searchCont.searchDto.startDate}" pattern="yyyy-MM-dd"/>">
							<input type="hidden" name="endDate" value="<fmt:formatDate value="${searchCont.searchDto.endDate}" pattern="yyyy-MM-dd"/>">
						    <input type="hidden" name="relSys" value="${searchCont.searchDto.relSys}">		
						    <input type="hidden" name="wkType" value="${searchCont.searchDto.wkType}">
						    <input type="hidden" name="keyword" value="${searchCont.searchDto.keyword}">
						    <input type="hidden" name="tkType" value="${searchCont.searchDto.tkType}">
						    <input type="hidden" name="rcpStat" value="${searchCont.searchDto.rcpStat}">
						    
						    
						    <!--rowsPerPage 선택 -->
						    <select class="row-select form-select" name="rowsPerPage" onchange="this.form.submit();">
						    	<option value="10" ${searchCont.pager.rowsPerPage == '10' ? 'selected' : ''}>10</option>
						        <option value="20" ${searchCont.pager.rowsPerPage == '20' ? 'selected' : ''}>20</option>
						        <option value="30" ${searchCont.pager.rowsPerPage == '30' ? 'selected' : ''}>30</option>
						        <option value="40" ${searchCont.pager.rowsPerPage == '40' ? 'selected' : ''}>40</option>
						        <option value="50" ${searchCont.pager.rowsPerPage == '50' ? 'selected' : ''}>50</option>
						        <%-- <option value="16" ${searchCont.pager.rowsPerPage == '16' ? 'selected' : ''}>16</option>
						        <option value="32" ${searchCont.pager.rowsPerPage == '32' ? 'selected' : ''}>32</option>
						        <option value="48" ${searchCont.pager.rowsPerPage == '48' ? 'selected' : ''}>48</option>
						        <option value="64" ${searchCont.pager.rowsPerPage == '64' ? 'selected' : ''}>64</option>
						        <option value="80" ${searchCont.pager.rowsPerPage == '80' ? 'selected' : ''}>80</option> --%>
						    </select>
						</form>
	                </div>
               </div>
               <!-- SR 상세 ------------------------------------------------------------------------>
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
                               <input type="text" id="srNumber" class="detail-input" name="srNumber" readonly>

                               <label for="systemCategory">시스템 구분</label>
                               <input type="text" id="systemCategory" class="detail-input" name="systemCategory" readonly>
                           </div>

                           <div class="detail-form-group">
                               <label for="srTitle">SR제목</label>
                               <input type="text" id="srTitle" name="srTitle" readonly>
                           </div>

                           <div class="detail-form-group">
                               <label for="requestTeam">요청팀</label>
                               <input type="text" id="requestTeam" class="detail-input" name="requestTeam" readonly>

                               <label for="requester">요청자</label>
                               <input type="text" id="requester" class="detail-input" name="requester" readonly>
                           </div>

                           <div class="detail-form-group">
                               <label for="requestDate">요청일</label>
                               <input type="text" id="requestDate" class="detail-input" name="requestDate" readonly>

                               <label for="completionDate">완료 요청일</label>
                               <input type="text" id="completionDate" class="detail-input" name="completionDate" readonly>
                           </div>

                           <div class="detail-form-group">
                               <label for="srRequestNumber">SR요청번호</label>
                               <input type="text" id="srRequestNumber" name="srRequestNumber" readonly>
                           </div>

                           <div class="detail-form-group">
                               <label for="srContent">SR 내용</label>
                               <textarea id="srContent" name="srContent" rows="4" readonly></textarea>
                           </div>

                           <div class="detail-form-group">
                               <label for="attachment">첨부파일</label>
                               <input type="text" id="attachment" name="attachment" readonly>
                           </div>
                       </form>
                   </div>



                    <!------------------------------ SR 요청 처리 정보------------------------ -->
					<div id='tab-box'>
						<div id="sr-plan-info"> 
					        <div id="title">
					            SR 요청 처리정보
					        </div>
					        <hr>
					        <div class="tabs-container d-flex align-items-center">
					            <ul class="nav nav-tabs">
					                <li class="nav-item">
									    <a class="nav-link pg-tab active" data-bs-toggle="tab" data-appsrid="${srPlan.appSrId}" >SR계획정보</a>
									</li>
					                <li class="nav-item">
					                    <a class="nav-link pg-tab" data-bs-toggle="tab" id="sr-resource-tab"
					                    	data-appsrid="${srPlan.appSrId}">SR자원정보</a>
					                </li>
					                <li class="nav-item">
					                    <a class="nav-link pg-tab" data-bs-toggle="tab" id="sr-ratio-tab"
					                    	data-appsrid="${srPlan.appSrId}">SR진척율</a>
					                </li>
					            </ul>
					
					        </div>

					        <!-- ---------------SR계획정보(SR진척 페이지를 열었을 때 기본적으로 보이는 계획정보(기본적으로 비활성화 상태)) ----------------------->
	                    	<div id="sr-container">
		                    	 
					        </div>
					        
			    		</div>
					</div>
					
					           
				        
					
					<!-- -----------------계획정보 Modal ----------------------------->
					<div class="modal modal-lg fade" id="mgr-modal" tabindex="-1"
						aria-hidden="true" aria-labelledby="staticBackdropLabel"
						data-bs-backdrop="static" data-bs-keyboard="false">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header ps-3">
									<span class="modal-title">담당자 검색</span>
									<button id="modal-close-btn" type="button"
										data-bs-dismiss="modal">
										<i class="bi modal-bi-x-square"></i>
									</button>
								</div>
								<div class="modal-body p-3">
									<form id="modal-search-box" method="GET"
										class="d-flex justify-content-between align-items-center">
		
										<div id="modal-dept-select"
											class="d-flex justify-content-center align-items-center">
											<label for="modal-hr-select" class="me-3 modal-label">부서</label>
											<select id="modal-hr-select"
												class="modal-hr-select form-select" name="deptId">
												<option value="">전체</option>
												<option value="DEV1">개발 1팀</option>
												<option value="DEV2">개발 2팀</option>
											</select>
										</div>
										<div id="modal-name-search"
											class="d-flex justify-content-center align-items-center">
											<label for="modal-hr-input" class="me-3 modal-label">담당자명</label>
											<input type="text" id="modal-hr-input"
												class="modal-hr-input form-control" name="memNm">
										</div>
										<button class="btn btn-sm modal-search-btn">검색</button>
									</form>
		
									<span class="modal-title ms-2">조회 결과</span>
									<div id="scroll" class="overflow-auto">
										<table id="modal-task-table" class="modal-table table overflow-auto">
											<thead class="modal-thead">
												<tr class="modal-tr">
													<th class="modal-col-1">선택</th>
													<th class="modal-col-2">부서</th>
													<th class="modal-col-3">역할</th>
													<th class="modal-col-4">직원명</th>
												</tr>
											</thead>
											<tbody class="modal-tbody" id="modal-results-tbody">
												<c:forEach items="${mgrs }" var="mgr">
													<tr>
														<td class="col-1">
															<input class="form-check-input" type="radio" value="${mgr.memNo }" name="selectedMgr">
														</td>
														<td class="col-2">
															<c:choose>
																<c:when test="${mgr.deptId == 'DEV1'}">개발 1팀</c:when>
																<c:when test="${mgr.deptId == 'DEV2'}">개발 2팀</c:when>
															</c:choose></td>
														<td class="col-3"><c:choose>
																<c:when test="${mgr.role1 == 'ROLE_DEVE'}">개발자</c:when>
															</c:choose></td>
														<td class="col-4">${mgr.memNm}</td>
													</tr>
												</c:forEach>
											</tbody>
										</table>
									</div>
								</div>
								<div class="modal-footer">
									<button type="button" class="btn modal-last-btn">등록</button>
									<button type="button" class="btn modal-last-btn"
										data-bs-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</div>
					
					<!-- --------------자원 모달---------------- -->
					<div class="modal modal-lg fade" id="hr-modal" tabindex="-1"
						aria-hidden="true" aria-labelledby="hrModalLabel"
						data-bs-backdrop="static" data-bs-keyboard="false">
						<div class="modal-dialog">
							<div class="modal-content">
								<div class="modal-header ps-3">
									<span class="modal-title">담당자 검색</span>
									<button id="hr-modal-close-btn" type="button"
										data-bs-dismiss="modal">
										<i class="bi modal-bi-x-square"></i>
									</button>
								</div>
								<div class="modal-body p-3">
									<form id="hr-modal-search-box" method="GET"
										class="d-flex justify-content-between align-items-center">
										<div id="hr-modal-dept-select"
											class="d-flex justify-content-center align-items-center">
											<label for="hr-modal-hr-select" class="me-3 modal-label">부서</label>
											<select id="hr-modal-hr-select"
												class="modal-hr-select form-select" name="deptId">
												<option value="">전체</option>
												<option value="DEV1">개발 1팀</option>
												<option value="DEV2">개발 2팀</option>
											</select>
										</div>
										<div id="hr-modal-name-search"
											class="d-flex justify-content-center align-items-center">
											<label for="hr-modal-hr-input" class="me-3 modal-label">담당자명</label>
											<input type="text" id="hr-modal-hr-input"
												class="modal-hr-input form-control" name="memNm">
										</div>
										<button class="btn btn-sm hr-modal-search-btn">검색</button>
									</form>
		
									<span class="modal-title ms-2">조회 결과</span>
									<div id="hr-scroll" class="overflow-auto">
									    <table id="hr-modal-task-table" class="modal-table table">
									        <thead class="modal-thead">
									            <tr class="modal-tr">
									                <th class="modal-col-1">선택</th>
									                <th class="modal-col-2">부서</th>
									                <th class="modal-col-3">역할</th>
									                <th class="modal-col-4">직원명</th>
									            </tr>
									        </thead>
									        <tbody class="modal-tbody" id="hr-modal-results-tbody">
									            <c:forEach items="${mgrs }" var="mgr">
									                <tr>
									                    <td class="col-1">
									                        <input class="form-check-input" type="checkbox" value="${mgr.memId}" name="selectedMgr">
									                    </td>
									                    <td class="col-2">
									                        <c:choose>
									                            <c:when test="${mgr.deptId == 'DEV1'}">개발 1팀</c:when>
									                            <c:when test="${mgr.deptId == 'DEV2'}">개발 2팀</c:when>
									                        </c:choose>
									                    </td>
									                    <td class="col-3">
									                        <c:choose>
									                            <c:when test="${mgr.role1 == 'ROLE_DEVE'}">개발자</c:when>
									                        </c:choose>
									                    </td>
									                    <td class="col-4">${mgr.memNm}</td>
									                </tr>
									            </c:forEach>
									        </tbody>
									    </table>
									</div>

								</div>
								<div class="modal-footer">
									<button type="button" class="btn hr-modal-add-btn">등록</button>
									<button type="button" class="btn hr-modal-close-btn"
										data-bs-dismiss="modal">닫기</button>
								</div>
							</div>
						</div>
					</div>
		
		
		
				</div>
            </div>

        </div>
    </div>

</body>
</html>