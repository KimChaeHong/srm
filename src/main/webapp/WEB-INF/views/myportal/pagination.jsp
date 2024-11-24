<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
 <!-- 페이지 버튼 -->
<div id="pagination">
<c:if test="${pager.groupNo > 1}">
    <a class="btn page-btn shadow-sm" data-page="${pager.startPageNo - 1}">
        <i class="bi bi-chevron-left"></i>
    </a>
</c:if>

<c:forEach begin="${pager.startPageNo}" end="${pager.endPageNo}" step="1" var="i">
    <a  class="btn page-btn shadow-sm ${pager.pageNo == i ? 'active' : ''}" data-page="${i}">${i}</a>
</c:forEach>

<c:if test="${pager.groupNo < pager.totalGroupNo}">
    <a  class="btn page-btn shadow-sm" data-page="${pager.endPageNo + 1}">
        <i class="bi bi-chevron-right"></i>
    </a>
</c:if>

<select class="row-select form-select" id="rowsPerPageSelect">
    <option value="10" ${pager.rowsPerPage == 10 ? 'selected' : ''}>10</option>
    <option value="20" ${pager.rowsPerPage == 20 ? 'selected' : ''}>20</option>
    <option value="30" ${pager.rowsPerPage == 30 ? 'selected' : ''}>30</option>
    <option value="40" ${pager.rowsPerPage == 40 ? 'selected' : ''}>40</option>
</select>
<input type="hidden" id="currentPage" value="${pager.pageNo}" />
</div>