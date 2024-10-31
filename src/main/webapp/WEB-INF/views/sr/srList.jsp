<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
    <link href="${pageContext.request.contextPath}/resources/css/sr/srList.css" rel="stylesheet" type="text/css" />
    <script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js" defer></script>
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/srList.js"></script>
	
</head>

        <!-- section -->
        <div id="section">
            <!-- 검색창 -->
            <div id="search-container">
            	<form method="get" action="list">
	                <div id="search-box">
	                    <div class="searchBox1">
	                        <ul class="ul-style">
	                            <li class="li-style first-li">
	                                <div id="search-thing">조회기간</div>
	                                <div class="date-style">
	                                    <input id="stdt-search" type="date" class="search-box date-form" name="startDate"
	                                    	value="<fmt:formatDate value="${searchCont.search.startDate}" pattern="yyyy-MM-dd"/>"> -
	                                    <input id="enddt-search" type="date" class="search-box date-form" name="endDate"
	                                    	value="<fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>">
	                                </div>
	                            </li>
	                            <li class="li-style">
	                                <div id="search-thing">관련 시스템</div>
	                                <select id="relsys-search" class="search-box select-style" name="relSys">
	                                    <option>선택</option>
					                	<c:forEach items="${sysList}" var="sysList">
						                	<option value="${sysList.cdId}" ${searchCont.search.relSys == sysList.cdId ? 'selected' : ''}>${sysList.cdNm}</option>
					                	</c:forEach>
					                </select>
	                            </li>
	                            <li class="li-style">
	                                <div id="search-thing">진행상태</div>
	                                <select id="srstat-search" class="search-box select-style" name="srStat">
	                                    <option value="">선택</option>
	                                    <option value="REGI" ${searchCont.search.srStat == 'REGI' ? 'selected' : ''}>등록</option>
	                                    <option value="REQT" ${searchCont.search.srStat == 'REQT' ? 'selected' : ''}>요청</option>
	                                    <option value="RECE" ${searchCont.search.srStat == 'RECE' ? 'selected' : ''}>접수</option>
	                                    <option value="REJC" ${searchCont.search.srStat == 'REJC' ? 'selected' : ''}>반려</option>
	                                    <option value="RERE" ${searchCont.search.srStat == 'RERE' ? 'selected' : ''}>재검토</option>
	                                </select>
	                            </li>
	                        </ul>
	                    </div>
	                    <div class="searchBox2">
	                        <ul class="ul-style">
	                            <li class="li-style first-li">
	                                <div id="search-thing">제목</div>
	                                <input id="title-search" type="text" name="keyword" value="${searchCont.search.keyword}">
	                            </li>
	                            <li class="li-style">
	                                <div id="search-thing">개발부서</div>
	                                <select id="dept-search" class="search-box select-style" disabled>
	                                    <option>선택</option>
	                                </select>
	                            </li>
	                            <li class="li-style">
	                                <div id="search-thing">등록자 소속</div>
	                                <select id="inst-search" class="search-box" name="instId">
	                                	<option value="">선택</option>
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
            <!-- SR목록 -->
            <div id="sr-list">
                <div class="d-flex align-items-center">
                	<p id="sr-list-title">SR요청 목록</p>
                	<button id="reg-btn" class="search-btn ms-auto" data-bs-toggle="modal" data-bs-target="#reg-modal">SR 등록</button>
                </div>
                <hr id="sr-list-hr">
                <div id="table-container" class="overflow-auto">
                    <table id="pg-table">
                        <thead>
                            <tr>
                                <th class="col-1"></th>
                                <th class="col-2">SR 번호</th>
                                <th class="col-3">SR 제목</th>
                                <th class="col-4">관련 시스템</th>
                                <th class="col-5">등록자</th>
                                <th class="col-6">소속</th>
                                <th class="col-7">상태</th>
                                <th class="col-8">요청일</th>
                                <th class="col-9">완료(예정)일</th>
                                <th class="col-10">상세보기</th>
                            </tr>
                        </thead>
                        <tbody>
                        	<c:forEach items="${srList}" var="sr">
	                            <tr>
	                                <td class="col-1">${sr.rnum}</td>
	                                <td class="col-2">${sr.srId}</td>
	                                <td class="col-3">${sr.srTitle}</td>
	                                <td class="col-4">
	                                	<c:forEach items="${sysList}" var="sysList">
		                                	${sr.relSys == sysList.cdId ? sysList.cdNm : ''}
	                                	</c:forEach>
	                                </td>
	                                <td class="col-5">${sr.firstInptId}</td>
	                                <td class="col-6">오티아이</td>
	                                <td class="col-7">
	                                	<c:choose>
	                                		<c:when test="${sr.srStat == 'REGI'}">등록</c:when>
	                                		<c:when test="${sr.srStat == 'REQT'}">요청</c:when>
	                                		<c:when test="${sr.srStat == 'REJC'}">반려</c:when>
	                                		<c:when test="${sr.srStat == 'RECE'}">접수</c:when>
	                                		<c:when test="${sr.srStat == 'RERE'}">재검토</c:when>
	                                	</c:choose>
	                                </td>
	                                <td class="col-8"><fmt:formatDate value="${sr.reqDt}" pattern="yyyy-MM-dd"/></td>
	                                <td class="col-9"><fmt:formatDate value="${sr.dueDt}" pattern="yyyy-MM-dd"/></td>
	                                <td class="col-10">
	                                    <button class="detail-btn" data-srid="${sr.srId}" data-bs-toggle="modal" data-bs-target="#detail-modal">상세보기</button>
	                                </td>
	                            </tr>
                        	</c:forEach>
                        </tbody>
                    </table>
                </div>
                <div id="pagination">
                    <a class="btn page-btn shadow-sm" href="list?pageNo=${searchCont.pager.startPageNo - 1}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.search.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.search.relSys}&srStat=${searchCont.search.srStat}&keyword=${searchCont.search.keyword}&instId=${searchCont.search.instId}">
                        <i class="bi bi-chevron-left"></i>
                    </a>
                    <c:forEach begin="${searchCont.pager.startPageNo}" end="${searchCont.pager.endPageNo}" step="1" var="i">
                    	<c:if test="${searchCont.pager.pageNo == i}">
							<a class="btn page-btn shadow-sm active" <fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>
							href="list?pageNo=${i}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.search.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.search.relSys}&srStat=${searchCont.search.srStat}&keyword=${searchCont.search.keyword}&instId=${searchCont.search.instId}">${i}</a>
						</c:if>
						<c:if test="${searchCont.pager.pageNo != i}">
							<a class="btn page-btn shadow-sm"
							href="list?pageNo=${i}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.search.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.search.relSys}&srStat=${searchCont.search.srStat}&keyword=${searchCont.search.keyword}&instId=${searchCont.search.instId}">${i}</a>
						</c:if>
                    </c:forEach>
                    <a class="btn page-btn shadow-sm" href="list?pageNo=${searchCont.pager.endPageNo + 1}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.search.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.search.relSys}&srStat=${searchCont.search.srStat}&keyword=${searchCont.search.keyword}&instId=${searchCont.search.instId}">
                        <i class="bi bi-chevron-right"></i>
                    </a>
	                <form id="row-select" action="list" method="get">
					    <!-- 검색값  유지를 위한 숨겨진 태그들 -->
					    <input type="hidden" name="startDate" value="${searchCont.search.startDate}">
					    <input type="hidden" name="endDate" value="${searchCont.search.endDate}">
					    <input type="hidden" name="relSys" value="${searchCont.search.relSys}">
					    <input type="hidden" name="srStat" value="${searchCont.search.srStat}">
					    <input type="hidden" name="keyword" value="${searchCont.search.keyword}">
					    <input type="hidden" name="instId" value="${searchCont.search.instId}">
					    
					    <!--rowPerPage 선택 -->
					    <select class="row-select form-select" name="rowsPerPage" onchange="this.form.submit();">
					        <option value="10" ${searchCont.pager.rowsPerPage == '10' ? 'selected' : ''}>10</option>
					        <option value="20" ${searchCont.pager.rowsPerPage == '20' ? 'selected' : ''}>20</option>
					        <option value="30" ${searchCont.pager.rowsPerPage == '30' ? 'selected' : ''}>30</option>
					        <option value="40" ${searchCont.pager.rowsPerPage == '40' ? 'selected' : ''}>40</option>
					        <option value="50" ${searchCont.pager.rowsPerPage == '50' ? 'selected' : ''}>50</option>
					    </select>
					</form>
                </div>

            </div>
        </div>
        <!-- 상세보기 Modal -->
		<div class="modal fade" id="detail-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
		    aria-labelledby="staticBackdropLabel" aria-hidden="true">
		    <div class="modal-dialog">
		        <div class="modal-content">
		            <div class="modal-header">
		                <p class="modal-title" id="exampleModalLabel">요청 상세</p>
		                <button class="close-btn ms-auto" type="button" data-bs-dismiss="modal">
		                    <i class="bi bi-x-square"></i>
		                </button>
		            </div>
		            <form id="detail-form" method="post" action="">

		            </form>
		
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
			                                <label for="related-system">관련 시스템</label>
			                                <select id="relsys-select" name="relSys">
			                                    <option>선택</option>
							                	<c:forEach items="${sysList}" var="sysList">
								                	<option value="${sysList.cdId}" ${searchCont.search.relSys == sysList.cdId ? 'selected' : ''}>${sysList.cdNm}</option>
							                	</c:forEach>
							                </select>
			                            </div>

			                            <div class="form-row">
			                                <label for="sr-title">SR 제목</label>
			                                <input type="text" id="sr-title" name="srTitle">
			                            </div>
			
			                            <div class="form-row">
			                                <label for="sr-content">SR 내용</label>
			                                <textarea class="sr-content" name="srCont"></textarea>
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
			                <button id="register-btn" type="submit" class="btn btn-primary modal-btn">등록</button>
			            </div>
		            </form>
		        </div>
		    </div>
		</div>
    </div>
</body>
<script src="${pageContext.request.contextPath}/resources/js/srList.js"></script>
</html>