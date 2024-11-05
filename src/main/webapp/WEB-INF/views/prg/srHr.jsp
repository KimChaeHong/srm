<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/prg/srHr.css" />

<form id="sr-hr-form" action="" method="">
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
    <div class="btn-container">
        <button id="add-btn" class="btn srpg-btn">추가</button>
        <button id="del-btn" class="btn srpg-btn">선택삭제</button>
        <button id="save-btn" class="btn srpg-btn">저장</button>
    </div>
</form>
