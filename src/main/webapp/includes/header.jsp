<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%@ page import="auth.dto.UsersDTO"%>
<%
	/* login 완료 후 login.users 에서 받아온 user 세션 정보 */
    UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
	if(loginUser == null){
		
	}
	
%>

<header class="header">
    <div class="header-inner">
        <div class="logo-section">
            <a href="/" class="nav-link">
                <img class="logo-img" src="/assets/img/logoW.png" alt="TechX Logo" />
            </a>
        </div>
        <nav class="nav-section">
            <ul class="nav-list">
                <li><a href="/games" class="nav-link">게임하기</a></li>
                <li><a href="views/board/generalList.jsp" class="nav-link">게시판</a></li>
                <li><a href="views/auth/faq.jsp" class="nav-link">고객센터</a></li> <!-- 임시 경로 -->
                <li><a href="/dashboard.admin" class="nav-link">관리자 페이지</a></li> 
            </ul>
        </nav>
        <div class="auth-section">
			<% if (loginUser != null) { %>
			<span class="welcome-msg">안녕하세요, <%= loginUser.getNickname() %>님!
			</span> <a href="/info.mypage" class="nav-link mypage-button" >마이페이지</a> 
				<a href="/logout.users" class="nav-link logout-button">로그아웃</a>
			<% } else { %>
			<a href="views/auth/login.jsp" class="nav-link">로그인</a> 
			<a href="views/auth/agreement.jsp" class="nav-link signup-button">회원가입</a>
			<% } %>
		</div>
        <button class="mobile-menu-button">
            <i class="fas fa-bars"></i>
        </button>
    </div>
</header>

<div class="mobile-menu">
    <div class="mobile-menu-header">
        <button class="close-menu">
            <i class="fas fa-times"></i>
        </button>
    </div>
    <ul class="mobile-nav-list">
        <li><a href="/games">게임하기</a></li>
        <li><a href="/board">게시판</a></li>
        <li><a href="/support">고객센터</a></li>
        <li><a href="/login">로그인</a></li>
        <li><a href="/register">회원가입</a></li>
    </ul>
</div>

<script>
//header, footer 동적 로딩 함수
document.addEventListener("DOMContentLoaded", () => {
    const mobileMenuButton = document.querySelector('.mobile-menu-button');
    const closeMenuButton = document.querySelector('.close-menu');
    const mobileMenu = document.querySelector('.mobile-menu');

    if (mobileMenuButton && closeMenuButton && mobileMenu) {
        mobileMenuButton.addEventListener('click', () => {
            mobileMenu.classList.add('active');
            document.body.style.overflow = 'hidden';
        });

        closeMenuButton.addEventListener('click', () => {
            mobileMenu.classList.remove('active');
            document.body.style.overflow = 'auto';
        });
    }
});
</script>