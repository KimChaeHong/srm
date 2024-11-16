<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>


<c:forEach items="${mgrs }" var="mgr">
	<tr>
		<td class="col-1">
			<input class="form-check-input" type="checkbox"  value="${mgr.memId }" name="selectedMgr">
		</td>
		<td class="col-2">
			<c:choose>
				<c:when test="${mgr.deptId == 'DEV1'}">개발 1팀</c:when>
				<c:when test="${mgr.deptId == 'DEV2'}">개발 2팀</c:when>
			</c:choose></td>
		<td class="col-3"><c:choose>
				<c:when test="${mgr.role1 == 'ROLE_DEVE'}">개발자</c:when>
			</c:choose></td>
		<td class="col-4">${mgr.memNm }</td>
	</tr>
</c:forEach>
