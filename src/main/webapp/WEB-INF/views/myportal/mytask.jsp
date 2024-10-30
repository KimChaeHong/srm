<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myportal/mytask.css" />
<link href="${pageContext.request.contextPath}/resources/css/sr/srForm.css" rel="stylesheet" type="text/css" />

<!-- section -->
<div id="section">
	<!-- SR목록 -->
	<div id="sr-list">
		<div class="task-line">
			<h2 id="h2-style">나의 할 일</h2>
		</div>
		<div class="tabs-container">
			<ul class="nav nav-tabs">
				<li class="nav-item"><a class="nav-link tb-tab active"
					data-bs-toggle="tab" href="#">요청<span class="row-cnt">(0)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link tb-tab"
					data-bs-toggle="tab" href="#">등록<span class="row-cnt">(0)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link tb-tab"
					data-bs-toggle="tab" href="#">반려/재검토<span class="row-cnt">(0)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link tb-tab"
					data-bs-toggle="tab" href="#">접수<span class="row-cnt">(0)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link tb-tab"
					data-bs-toggle="tab" href="#">개발중<span class="row-cnt">(0)</span></a>
				</li>
				<li class="nav-item"><a class="nav-link tb-tab"
					data-bs-toggle="tab" href="#">개발완료<span class="row-cnt">(0)</span></a>
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
				
					<c:forEach items="${mySrList}" var="sr001mt">
						<tbody>	
							<tr>
								<td>${sr001mt.srId}</td>
								<td>${sr001mt.srTitle}</td>
								<td>${sr001mt.relSys}</td>
								<td>등록자</td>
								<td>소속</td>
								<td>부서</td>
								<td>${sr001mt.srStat}</td>
								<td><fmt:formatDate value="${sr001mt.reqDt}" pattern="yy/MM/dd"/></td>
								<td><fmt:formatDate value="${sr001mt.dueDt}" pattern="yy/MM/dd"/></td>
								<td><button class="detail-btn" data-bs-toggle="modal" data-bs-target="#detail-modal">요청 상세</button></td>
							</tr>
						</tbody>
					</c:forEach>
			</table>
		</div>

		<div id="pagination">
			<a class="btn page-btn shadow-sm"> <i class="bi bi-chevron-left"></i>
			</a> <a class="btn page-btn shadow-sm active">1</a> <a
				class="btn page-btn shadow-sm">2</a> <a
				class="btn page-btn shadow-sm">3</a> <a
				class="btn page-btn shadow-sm"> <i class="bi bi-chevron-right"></i>
			</a> <select class="row-select form-select">
				<option value="10">10</option>
				<option value="20">20</option>
				<option value="30">30</option>
				<option value="40">40</option>
				<option value="50">50</option>
			</select>
		</div>

	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="detail-modal" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
    aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <p class="modal-title" id="exampleModalLabel">개발계획입력</p>
                <button id="close-btn" type="button" data-bs-dismiss="modal" >
                    <i class="bi bi-x-square"></i>
                </button>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <div class="col-md-6">
                            <div>
                                <label for="registrant">등록자</label>
                                <input type="text" id="registrant" name="registrant">
                            </div>
                            <div>
                                <label for="registration-date">등록일</label>
                                <input type="date" id="registration-date" name="registration-date">
                            </div>
                            <div class="form-row">
                                <label for="completion-date">요청일</label>
                                <input type="date" id="completion-date" name="completion-date">
                            </div>
                        </div>

                        <div class="col-md-6">
                            <div class="form-row">
                                <label for="department">부서</label>
                                <input type="text" id="department" name="department">
                            </div>
                            <div class="form-row">
                                <label for="sr-status">요청 상태</label>
                                <input type="text" id="sr-status" placeholder="요청" name="related-system" disabled>
                            </div>
                            <div class="form-row">
                                <label for="completion-date">완료(예정)일</label>
                                <input type="date" id="completion-date" name="completion-date">
                            </div>
                        </div>

                        <div>
                            <div class="form-row">
                                <label for="sr-title" ">SR 제목</label>
                                <input type=" text" id="sr-title" name="related-system">
                            </div>

                            <div class="form-row">
                                <label for="related-system">관련 시스템</label>
                                <input type="text" id="related-system" name="related-system">
                            </div>

                            <div class="form-row">
                                <label for="sr-content">SR 내용</label>
                                <textarea id="sr-content" name="sr-content">
        1. 목적:

        2. 개선 내용:
        
        3. 고려 사항:
                                </textarea>
                            </div>

                            <div class="form-row">
                            <label for="attachment">첨부파일</label>
                            <input type="file" id="attachment" name="attachment">
                        </div>
                        </div>
                    
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button id="save-btn" type="button" class="btn btn-primary">저장</button>
            </div>
        </div>
    </div>
</div>







</div>
</body>
</html>