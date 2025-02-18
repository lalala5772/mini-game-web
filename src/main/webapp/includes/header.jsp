<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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
                <li><a href="/board" class="nav-link">게시판</a></li>
                <li><a href="/support" class="nav-link">고객센터</a></li>
            </ul>
        </nav>
        <div class="auth-section">
            <a href="/login" class="nav-link">로그인</a>
            <a href="/register" class="nav-link signup-button">회원가입</a>
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