<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

</head>
<body>

<div class="container-fluid">
    <div class="row">
        <div class="col-md-6">
			<input type='hidden' value="${srDetail.srId}">
            <div>
                <label for="registrant">등록자</label>
                <input type="text" id="registrant" name="firstInptId" value="${srDetail.firstInptId}">
            </div>
            <div>
                <label for="registration-date">등록일</label>
                <input type="date" id="registration-date" name="firstInptDt" value="${srDetail.firstInptDt}" readonly>
            </div>
            <div class="form-row">
                <label for="completion-date">요청일</label>
                <input type="date" id="completion-date" name="reqDt" value="${srDetail.reqDt}" readonly>
            </div>
        </div>

        <div class="col-md-6">
            <div class="form-row">
                <label for="department">소속기관</label>
                <input type="text" id="department" name="department" value="" disabled>
            </div>
            <div class="form-row">
                <label for="sr-status">요청 상태</label>
                <input type="text" id="sr-status" placeholder="요청" name="srStat" value="${srDetail.srStat}">
            </div>
            <div class="form-row">
                <label for="dueDt">완료(예정)일</label>
                <input type="date" id="dueDt" name="dueDt" value="${srDetail.dueDt}">
            </div>
        </div>

        <div>
            <div class="form-row">
                <label for="sr-title">SR 제목</label>
                <input type="text" id="sr-title" name="srTitle" value="${srDetail.srTitle}">
            </div>

            <div class="form-row">
                <label for="related-system">관련 시스템</label>
                <input type="text" id="related-system" name="relSys" value="${srDetail.relSys}">
            </div>

            <div class="form-row">
                <label for="sr-content">SR 내용</label>
                <textarea id="sr-content" name="srCont">${srDetail.srCont}</textarea>
            </div>

            <div class="form-row">
            <label for="attachment">첨부파일</label>
            <input type="file" id="attachment" name="attachment" disabled>
        </div>
        </div>
    
    </div>
</div>
	<!-- Button trigger modal -->
<!-- 	<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
	    Launch static backdrop modal
	</button> -->
	
	<!-- Modal -->
<!-- 	<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
	    aria-labelledby="staticBackdropLabel" aria-hidden="true">
	    <div class="modal-dialog">
	        <div class="modal-content">
	            <div class="modal-header">
	                <p class="modal-title" id="exampleModalLabel">요청 상세</p>
	                <button id="close-btn" type="button" data-bs-dismiss="modal">
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
	                <button id="save-btn" type="button" class="btn btn-primary">처리</button>
	            </div>
	
	        </div>
	    </div>
	</div> -->
</body>
</html>