<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SRM</title>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.css" />
<link href="https://cdn.jsdelivr.net/npm/bootstrap-icons/font/bootstrap-icons.css" rel="stylesheet" />
<script src="${pageContext.request.contextPath}/resources/bootstrap/bootstrap.min.js" defer></script>
<script src="${pageContext.request.contextPath}/resources/jquery/jquery.min.js" defer></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/member/memList.css"/>

</head>
<body>
	<!-- 헤더 -->
	<div id="header"></div>

	<div id="main-content">
		<!-- 사이드바 -->
		<div id="side-bar" class="col-md-2">
			<div id="chart" class="nav-item">
				<a class="nav-link disabled" aria-disabled="true" id="sr-contents">My
					portal</a>
				<hr class="navbar-vertical-divider" id="sr-hr">
			</div>
			<a class="nav-link" id="sr-request" href="#"> <i id="chart"
				class="bi bi-clipboard-check"></i>나의 할 일 <i id="chevron"
				class="bi bi-chevron-right"></i>
			</a>

			<div id="chart" class="nav-item">
				<a class="nav-link disabled" aria-disabled="true" id="sr-contents">SR
					관리</a>
				<hr class="navbar-vertical-divider" id="sr-hr">
			</div>
			<a class="nav-link" id="sr-request" href="#"> <i id="chart"
				class="bi bi-clipboard-plus"></i>SR 요청 접수 <i id="chevron"
				class="bi bi-chevron-right"></i>
			</a> <a class="nav-link" id="sr-prg" href="#"> <i id="chart"
				class="bi bi-clipboard-data-fill"></i>SR 진척 조회 <i id="chevron"
				class="bi bi-chevron-right"></i>
			</a>

			<div id="chart" class="nav-item">
				<a class="nav-link disabled" aria-disabled="true" id="sr-contents">회원관리</a>
				<hr class="navbar-vertical-divider" id="sr-hr">
			</div>
			<a class="nav-link" id="sr-request" href="#"> <i id="chart"
				class="bi bi-person-lines-fill"></i>회원 조회 <i id="chevron"
				class="bi bi-chevron-right"></i>
			</a>

			<div id="chart" class="nav-item">
				<a class="nav-link disabled" aria-disabled="true" id="sr-contents">게시판</a>
				<hr class="navbar-vertical-divider" id="sr-hr">
			</div>
			<a class="nav-link" id="sr-request" href="#"> <i id="chart"
				class="bi bi-book-half"></i>공지사항 <i id="chevron"
				class="bi bi-chevron-right"></i>
			</a>
		</div>
		<!-- section -->
		<div id="section">
			<!-- 검색창 -->
			<div id="search-container">
				<div id="search-box">
					<div class="searchBox1">
						<ul class="ul-style">
							<li class="li-style first-li">
								<div id="search-thing">소속</div> <select id="prg-search"
								class="select-style">
									<option>Value</option>
							</select>
							</li>
							<li class="li-style">
								<div id="search-thing">부서</div> <select id="prg-search"
								class="select-style dept">
									<option>Value</option>
							</select>
							</li>
							<li class="li-style">
								<div id="search-thing">가입 일자</div>
								<div class="div-style">
									<input id="prg-search" type="date" class="date-form date1">
									- <input id="prg-search" type="date" class="date-form">
								</div>
							</li>

						</ul>
					</div>
					<div class="searchBox2">
						<ul class="ul-style">
							<li class="li-style first-li">
								<div id="search-thing">권한</div> <select id="prg-search"
								class="select-style">
									<option>Value</option>
							</select>
							</li>
							<li class="li-style">
								<div id="search-thing">승인여부</div> <select id="prg-search"
								class="select-style">
									<option>Value</option>
							</select>
							</li>
							<li class="li-style">
								<div id="search-thing">이름 검색</div> <input id="search-name"
								type="text">
							</li>
							<div class="btn-box">
								<button id="search-btn" class="search-btn">검색</button>
							</div>
						</ul>
					</div>
				</div>
			</div>
			<!-- 회원목록 -->
			<div id="member-list">
				<h2 class="title">회원 목록</h2>
				<hr>
				<div id="table-container">
					<table id="pg-table">
						<thead>
							<tr>
								<th class="col-1">이름</th>
								<th class="col-2">사번</th>
								<th class="col-3">소속</th>
								<th class="col-4">부서</th>
								<th class="col-5">사용자역할</th>
								<th class="col-6">팀 역할</th>
								<th class="col-7">가입일</th>
								<th class="col-8">승인 여부</th>
								<th class="col-9">회원상세</th>
							</tr>
						</thead>
						<tbody>
							<tr>
								<td class="col-1">정준범</td>
								<td class="col-2">12341234</td>
								<td class="col-3">오티아이</td>
								<td class="col-4">서비스 개발1팀</td>
								<td class="col-5">개발자</td>
								<td class="col-6">팀원</td>
								<td class="col-7">2024.10.01</td>
								<td class="col-8">Y</td>
								<td class="col-9">
									<button class="detail-btn">상세보기</button>
								</td>
							</tr>
							<tr>
								<td class="col-1">김채홍</td>
								<td class="col-2">14832483</td>
								<td class="col-3">오티아이</td>
								<td class="col-4">서비스 개발1팀</td>
								<td class="col-5">개발자</td>
								<td class="col-6">팀원</td>
								<td class="col-7">2024.10.01</td>
								<td class="col-8">Y</td>
								<td class="col-9">
									<button class="detail-btn">상세보기</button>
								</td>
							</tr>
							<tr>
								<td class="col-1">이민성</td>
								<td class="col-2">83215751</td>
								<td class="col-3">오티아이</td>
								<td class="col-4">서비스 개발1팀</td>
								<td class="col-5">개발자</td>
								<td class="col-6">팀원</td>
								<td class="col-7">2024.10.01</td>
								<td class="col-8">Y</td>
								<td class="col-9">
									<button class="detail-btn">상세보기</button>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div id="pagination">
					<a class="btn page-btn shadow-sm"> <i
						class="bi bi-chevron-left"></i>
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
		<div class="modal fade" id="detail-modal" data-bs-backdrop="static"
			data-bs-keyboard="false" tabindex="-1"
			aria-labelledby="detail-modalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<p class="modal-title" id="exampleModalLabel">요청 상세</p>
						<button class="close-btn ms-auto" type="button"
							data-bs-dismiss="modal">
							<i class="bi bi-x-square"></i>
						</button>
					</div>
					<div class="modal-body">
						<div class="container-fluid">
							<form>

								<div class="row">
									<div class="col-md-6">
										<div>
											<label for="registrant">등록자</label> <input type="text"
												id="registrant" placeholder="이민성" disabled>
										</div>
										<div>
											<label for="registration-date">등록일</label> <input type="date"
												id="registration-date" name="registration-date"
												placeholder="2024.10.01" disabled>
										</div>
										<div class="form-row">
											<label for="completion-date">요청일</label> <input type="date"
												id="completion-date" name="completion-date"
												placeholder="2024.10.01" disabled>
										</div>

									</div>
									<div class="col-md-6">
										<div class="form-row">
											<label for="department">부서</label> <input type="text"
												id="department" name="department" placeholder="고용노동부"
												disabled>
										</div>
										<div class="form-row">
											<label for="sr-status">요청 상태</label> <input type="text"
												id="sr-status" name="related-system" placeholder="요청"
												disabled>
										</div>
										<div class="form-row">
											<label for="completion-date">완료(예정)일</label> <input
												type="date" id="completion-date" name="completion-date"
												placeholder="2024.10.01" disabled>
										</div>
									</div>

									<div>
										<div class="form-row">
											<label for="sr-title">SR 제목</label> <input type=" text"
												id="sr-title" name="related-system"
												placeholder="고용 24 화면 개선" disabled>
										</div>

										<div class="form-row">
											<label for="related-system">관련 시스템</label> <input type="text"
												id="related-system" name="related-system"
												placeholder="고용 보험" disabled>
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
											<label for="attachment">첨부파일</label> <input type="file"
												id="attachment" name="attachment" disabled>
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
		</div>
	</div>
</body>
</html>