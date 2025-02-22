<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="auth.dto.UsersDTO"%>
<%@ page import="games.dto.GameRecordDTO"%>
<%@ page import="java.util.List, board.dto.BoardDTO"%>

<%
    UsersDTO loginUser = (UsersDTO) request.getAttribute("loginUser");
    if (loginUser == null) {
        response.sendRedirect("views/auth/login.jsp"); // 로그인 안 되어 있으면 로그인 페이지로 리디렉션
        return;
    }
    
    GameRecordDTO gameRecord = (GameRecordDTO) request.getAttribute("gameRecord");
    if (gameRecord == null) {
        // 게임이 없을 때, 어떻게 처리할 지 의논하기 
        //return;
    }
    
    List<BoardDTO> postList = (List<BoardDTO>) request.getAttribute("postList");

%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" href="/assets/css/mypage.css">

</head>
<body>

	<div class="container1">
		<div class="title">My Page</div>
		<!-- 좌측 사이드 바 아이콘 버튼 -->
		<div class="menu">
			<i class="fa-solid fa-gamepad" id="gameicon" style="color: #ffffff;"></i>
			<i class="fa-solid fa-clipboard-list" id="boardicon" style="color: #ffffff;"></i>
		</div>
		<div class="nickname" name="nickname"><%= loginUser.getNickname() %></div>
		<div class="id" name="id"><%= loginUser.getId() %></div>
		<div class="line1"></div>
		<div class="email" name="email">
			<i class="fa-solid fa-at"></i><%= loginUser.getEmail() %></div>
		<div class="phonenum" name="phonenum">
			<i class="fa-solid fa-phone"></i><%= loginUser.getPhone() %></div>
		<div class="line2"></div>
		<c:if test="${not empty gameRecord}">
			<div class="gamepoint1">게임포인트</div>
			<div class="gamepoint2"><%= gameRecord.getRecord() %></div>
			<div class="playtime1">총 플레이 시간</div>
			<div class="playtime2"><%= gameRecord.getPlayTime() %></div>
		</c:if>
		<c:if test="${empty gameRecord}">
			<div class="gamepoint1">게임포인트</div>
			<div class="gamepoint2">0</div>
			<div class="playtime1">총 플레이 시간</div>
			<div class="playtime2">0</div>
		</c:if>
		<div class="line3"></div>
		<div class="favourite">My FAVOURITE(수정예정)</div>
		<div class="gamebox1">&nbsp;&nbsp;크로스 로드</div>
		<div class="score1">score : 10</div>
		<div class="rank1">rank : 8</div>
		<div class="gamebox2">&nbsp;&nbsp;고기굽기 게임</div>
		<div class="score2">score : 10</div>
		<div class="rank2">rank : 8</div>
		<a href="/views/mypage/pwcheck.jsp">
			<button class="modify">수정하기</button>
		</a> 
		<a href="/index.jsp">
			<button class="main">메인화면</button>
		</a>

		<!-- <script>
        $(".modify").on("click",()=>{
        	 window.open("pwcheck.jsp", "_blank", "width=600,height=400,top=250,left=500");
        })
        </script>
 -->
	</div>

	<!-- mypage.jsp -->
<div class="container2">
    <div class="subtitle">내 커뮤니티 활동내역</div>
    
    <a class="my-post" href="/mypost.mypage">
        <button>내가 쓴 게시물</button>
    </a>
    <a class="my-reply" href="/myreply.mypage">
        <button>내가 쓴 댓글</button>
    </a>

    <!-- 게시글 목록 -->
		<table>
			<tr>
				<th>제목</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			<c:if test="${not empty postList}">
				<c:forEach var="post" items="${postList}">
					<tr>
						<td>${post.title}</td>
						<!-- EL로 변경 -->
						<td>${post.writeDate}</td>
						<!-- EL로 변경 -->
						<td>${post.viewCount}</td>
						<!-- EL로 변경 -->
					</tr>
                </tr>
				</c:forEach>
			</c:if>
			<c:if test="${empty postList}">
        		사용자의 게시글이 없습니다.
        	</c:if>
		</table>
   
</div>

		<div class="container3">
			<div class="subtitle">내 게임 순위</div>
			<div class="game1">
				<div class="gameimg">
					<img src="/assets/img/barbecue.jpeg" alt="">
				</div>
				<div class="myrank">Barbecue Game</div>
				<c:if test="${not empty gameRecord}">
					<div class="rank">
                    <i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> ${gameRecord.rank}등
                </div>
                <div class="myscore">
                    <i class="fa-solid fa-star" style="color: #ffffff;"></i> ${gameRecord.score}점
                </div>
				</c:if>

				<c:if test="${empty gameRecord}">
					<div class="rank">
						<span>게임 기록이 존재하지 않습니다</span>
					</div>
					<a href="/games/${game.id}">
						<button>게임으로 이동</button>
					</a>
				</c:if>
			</div>

			<div class="game2">
				<div class="gameimg">
					<img src="/assets/img/rhythm.png" alt="">
				</div>
				<div class="myrank">Rhythm Game</div>
				<c:if test="${not empty gameRecord}">
					<div class="rank">
                    <i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> ${gameRecord.rank}등
                </div>
                <div class="myscore">
                    <i class="fa-solid fa-star" style="color: #ffffff;"></i> ${gameRecord.score}점
                </div> 
					<div class="myscore">
						<i class="fa-solid fa-star" style="color: #ffffff;"></i> 2점
					</div>
				</c:if>

				<c:if test="${empty gameRecord}">
                <<div class="rank">
						<span>게임 기록이 존재하지 않습니다</span>
					</div>
					<a href="/games/${game.id}">
						<button>게임으로 이동</button>
					</a>

				</c:if>
			</div>

			<div class="game3">
				<div class="gameimg">
					<img src="/assets/img/zombie.jpeg" alt="">
				</div>
				<div class="myrank">Zombie Crusher</div>
				<c:if test="${not empty gameRecord}">
					<div class="rank">
                    <i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> ${gameRecord.rank}등
                </div>
                <div class="myscore">
                    <i class="fa-solid fa-star" style="color: #ffffff;"></i> ${gameRecord.score}점
                </div> 
					

				</c:if>

				<c:if test="${empty gameRecord}">
					<div class="rank">
						<span>게임 기록이 존재하지 않습니다</span>
					</div>
					<a href="/games/${game.id}">
						<button>게임으로 이동</button>
					</a>
				</c:if>
			</div>

			<div class="game4">
				<div class="gameimg">
					<img src="/assets/img/snake.jpeg" alt="">
				</div>
				<div class="myrank">스네이크 게입(오타아님)</div>
				<c:if test="${not empty gameRecord}">
					<div class="rank">
                    <i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> ${gameRecord.rank}등
                </div>
                <div class="myscore">
                    <i class="fa-solid fa-star" style="color: #ffffff;"></i> ${gameRecord.score}점
                </div>
				</c:if>

				<c:if test="${empty gameRecord}">
					<div class="rank">
						<span>게임 기록이 존재하지 않습니다</span>
					</div>
					<a href="/games/${game.id}">
						<button>게임으로 이동</button>
					</a>
				</c:if>
			</div>

			<div class="game5">
				<div class="gameimg">
					<img src="/assets/img/chamchamcham.jpg" alt="">
				</div>
				<div class="myrank">크로스 로드</div>
				<c:if test="${not empty gameRecord}">
					<div class="rank">
                    <i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> ${gameRecord.rank}등
                </div>
                <div class="myscore">
                    <i class="fa-solid fa-star" style="color: #ffffff;"></i> ${gameRecord.score}점
                </div>
				</c:if>

				<c:if test="${empty gameRecord}">
					<div class="rank">
						<span>게임 기록이 존재하지 않습니다</span>
					</div>
					<a href="/games/${game.id}">
						<button>게임으로 이동</button>
					</a>
				</c:if>
			</div>

			<div class="game6">
				<div class="gameimg">
					<img src="assets/img/chamchamcham.jpeg" alt="">
				</div>
				<div class="myrank">참참참!</div>
				<c:if test="${not empty gameRecord}">
					<div class="rank">
                    <i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> ${gameRecord.rank}등
                </div>
                <div class="myscore">
                    <i class="fa-solid fa-star" style="color: #ffffff;"></i> ${gameRecord.score}점
                </div>
				</c:if>

				<c:if test="${empty gameRecord}">
					<div class="rank">
						<span>게임 기록이 존재하지 않습니다</span>
					</div>
					<a href="/games/${game.id}">
						<button>게임으로 이동</button>
					</a>
				</c:if>
			</div>

			<!--  -->
			<!-- games는 게임 정보 -> 이미지 주소,게임이름, 게임 ID등   -->
			<<%-- c:forEach var="game" items="${games}"> <div class="game"> <div
			class="gameimg"> <img src="${game.image}" alt=""> </div> <div
			class="myrank">${game.name}</div> </div> </c:forEach> </div> --%>

			<script> 
				$("#gameicon").on("click", () => {
				    $(".container2").css("display", "none");
				    $(".container3").css("display", "block");
				});
				
				$("#boardicon").on("click", () => {
				    $(".container2").css("display", "block");
				    $(".container3").css("display", "none");
				
				    // 게시글 정보 불러오기
				  
				});
			</script>
</body>
</html>