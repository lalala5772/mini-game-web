<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <%@ page import="javax.servlet.http.HttpSession" %>


            <!DOCTYPE html>
            <html lang="ko">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>404 - 페이지를 찾을 수 없습니다</title>
                <!-- font-awesome -->
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
                <!-- 브라우저마다 기본적으로 적용되는 스타일이 다르기 때문에, 이를 제거해서 일관된 스타일을 유지하기 위해 추가하는 CSS 파일 -->
                <link rel="stylesheet" href="/assets/css/reset.css">
                <!-- 헤더 & 푸터 css  -->
                <link rel="stylesheet" href="/assets/css/layout.css">
                <!-- 커스텀 css -->
                <link rel="stylesheet" href="/assets/css/error404.css">
                <!-- jQuery CDN  -->
                <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            </head>

            <body>
                <!-- 공통 Header -->
                <%@ include file="/includes/header.jsp" %>

                    <!-- 메인 화면 ::s-->
                    <div class="stars" id="stars"></div>

                    <div class="container">
                        <!-- 게임 컨트롤러 대신 Font Awesome 아이콘 사용 -->
                        <div class="game-icon">
                            <i class="fa-solid fa-gamepad"></i>
                        </div>


                        <h1 class="error-code glitch-animation">404</h1>
                        <h2 class="error-title">게임 오버! 페이지를 찾을 수 없습니다</h2>
                        <p class="error-message">찾으시는 페이지가 존재하지 않거나, 이동되었거나, 일시적으로 사용할 수 없습니다.<br>홈으로 돌아가서 새로운 모험을
                            시작해보세요!</p>

                        <a href="/" class="home-button">메인 페이지로 이동</a>
                    </div>
                    <!-- 메인 화면 ::e-->

            </body>

            </html>