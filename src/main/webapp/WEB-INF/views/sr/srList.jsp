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
	                            	<input type="hidden" name="rowsPerPage" value="${searchCont.pager.rowsPerPage}">
	                                <div id="search-thing">조회기간</div>
	                                <div class="date-style">
	                                    <input id="stdt-search" type="date" class="search-box date-form" name="startDate"
	                                    	value="<fmt:formatDate value="${searchCont.search.startDate}" pattern="yyyy-MM-dd"/>"> -
	                                    <input id="enddt-search" type="date" class="search-box date-form" name="endDate"
	                                    	value="<fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>">
	                                </div>
	                            </li>
	                            <li class="li-style">
	                                <div id="search-thing">시스템</div>
	                                <select id="relsys-search" class="search-box select-style" name="relSys">
	                                    <option value="">선택</option>
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
	                            <button type="button" id="reset-btn" onclick="resetForm()">초기화</button>
	                        </ul>
	                    </div>
	                    <div class="searchBox2">
	                        <ul class="ul-style">
	                            <li class="li-style first-li-2">
	                                <select id="search-key" name="searchKey">
	                                	<option value="title" ${searchCont.search.searchKey == 'title'? 'selected' : ''}>SR제목</option>
	                                	<option value="srid" ${searchCont.search.searchKey == 'srid'? 'selected' : ''}>SR번호</option>
	                                	<option value="name" ${searchCont.search.searchKey == 'name'? 'selected' : ''}>이름</option>
	                                	<option value="content" ${searchCont.search.searchKey == 'content'? 'selected' : ''}>내용</option>
	                                </select>
	                                <input id="title-search" type="text" name="keyword" value="${searchCont.search.keyword}">
	                            </li>
	                            <li class="li-style">
	                                <div id="search-thing">소속</div>
	                                <select id="inst-search" class="search-box" name="instId">
	                                	<option value="">선택</option>
	                                	<c:forEach items="${instList}" var="instList">
						                	<option value="${instList.instId}" ${searchCont.search.instId == instList.instId ? 'selected' : ''}>${instList.instNm}</option>
					                	</c:forEach>
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
                	<c:if test="${memInfo.role1 == 'ROLE_GUSR'}">
	                	<button id="reg-btn" class="search-btn ms-auto" data-bs-toggle="modal" data-bs-target="#reg-modal">SR 등록</button>
                	</c:if>
                </div>
                <hr id="sr-list-hr">
                <div id="table-container" class="overflow-auto">
                    <table id="sr-table">
                        <thead>
                            <tr>
                                <th class="col-1"></th>
                                <th class="col-2">SR 번호</th>
                                <th class="col-3">SR 제목</th>
                                <th class="col-4">시스템</th>
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
									    <c:choose>
									        <c:when test="${sr.relSys == 'EMPL'}">
									            <span class="btn-relSys relSys-empl">고용보험</span>
									        </c:when>
									        <c:when test="${sr.relSys == 'HRDV'}">
									            <span class="btn-relSys relSys-hrdv">HRD</span>
									        </c:when>
									        <c:when test="${sr.relSys == 'WORK'}">
									            <span class="btn-relSys relSys-work">워크넷</span>
									        </c:when>
									        <c:otherwise>
									            ${sr.relSys}
									        </c:otherwise>
									    </c:choose>
									</td>


	                                <td class="col-5">${sr.memNm}</td>
	                                <td class="col-6">${sr.instNm}</td>
	                                <td class="col-7">
	                                	<c:choose>
										    <c:when test="${sr.srStat == 'REGI'}">
										        <span class="btn-srStat srStat-regi">등록</span>
										    </c:when>
										    <c:when test="${sr.srStat == 'REQT'}">
										        <span class="btn-srStat srStat-reqt">요청</span>
										    </c:when>
										    <c:when test="${sr.srStat == 'REJC'}">
										        <span class="btn-srStat srStat-rejc">반려</span>
										    </c:when>
										    <c:when test="${sr.srStat == 'RECE'}">
										        <span class="btn-srStat srStat-rece">접수</span>
										    </c:when>
										    <c:when test="${sr.srStat == 'RERE'}">
										        <span class="btn-srStat srStat-rere">재검토</span>
										    </c:when>
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
                	<c:if test="${searchCont.pager.groupNo > 1}">
					    <a class="btn page-btn shadow-sm" href="list?pageNo=${searchCont.pager.startPageNo - 1}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.searchDto.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.searchDto.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.searchDto.relSys}&srStat=${searchCont.searchDto.srStat}&searchKey=${searchCont.searchDto.searchKey}&keyword=${searchCont.searchDto.keyword}&instId=${searchCont.searchDto.instId}">
					        <i class="bi bi-chevron-left"></i>
					    </a>
					</c:if>
                    <c:forEach begin="${searchCont.pager.startPageNo}" end="${searchCont.pager.endPageNo}" step="1" var="i">
                    	<c:if test="${searchCont.pager.pageNo == i}">
							<a class="btn page-btn shadow-sm active" <fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>
							href="list?pageNo=${i}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.search.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.search.relSys}&srStat=${searchCont.search.srStat}&searchKey=${searchCont.search.searchKey}&keyword=${searchCont.search.keyword}&instId=${searchCont.search.instId}">${i}</a>
						</c:if>
						<c:if test="${searchCont.pager.pageNo != i}">
							<a class="btn page-btn shadow-sm"
							href="list?pageNo=${i}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.search.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.search.relSys}&srStat=${searchCont.search.srStat}&searchKey=${searchCont.search.searchKey}&keyword=${searchCont.search.keyword}&instId=${searchCont.search.instId}">${i}</a>
						</c:if>
                    </c:forEach>
                    <c:if test="${searchCont.pager.groupNo < searchCont.pager.totalGroupNo}">
					    <a class="btn page-btn shadow-sm" href="list?pageNo=${searchCont.pager.endPageNo + 1}&rowsPerPage=${searchCont.pager.rowsPerPage}&startDate=<fmt:formatDate value="${searchCont.searchDto.startDate}" pattern="yyyy-MM-dd"/>&endDate=<fmt:formatDate value="${searchCont.searchDto.endDate}" pattern="yyyy-MM-dd"/>&relSys=${searchCont.searchDto.relSys}&srStat=${searchCont.searchDto.srStat}&searchKey=${searchCont.searchDto.searchKey}&keyword=${searchCont.searchDto.keyword}&instId=${searchCont.searchDto.instId}">
					        <i class="bi bi-chevron-right"></i>
					    </a>
					</c:if>

	                <form id="row-select" action="list" method="get">
					    <!-- 검색값  유지를 위한 숨겨진 태그들 -->
					    <input type="hidden" name="startDate" value="<fmt:formatDate value="${searchCont.search.startDate}" pattern="yyyy-MM-dd"/>">
					    <input type="hidden" name="endDate" value="<fmt:formatDate value="${searchCont.search.endDate}" pattern="yyyy-MM-dd"/>">
					    <input type="hidden" name="relSys" value="${searchCont.search.relSys}">
					    <input type="hidden" name="srStat" value="${searchCont.search.srStat}">
					    <input type="hidden" name="searchKey" value="${searchCont.search.searchKey}">
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
		            <form id="detail-form"  enctype="multipart/form-data" method="post" action="">

		            </form>
		
		        </div>
		    </div>
		</div>
        
        <!-- 등록 Modal -->
        <%@ include file="/WEB-INF/views/sr/srRegister.jsp"%>

    </div>
</body>
<script src="${pageContext.request.contextPath}/resources/js/srList.js"></script>
</html>