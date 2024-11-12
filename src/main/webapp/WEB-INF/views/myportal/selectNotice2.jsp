<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<%@ include file="/WEB-INF/views/common/header.jsp"%>
<%@ include file="/WEB-INF/views/common/sideBar.jsp"%>
<link rel="stylesheet"
	href="${pageContext.request.contextPath}/resources/css/myportal/selectNotice.css" />
	
	
<div id="section">
	<!-- SR목록 -->
	<div id="container">
		<div class="line">
			<h2 id="h2-style">공지사항</h2>
		</div>
		<div class="notice-container">
            <table class="notice-table">
                <thead>
                    <tr>
                        <th>글번호</th>
                        <th>제목</th>
                        <th>등록일자</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td>사용자 매뉴얼(24.10.13. 수정)</td>
                        <td>2022-10-09</td>
                    </tr>
                </tbody>
            </table>
        </div>
		

	</div>
</div>

</body>
</html>