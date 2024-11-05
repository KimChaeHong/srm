<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prg/prgList.css" />
<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js" defer></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/prgList.js"></script>
	
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
	                       </ul>
	                   </div>
	                   <div class="searchBox2">
	                       <ul class="ul-style">
	                           <li class="li-style first-li" >
	                               <div id="search-thing">제목</div>
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
	                                   <option value="RECE" <c:if test="${searchDto.rcpStat=='RECE'}">selected</c:if>>접수</option>
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
                   <h2 id="sr-list-title">SR처리 목록</h2>
                   <hr>
                   <div id="table-container" class="overflow-auto">
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
                               <c:forEach items="${srList}" var="sr002MT">
                               		<tr onclick="loadSrDetails('${sr002MT.appSrId }')" id="tr-style">
                               			<td class="col-1">${sr002MT.rnum }</td>
	                                    <td class="col-2">${sr002MT.appSrId }</td>
		                                <td class="col-3">	<!-- 관련시스템 -->
		                                    <c:choose>
	                                    		<c:when test="${sr002MT.relSys == 'EMPL'}">고용보험</c:when>
	                                    		<c:when test="${sr002MT.relSys == 'HRDV'}">HRD</c:when>
	                                    		<c:when test="${sr002MT.relSys == 'WORK'}">워크넷</c:when>
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
	                                    		<c:when test="${sr002MT.rcpStat == 'RECE' }">접수</c:when>
	                                    		<c:when test="${sr002MT.rcpStat == 'CANC' }">취소</c:when>
	                                    		<c:when test="${sr002MT.rcpStat == 'HOLD' }">보류</c:when>
	                                    	</c:choose>
										</td>
	                                    <td class="col-9">	<!-- 진행상태(작업구분) -->
	                                    	<c:choose>
	                                    		<c:when test="${sr002MT.taskType == 'ANAL' }">분석</c:when>
	                                    		<c:when test="${sr002MT.taskType == 'DESI' }">설계</c:when>
	                                    		<c:when test="${sr002MT.taskType == 'IMPL' }">구현</c:when>
	                                    		<c:when test="${sr002MT.taskType == 'TEST' }">시험</c:when>
	                                    		<c:when test="${sr002MT.taskType == 'REFL' }">반영요청</c:when>
	                                    		<c:when test="${sr002MT.taskType == 'OPER' }">운영반영</c:when>
	                                    	</c:choose>
	                                    </td> 
                               		</tr>
                               </c:forEach>
                              
                           </tbody>
                       </table>
                   </div>
                   
                   <div id="pagination">
	                    <a class="btn page-btn shadow-sm">
	                        <i class="bi bi-chevron-left"></i>
	                    </a>
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
	                    <a class="btn page-btn shadow-sm">
	                        <i class="bi bi-chevron-right"></i>
	                    </a>
		                <form id="row-select" action="list" method="get">
						    <!-- 검색값  유지를 위한 숨겨진 태그들 -->
						    <input type="hidden" name="startDate" value="${searchCont.searchDto.startDate}">
						    <input type="hidden" name="endDate" value="${searchCont.searchDto.endDate}">
						    <input type="hidden" name="relSys" value="${searchCont.searchDto.relSys}">		
						    <input type="hidden" name="wkType" value="${searchCont.searchDto.wkType}">
						    <input type="hidden" name="keyword" value="${searchCont.searchDto.keyword}">
						    <input type="hidden" name="tkType" value="${searchCont.searchDto.tkType}">
						    <input type="hidden" name="rcpStat" value="${searchCont.searchDto.rcpStat}">
						    
						    <!--rowsPerPage 선택 -->
						    <select class="row-select form-select" name="rowsPerPage" onchange="this.form.submit();">
						        <option value="16" ${searchCont.pager.rowsPerPage == '16' ? 'selected' : ''}>16</option>
						        <option value="32" ${searchCont.pager.rowsPerPage == '32' ? 'selected' : ''}>32</option>
						        <option value="48" ${searchCont.pager.rowsPerPage == '48' ? 'selected' : ''}>48</option>
						        <option value="64" ${searchCont.pager.rowsPerPage == '64' ? 'selected' : ''}>64</option>
						        <option value="80" ${searchCont.pager.rowsPerPage == '80' ? 'selected' : ''}>80</option>
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
                   <div id="sr-plan-info"> 

				        <div id="title">
				            SR 요청 처리정보
				        </div>
				        <hr>
				        <div class="tabs-container d-flex align-items-center">
				            <ul class="nav nav-tabs">
				                <li class="nav-item">
				                    <a class="nav-link pg-tab active" data-bs-toggle="tab" href="#" data-appsrid="${srPlan.appSrId}">SR계획정보</a>
				                </li>
				                <li class="nav-item">
				                    <a class="nav-link pg-tab" data-bs-toggle="tab" href="#" data-appsrid="${srPlan.appSrId}">SR자원정보</a>
				                </li>
				                <li class="nav-item">
				                    <a class="nav-link pg-tab" data-bs-toggle="tab" href="#" data-appsrid="${srPlan.appSrId}">SR진척율</a>
				                </li>
				            </ul>
				
				            <button id="plan-btn" type="button" class="btn-save">저장</button>
				        </div>
				        
				        <!-- SR계획정보(진척 페이지를 열었을 때 기본적으로 보이는 계획정보) -->
                    	<form id="sr-plan-form" method="post">
					            <div class="form-group">
					                <label for="request-type">요청 구분</label>
					                <select id="request-type" class="form-select" disabled>
					                    <option selected>선택</option>
					                    <option value="1">개선</option>
					                    <option value="2">신규</option>
					                    <option value="3">오류</option>
					                    <option value="4">기타</option>
					                </select>
					            </div>
					
					            <div class="form-group">
					                <label for="team">처리팀</label>
					                <input type="text" id="team" value="개발 1팀" disabled>
					            </div>
					
					            <div class="form-group">
					                <label for="work-type">업무 구분</label>
					                <select id="work-type" class="form-select" disabled>
					                    <option selected>선택</option>
					                    <option value="1">111</option>
					                    <option value="2">222</option>
					                    <option value="3">333</option>
					                    <option value="4">444</option>
					                </select>
					            </div>
					
					            <div class="form-group">
					                <label for="person">담당자</label>
					                <input type="text" id="person" value="정준범" disabled>
					            </div>
					
					            <div class="form-group">
					                <label for="start-date">목표 시작일</label>
					                <input type="date" id="start-date" value="2024. 10. 26" disabled>
					            </div>
					
					            <div class="form-group">
					                <label for="end-date">목표 완료일</label>
					                <input type="date" id="end-date" value="2024. 10. 26" disabled>
					            </div>
					
					            <div class="form-group">
					                <label for="status">접수 상태</label>
					                <select id="status" class="form-select" disabled>
					                    <option selected>선택</option>
					                    <option>접수</option>
					                    <option>취소</option>
					                    <option>보류</option>
					                </select>
					            </div>
					
					            <div class="form-group">
					                <label for="total-hours">총계획공수</label>
					                <input type="text" id="total-hours" disabled>
					            </div>
					
					            <div class="form-group">
					                <label for="review">검토 내용</label>
					                <textarea id="review" disabled></textarea>
					            </div>
					        </form>
				    </div>
				    
				    <div id="srHr">
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
                   
                   <div id="srPg">
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
					
					
                    
                </div>
            </div>

        </div>
    </div>

</body>
</html>