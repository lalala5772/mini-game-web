<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>


<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>회원 리스트</title>
<!-- jquery CDN -->
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
<link href="/assets/css/adminCustomerList.css" rel="stylesheet">
<style>
</style>
<script>
	$(function() {
		getcustomerlist();
		getnewcustomerlist();
	})
</script>
</head>
<body>
	리퀘스트 도착
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
						<li class="nav-item"><a class="nav-link active"
							href="/customerlist.admin"> <i class="fa-solid fa-users"></i>
								<span class="ms-2">회원 리스트</span>
						</a></li>
						<li class="nav-item"><a class="nav-link"
							href="/boardlist.admin"> <i class="fa-solid fa-file-lines"></i>
								<span class="ms-2">게시글 리스트</span>
						</a></li>
					</ul>
				</div>
			</div>
			<!-- 메인 콘텐츠 영역 -->
			<div class="col-md-9 col-lg-10">
				<div class="main-content">
					<div class="page-title">회원 리스트</div>
					<div class="content-wrapper">
						<!-- 신규 회원 섹션 -->
						<div class="new-members">
							<div class="section-title">이번주 신규 회원</div>
							<div class="new-members-grid" id="newuserlist">
<%-- 								<c:choose> --%>
<%-- 									<c:when test="${empty newUserList }"> --%>
<!-- 										<div class="member-card"> -->
<!-- 											<div class="member-image">이미지</div> -->
<!-- 											<div class="member-name">없음</div> -->
<!-- 										</div> -->
<!-- 										<div class="member-card"> -->
<!-- 											<div class="member-image">이미지</div> -->
<!-- 											<div class="member-name">없음</div> -->
<!-- 										</div> -->
<!-- 										<div class="member-card"> -->
<!-- 											<div class="member-image">이미지</div> -->
<!-- 											<div class="member-name">없음</div> -->
<!-- 										</div> -->

<%-- 									</c:when> --%>

<%-- 									<c:otherwise> --%>
<%-- 										<c:forEach var="i" begin="0" end="${newUserList.size()-1 }"> --%>
<!-- 											<div class="member-card"> -->
<!-- 												<div class="member-image">이미지</div> -->
<%-- 												<div class="member-name">${newUserList[i].nickname }</div> --%>
<!-- 											</div> -->

<%-- 										</c:forEach> --%>
<%-- 									</c:otherwise> --%>
<%-- 								</c:choose> --%>
								<!-- <div class="new-members-grid">
                <div class="member-card">
                  <div class="member-image">이미지</div>
                  <div class="member-name">이동엽</div>
                </div>
                <div class="member-card">
                  <div class="member-image">이미지</div>
                  <div class="member-name">김철수</div>
                </div>
                <div class="member-card">
                  <div class="member-image">이미지</div>
                  <div class="member-name">박영희</div>
                </div> -->
							</div>
						</div>
						<!-- 회원 닉네임 검색 영역 -->
						<div class="search-container">
							<input type="text" placeholder="회원 닉네임 검색" class="search-input">
							<button class="search-button">
								<i class="fa-solid fa-magnifying-glass"></i> 검색
							</button>
						</div>
						<!-- 회원 리스트 테이블 -->
						<div class="table-container">
							<table id="member-table" class="table">
								<thead>
									<tr>
										<th>이름</th>
										<th>가입일</th>
										<th>마지막 접속일</th>
										<th>총 플레이 횟수</th>
										<th>회원 상태</th>
										<th>차단</th>
										<th>삭제</th>
									</tr>
								</thead>
								<tbody id="getuserlist">
									<%-- 									<c:choose> --%>
									<%-- 										<c:when test="${empty userList }"> --%>
									<!-- 											<tr> -->

									<!-- 												<td>회원이 존재하지 않습니다.</td> -->
									<!-- 											</tr> -->

									<%-- 										</c:when> --%>
									<%-- 										<c:otherwise> --%>
									<%-- 											<c:forEach var="i" begin="0" end="${userList.size() -1}"> --%>
									<!-- 												<tr> -->

									<%-- 													<td>${userList[i].nickname }</td> --%>
									<%-- 													<td>${userList[i].joinDate }</td> --%>
									<%-- 													<td>${userList[i].lastLogin }</td> --%>
									<%-- 													<td>${userList[i].warningCount }</td> --%>
									<%-- 													<td>${userList[i].status }</td> --%>
									<!-- 													<td><button class="unban" id="banbtn">unban</button></td> -->
									<!-- 													<td><button class="delete">delete</button></td> -->
									<!-- 												</tr> -->

									<%-- 											</c:forEach> --%>
									<%-- 										</c:otherwise> --%>
									<%-- 									</c:choose> --%>

									<!--   <td>이동엽</td>
                    <td>2020/01/01</td>
                    <td>2025/02/17</td>
                    <td>30000회</td>
                    <td>user</td>
                    <td><button class="unban" id="banbtn">unban</button></td>
                    <td><button class="delete">delete</button></td> -->
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
	<script>
		$("#banbtn").on("click", function() {

		})
	</script>

	<!-- Bootstrap Bundle with Popper -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM"
		crossorigin="anonymous"></script>


	<script>
		$(".paging").on("click", function() {
			let pageNum = $(this).attr("page");
			sessionStorage.setItem("last_user_cpage", pageNum);
			location.href = "/customerlist.admin?cpage=" + pageNum;
			console.log(pageNum);
		});

		$(document).on("click", ".delete", function() {
			let userseq = $(this).data("seq"); // data-seq 속성에서 ID 가져오기
			console.log(userseq);
			if (confirm("삭제시 되돌릴 수 없습니다.")) {
				$.ajax({
					url : "/deleteuser.admin",
					method : "POST", // HTTP 메서드 명시
					data : {userid:userseq},
					success : function(resp) {
						console.log(resp);
						alert(resp);
						getcustomerlist();
						getnewcustomerlist();
					},
					error : function() {
						alert("삭제 중 오류 발생");
					}
				});
			}
		});
		
		function getcustomerlist() {
			$.ajax({
						url : "/getcustomerlist.admin",
						data : {
							cpage : "${cpage}"
						}
					})
					.done(
							function(resp) {
								console.log(resp);
								$("#getuserlist").empty();
								if(resp.length==0){
									let tr = $("<tr>")
									let td = $("<td colspan='7'>").html("회원이 없습니다.");

									tr.append(td);
									$("#getuserlist").append(tr);
								}else{
								for (let i = 0; i < resp.length; i++) {
									let tr = $("<tr>");
									let nickname = $("<td>").html(
											resp[i].nickname);
									let joinDate = $("<td>").html(
											resp[i].joinDate);
									let lastLogin = $("<td>").html(
											resp[i].lastLogin);
									let warningCount = $("<td>").html(
											resp[i].warningCount);
									let status = $("<td>").html(resp[i].status);
									let banbtn = $(
											"<button class='unban' id = 'banbtn'>")
											.html("unban");
									let delbtn = $(
											"<button class='delete' data-seq='"+ resp[i].id+"'>")
											.html("delete");
									let bantd = $("<td>");
									bantd.append(banbtn);
									let deltd = $("<td>");
									deltd.append(delbtn);
									tr.append(nickname, joinDate, lastLogin,
											warningCount, status, bantd, deltd);
									$("#getuserlist").append(tr);
								}}
							})
		};
		function getnewcustomerlist() {
		    $.ajax({
		        url: "/getnewcustomerlist.admin"
		    }).done(function(resp) {
		        console.log(" 신규 회원 리스트 응답:", resp);
		        $("#newuserlist").empty();  // 기존 리스트 초기화
				console.log(resp.length);
		        if (resp.length === 0) {
		            let emptyMessage = $("<div class='text-center text-muted'>").html("신규 가입한 회원이 없습니다.");
		            $("#newuserlist").append(emptyMessage);
		        } else {
		            for (let i = 0; i < resp.length; i++) {
		                let memberCard = $("<div class='member-card'>");
		                let memberImage = $("<div class='member-image'>").html("이미지");
		                let memberName = $("<div class='member-name'>").html(resp[i].nickname);
		                memberCard.append(memberImage, memberName);
		                $("#newuserlist").append(memberCard);
		            }
		        }
		    });
		}
	</script>
</body>
</html>
