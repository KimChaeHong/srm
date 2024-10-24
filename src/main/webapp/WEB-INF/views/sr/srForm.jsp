<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>SR 등록</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <link href="${pageContext.request.contextPath}/resources/css/sr/srForm.css" rel="stylesheet" type="text/css" />

</head>

<!-- Button trigger modal -->
<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
    Launch static backdrop modal
</button>

<!-- Modal -->
<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1"
    aria-labelledby="staticBackdropLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <p class="modal-title" id="exampleModalLabel">개발계획입력</p>
                <button id="close-btn" type="button" data-bs-dismiss="modal">
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

</html>