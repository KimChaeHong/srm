<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>

<div class="modal-content">
	<div class="modal-header">
		<p class="modal-title">회원 상세 정보</p>
		<button class="close-btn ms-auto" type="button"
			data-bs-dismiss="modal">
			<i class="bi bi-x-square"></i>
		</button>
	</div>
	<div class="modal-body">
		<div class="container-fluid">
			<form id="memberForm" action="updateMember" method="POST">

				<div class="input-div">
					<label>이름</label> <input type="text" name="memNm"
						value="${member.memNm}" required>
				</div>
				<div class="input-div">
					<label>아이디</label> <input type="text" name="memId"
						value="${member.memId}" required>
				</div>
				<div class="input-div">
					<label>사번</label> <input type="text" name="memNo"
						value="${member.memNo}" required>
				</div>
				<div class="input-div">
					<label>소속</label>

					<!-- 사용자가 볼 수 있는 기관 이름 (instNm) -->
					<input type="text" value="${member.instNm}" readonly>

					<!-- 실제로 제출되는 기관 ID (instId) -->
					<input type="hidden" name="instId" value="${member.instId}">
				</div>
				<div class="input-div">
					<label>부서</label> <input type="hidden" name="deptId"
						value="${member.deptId}" required>
						<input type="text"
						value="${member.deptNm}" required>
						
				</div>
				<div class="input-div">
					<label>사용자 역할</label> <input type="hidden" name="role1"
						value="${member.role1}" required>
						<input type="text"
						value="${member.role1Nm}" required>
				</div>
				<div class="input-div">
					<label>팀 역할</label>

					<div>
						<input class="check-radio" type="radio" name="role2"
							value="MEMB" ${member.role2 == 'MEMB' ? 'checked' : ''}>
						팀원
					</div>
					<div>
						<input class="check-radio" type="radio" name="role2"
							value="LEAD" ${member.role2 == 'LEAD' ? 'checked' : ''}>
						팀장
					</div>

				</div>
				<div class="input-div">
					<label>승인 여부</label>
					<div>
						<input class="check-radio" type="radio" name="appYn" value="Y"
							${member.appYn == 'Y' ? 'checked' : ''}> 승인
					</div>
					<div>
						<input class="check-radio" type="radio" name="appYn" value="N"
							${member.appYn == 'N' ? 'checked' : ''}> 미승인
					</div>
				</div>
				<div class="input-div">
					<label>가입 요청일</label> <input type="text" name="first-inpt-dt"
						value="<fmt:formatDate value="${member.firstInptDt}" pattern="yy/MM/dd HH:mm:ss" />"
						required>
				</div>
			</form>
		</div>
	</div>
	<div class="modal-footer">
		<button class="submit-btn" type="button" id="ok"
			onclick="submitForm()">저장</button>
	</div>
</div>
<script>
	function submitForm() {
		document.getElementById("memberForm").submit();
	}
</script>
