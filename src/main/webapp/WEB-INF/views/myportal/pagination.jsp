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
    <option value="16" ${pager.rowsPerPage == 16 ? 'selected' : ''}>16</option>
    <option value="32" ${pager.rowsPerPage == 32 ? 'selected' : ''}>32</option>
    <option value="48" ${pager.rowsPerPage == 48 ? 'selected' : ''}>48</option>
    <option value="64" ${pager.rowsPerPage == 64 ? 'selected' : ''}>64</option>
</select>
<input type="hidden" id="currentPage" value="${pager.pageNo}" />
</div>