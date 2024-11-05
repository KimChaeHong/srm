<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SR등록 모달</title>

</head>
<body>

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
            <form id="register-form" enctype="multipart/form-data" method="post" action="registerSr">
	            <div class="modal-body">
	                <div class="container-fluid">
	                    <div class="row">
	                        <div class="col-md-6">
	                            <div>
	                                <label for="registrant">등록자</label>
	                                <input type="text" id="registrant" name="firstInptId" value="${memInfo.memNm}" disabled>
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
	                                <label for="department">소속기관</label>
	                                <input type="text" id="department" name="department" value="${memInfo.instNm}" disabled>
	                            </div>
	                            <div class="form-row">
	                                <label for="sr-status">요청 상태</label>
	                                <input type="text" id="sr-status" name="srStat" value="등록" disabled>
	                            </div>
	                            <div class="form-row">
	                                <label for="dueDt">완료(예정)일</label>
	                                <input type="date" id="dueDt" name="dueDt">
	                            </div>
	                        </div>
	
	                        <div>
	                            <div class="form-row">
	                                <label for="relsys-select">관련 시스템</label>
	                                <select id="relsys-select" name="relSys">
	                                    <option value="">선택</option>
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
	                                <textarea id="sr-content" class="sr-content" name="srCont"></textarea>
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
	                <button id="register-btn" type="submit" class="btn btn-primary modal-btn"
	                	onclick="submitForm()">등록</button>
	            </div>
            </form>
        </div>
    </div>
</div>
</body>
</html>