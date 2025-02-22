<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- 기본 메타 태그 -->
        <title>TECH X - 게임 상세 정보 | 게임 제목</title>
        <meta name="description" content="게임 제목의 상세 정보 페이지입니다. 게임 장르, 스크린 크기, 플레이 방법 등을 확인하세요.">
        <meta name="keywords" content="게임, 게임 상세 정보, TECH X, 게임 장르, 게임 플레이, 게임 설명">
        <meta name="author" content="TECH X">

        <!-- Open Graph (SNS 공유 최적화) -->
        <meta property="og:title" content="TECH X - 게임 제목 상세 정보">
        <meta property="og:description" content="게임 제목의 상세 정보 페이지입니다. 게임 장르, 스크린 크기, 플레이 방법 등을 확인하세요.">
        <meta property="og:type" content="website">

        <!-- Twitter Card -->
        <meta name="twitter:card" content="summary_large_image">
        <meta name="twitter:title" content="TECH X - 게임 제목 상세 정보">
        <meta name="twitter:description" content="게임 제목의 상세 정보 페이지입니다. 게임 장르, 스크린 크기, 플레이 방법 등을 확인하세요.">

        <title>TECH X - Game Detail</title>
        <!-- font-awesome -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
        <!-- 브라우저마다 기본적으로 적용되는 스타일이 다르기 때문에, 이를 제거해서 일관된 스타일을 유지하기 위해 추가하는 CSS 파일 -->
        <link rel="stylesheet" href="/assets/css/reset.css">
        <!-- 헤더 & 푸터 css  -->
        <link rel="stylesheet" href="/assets/css/layout.css">
        <!-- 전체 게임 css -->
        <link rel="stylesheet" href="/assets/css/all-games.css">


        <link rel="stylesheet" href="/assets/css/game.css">
    </head>

    <body>
        <!-- 공통 Header -->
        <%@ include file="../../includes/header.jsp" %>

        <main>
            <section class="my-game-section">
                <h1 class="my-game-title">게임 제목</h1>

                <div class="my-game-wrap">
                    <div class="game-hero">
                        <img src="https://picsum.photos/960/550" alt="Game Screenshot" class="game-hero-image">
                    </div>

                    <div class="game-about">
                        <div class="game-description-section">
                            <h2 class="section-title _1">ABOUT</h2>
                            <div class="game-description">
                                <p>게임 설명이 들어갈 자리입니다. 각 게임의 특징과 플레이 방법에 대한 상세한 설명이 들어갑니다.</p>
                            </div>
                        </div>

                        <div class="game-info-wrap">
                            <h2 class="section-title _1">게임 정보</h2>
                            <ul class="game-info-list">
                                <li class="game-info-item">
                                    <span class="info-label">게임 장르</span>
                                    <span class="info-value">게임 타입</span>
                                </li>
                                <li class="game-info-item">
                                    <span class="info-label">난이도</span>
                                    <span class="info-value">중</span>
                                </li>
                                <li class="game-info-item">
                                    <span class="info-label">개발 상태</span>
                                    <span class="info-value">진행중</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>

            </section>

            <!-- 공통 전체게임 -->
            <%@ include file="../../includes/all-games.jsp" %>
        </main>

        <!-- 공통 Footer -->
        <%@ include file="../../includes/footer.jsp" %>
    </body>

    </html>