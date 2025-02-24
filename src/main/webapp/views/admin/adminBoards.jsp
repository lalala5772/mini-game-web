<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>게시글 리스트</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>

<!-- Font Awesome CDN -->
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css">
<!-- Google Fonts (Nunito) -->
<link
	href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
	rel="stylesheet">
<!-- Bootstrap CSS CDN -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC"
	crossorigin="anonymous">
<link href="/assets/css/adminBoards.css" rel="stylesheet">
<style>
</style>

</head>
<body>
	<div class="container-fluid p-0">
		<div class="row g-0" style="width: 100%;">
			<!-- 사이드바 영역 -->
			<div class="col-md-3 col-lg-2 p-0">
				<div class="sidebar">
					<div class="logo">
						<a href="/dashboard.admin"> <img src="/assets/img/logoW.png"
							alt="Logo">
						</a>
					</div>
					<ul class="sidebar-menu nav flex-column">
						<li class="nav-item"><a class="nav-link"
							href="/dashboard.admin"> <i class="fa-solid fa-toolbox"></i>
								<span class="ms-2">관리자 페이지</span>
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/customerlist.admin"> <i class="fa-solid fa-users"></i>
								<span class="ms-2">회원 리스트</span>
						</a></li>
						<li class="nav-item"><a class="nav-link active"
							href="/boardlist.admin"> <i class="fa-solid fa-file-lines"></i>
								<span class="ms-2">게시글 리스트</span>
						</a></li>
					</ul>
				</div>
			</div>
			<!-- 메인 콘텐츠 영역 -->
			<div class="col-md-9 col-lg-10">
				<div class="main-content">
					<div class="page-title">게시글 리스트</div>
					<div class="content-wrapper">
						<!-- 신규 게시글 섹션 -->
						<div class="new-members">
							<div class="section-title">이번주 신규 게시글</div>
							<div class="new-members-grid">
								<div class="member-card">
									<div class="member-image">이미지</div>
									<div class="member-name">이동엽</div>
								</div>
								<div class="member-card">
									<div class="member-image">이미지</div>
									<div class="member-name">이동엽</div>
								</div>
								<div class="member-card">
									<div class="member-image">이미지</div>
									<div class="member-name">이동엽</div>
								</div>
							</div>
						</div>
						<!-- 회원 닉네임 검색 영역 -->
						<div class="search-container">
							<input type="text" placeholder="회원 닉네임 검색" class="search-input">
							<button class="search-button">
								<i class="fa-solid fa-magnifying-glass"></i> 검색
							</button>
						</div>
						<!-- 게시글 리스트 테이블 -->
						<div class="table-container">
							<table id="member-table" class="table">
								<thead>
									<tr>
										<th>게시글 종류</th>
										<th>유저 닉네임</th>
										<th>제목</th>
										<th>내용</th>
										<th>작성일</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody>

									<c:choose>
										<c:when test="${empty boardList }">
											<tr>
												<td>내</td>
												<td>용</td>
												<td>이</td>
												<td>없</td>
												<td>습니다</td>
												<td><button class="delete">delete</button></td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach var="i" begin="0" end="${boardList.size()-1 }">
												<tr>
													<td>${boardList[i].boardCategory }</td>
													<td>${boardList[i].writer }</td>
													<td>${boardList[i].title }</td>
													<td>${boardList[i].contents }</td>
													<td>${boardList[i].writeDate }</td>
													<td><button class="delete">delete</button></td>
												</tr>
											</c:forEach>
										</c:otherwise>
									</c:choose>

									<!-- 추가 행 -->
								</tbody>
							</table>
							<!-- 페이지네이션 -->
							<div class="pagination">

								<ul>
									<c:if test="${needPrev}">
										<li class="paging" page="${startNavi-1 }">이전</li>
									</c:if>
									<c:forEach var="i" begin="${startNavi }" end="${endNavi }">
										<li class="paging" page="${i}">${i}</li>
									</c:forEach>
									<c:if test="${needNext }">
										<li class="paging" page="${endNavi+1 }">다음</li>
									</c:if>
								</ul>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 푸터 -->
	<footer class="sticky-footer">
		<div class="container">
			<div class="text-center">
				<span>Copyright &copy; Your Website 2021</span>
			</div>
		</div>
	</footer>

	<!-- Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>

	<script>
		// 추가 스크립트가 필요하면 여기에 작성합니다.
	</script>
	<script>
		$(".paging").on("click", function() {
			let pageNum = $(this).attr("page");
			sessionStorage.setItem("last_cpage", pageNum);
			location.href = "/getboardlist.admin?cpage=" + pageNum;
		});

		
	</script>
</body>
</html>
