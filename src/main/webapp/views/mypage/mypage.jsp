<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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
<style>
* {
    box-sizing: border-box;
    background-color: black;
    color: white;
}

.title {
    position: absolute;
    top: 14px;
    left: 130px;
    width: 281px;
    height: 48px;
    font-size: 32px;
    line-height: 48px;
    font-weight: 700;
}

.menu {
    position: absolute;
    top: 0px;
    left: 0px;
    width: 100px;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    font-size: 35px;
    line-height: 22px;
    font-weight: 400;
    opacity: 1;
    border-right: 1px solid white;
}

#boardicon {
    position: absolute;
    top: 125px;
    left: 35px;
    cursor: pointer;
}

#gameicon {
    position: absolute;
    top: 190px;
    left: 25px;
    cursor: pointer;
}

.nickname {
    position: absolute;
    top: 100px;
    left: 150px;
    width: 281px;
    height: 96px;
    font-size: 32px;
    line-height: 48px;
    font-weight: 700;

}

.id {
    position: absolute;
    top: 140px;
    left: 150px;
    width: 281px;
    height: 96px;
    font-size: 15px;
    line-height: 48px;
}

.line1 {
    position: absolute;
    top: 220px;
    left: 150px;
    width: 461px;
    height: 0px;
    border-width: 1px;
    border-color: #DEE1E6FF;
    border-style: dashed;
    transform: rotate(0deg);
}

.email {
    position: absolute;
    top: 250px;
    left: 150px;
    width: 169px;
    height: 22px;
    font-size: 14px;
    line-height: 22px;
    font-weight: 600;
}

.phonenum {
    position: absolute;
    top: 290px;
    left: 150px;
    width: 169px;
    height: 22px;
    font-size: 14px;
    line-height: 22px;
    font-weight: 600;
}

.address {
    position: absolute;
    top: 330px;
    left: 150px;
    width: 461px;
    height: 22px;
    font-size: 14px;
    line-height: 22px;
    font-weight: 600;
}

.line2 {
    position: absolute;
    top: 400px;
    left: 150px;
    width: 461px;
    height: 0px;
    border-width: 1px;
    border-color: #DEE1E6FF;
    border-style: dashed;
    transform: rotate(0deg);
}

.gamepoint1 {
    position: absolute;
    top: 430px;
    left: 150px;
    font-size: 14px;
    line-height: 22px;
    font-weight: 400;
}

.gamepoint2 {
    position: absolute;
    top: 430px;
    left: 250px;
    width: 38px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 11px;
    line-height: 18px;
    font-weight: 400;
    opacity: 1;
    color: black;
}

.gamepoint2 {
    height: 24px;
    padding-left: 6px;
    padding-right: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 6px;
}

.gamepoint2 {
    padding-left: 2px;
    padding-right: 2px;
}

.gamepoint2 {
    font-family: Inter;
    font-size: 11px;
    line-height: 18px;
    font-weight: 700;
    background: #FDF2F2FF;
    border-color: #00000000;
}

.gamepoint2:hover {
    color: #DE3B40FF;
    background: #F5C4C6FF;
}

.gamepoint2:hover:active {
    color: #DE3B40FF;
    background: #ED9699FF;
}

.gamepoint2:disabled {
    color: #DE3B40FF;
    background: #FDF2F2FF;
}

.playtime1 {
    position: absolute;
    top: 470px;
    left: 150px;
    font-size: 14px;
    line-height: 22px;
    font-weight: 400;
}

.playtime2 {
    position: absolute;
    top: 470px;
    left: 280px;
    width: 38px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 11px;
    line-height: 18px;
    font-weight: 400;
    opacity: 1;
    color: black;
}

.playtime2 {
    height: 24px;
    padding-left: 6px;
    padding-right: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 6px;
}

.playtime2 {
    padding-left: 2px;
    padding-right: 2px;
}

.playtime2 {
    font-size: 11px;
    line-height: 18px;
    font-weight: 700;
    background: #FDF2F2FF;
    border-color: #00000000;
}

.playtime2:hover {
    color: #DE3B40FF;
    background: #F5C4C6FF;
}

.playtime2:hover:active {
    color: #DE3B40FF;
    background: #ED9699FF;
}

.playtime2:disabled {
    color: #DE3B40FF;
    background: #FDF2F2FF;
}

.line3 {
    position: absolute;
    top: 520px;
    left: 150px;
    width: 461px;
    height: 0px;
    border-width: 1px;
    border-color: #DEE1E6FF;
    border-style: solid;
    transform: rotate(0deg);
}

.favourite {
    position: absolute;
    top: 535px;
    left: 150px;
    font-size: 14px;
    line-height: 22px;
    font-weight: 700;
}

.gamebox1 {
    position: absolute;
    top: 565px;
    left: 150px;
    width: 461px;
    height: 68px;
    /* background: rgb(0, 0, 0); */
    border-color: #DEE1E6FF;
    border-radius: 6px;
    border-width: 1px;
    border-style: solid;
    display: flex;
    justify-content: left;
    align-items: center;
}

/* position: absolute;
    top: 650px;
    left: 150px;
    width: 461px;
    height: 68px;
    border-radius: 6px;
    border-width: 1px;
    border-color: #DEE1E6FF;
    border-style: solid;
    display: flex;
    justify-content: left;
    align-items: center; */

.score1 {
    position: absolute;
    top: 588px;
    left: 360px;
    width: 64px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 11px;
    line-height: 18px;
    font-weight: 400;
    opacity: 1;
    color: black;
}

.score1 {
    height: 24px;
    padding-left: 6px;
    padding-right: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
}

.score1 {
    padding-left: 2px;
    padding-right: 2px;
}

.score1 {
    font-family: Inter;
    font-size: 11px;
    line-height: 18px;
    font-weight: 400;
    background: #EEFDF3FF;
    border-color: #00000000;
}

.score1:hover {
    color: black;
    background: #82EEA6FF;
}

.score1:hover:active {
    color: black;
    background: #1DD75BFF;
}

.score1:disabled {
    color: black;
    background: #EEFDF3FF;
}

.rank1 {
    position: absolute;
    top: 588px;
    left: 450px;
    width: 52px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 11px;
    line-height: 18px;
    font-weight: 400;
    opacity: 1;
    color: black;
}

.rank1 {
    height: 24px;
    padding-left: 6px;
    padding-right: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
}

.rank1 {
    padding-left: 2px;
    padding-right: 2px;
}

.rank1 {
    font-family: Inter;
    font-size: 11px;
    line-height: 18px;
    font-weight: 400;
    background: #F1F8FDFF;
    border-color: #00000000;
}

.rank1:hover {
    color: black;
    background: #ACD5F5FF;
}

.rank1:hover:active {
    color: black;
    background: #66B2ECFF;
}

.rank1:disabled {
    color: black;
    background: #F1F8FDFF;
}

.gamebox2 {
    position: absolute;
    top: 650px;
    left: 150px;
    width: 461px;
    height: 68px;
    border-radius: 6px;
    border-width: 1px;
    border-color: #DEE1E6FF;
    border-style: solid;
    display: flex;
    justify-content: left;
    align-items: center;
}

.score2 {
    position: absolute;
    top: 673px;
    left: 360px;
    width: 64px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-family: Inter;
    font-size: 11px;
    line-height: 18px;
    font-weight: 400;
    opacity: 1;
    color: black;
}

.score2 {
    height: 24px;
    padding-left: 6px;
    padding-right: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
}

.score2 {
    padding-left: 2px;
    padding-right: 2px;
}

.score2 {
    font-family: Inter;
    font-size: 11px;
    line-height: 18px;
    font-weight: 400;
    background: #EEFDF3FF;
    border-color: #00000000;
}

.score2:hover {
    color: #117B34FF;
    background: #82EEA6FF;
}

.score2:hover:active {
    color: #117B34FF;
    background: #1DD75BFF;
}

.score2:disabled {
    color: #117B34FF;
    background: #EEFDF3FF;
}


.rank2 {
    position: absolute;
    top: 673px;
    left: 450px;
    width: 52px;
    height: 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 11px;
    line-height: 18px;
    font-weight: 400;
    opacity: 1;
    color: black;
}


.rank2 {
    height: 24px;
    padding-left: 6px;
    padding-right: 6px;
    display: flex;
    align-items: center;
    justify-content: center;
    border-radius: 12px;
}

.rank2 {
    padding-left: 2px;
    padding-right: 2px;
}

.rank2 {
    font-size: 11px;
    line-height: 18px;
    font-weight: 400;
    background: #F1F8FDFF;
    border-color: #00000000;
}

.rank2:hover {
    color: black;
    background: #ACD5F5FF;
}

.rank2:hover:active {
    color: black;
    background: #66B2ECFF;
}

.rank2:disabled {
    color: black;
    background: #F1F8FDFF;
}


/* Header Menu 4 */
.post {
    position: absolute;
    top: 150px;
    left: 750px;
    width: 110px;
    height: 56px;
    display: flex;
    align-items: center;
    font-size: 16px;
    line-height: 26px;
    font-weight: 400;
    opacity: 1;
    cursor: pointer;
}


/* Header Menu 4 */
.reply {
    position: absolute;
    top: 150px;
    left: 900px;
    width: 92px;
    height: 56px;
    display: flex;
    align-items: center;
    font-size: 16px;
    line-height: 26px;
    font-weight: 400;
    opacity: 1;
    cursor: pointer;
}

/* Table 1 */
table {
    position: absolute;
    top: 200px;
    left: 750px;
    width: 700px;
    height: 100px;
    opacity: 1;
    border-radius: 0px;
    text-align: start;
    border-collapse: collapse;
}

th,
td {
    text-align: start;
    padding: 0px;
    border-bottom: 1px solid white;
}

th:nth-child(1),
td:nth-child(1) {
    width: 50px;
    /* #1 열 */
}

th:nth-child(2),
td:nth-child(2) {
    width: 800px;
    /* 제목 열 */
}

th:nth-child(2),
th:nth-child(3),
th:nth-child(4),
th:nth-child(4),
td:nth-child(4),
th:nth-child(3),
td:nth-child(3) {
    text-align: center;
}

th:nth-child(3),
td:nth-child(3) {
    width: 100px;
    /* 조회수 열 */
}

th:nth-child(4),
td:nth-child(4) {
    width: 150px;
    /* 작성일 열 */
}


/* Textbox 57 */
.subtitle {
    position: absolute;
    top: 90px;
    left: 740px;
    opacity: 1;
}

.subtitle {
    width: 730px;
    height: 53px;
    padding-left: 16px;
    padding-right: 16px;
    font-size: 33px;
    line-height: 36px;
    font-weight: 900;
    background: #6e778767;
    border-radius: 16px 16px 0px 0px;
    border-width: 1px;
    border-color: #FFFFFFFF;
    border-style: solid;
    outline: none;
    display: flex;
    justify-content: start;
    align-items: center;
}

/* Button 55 */
.modify {
    position: absolute;
    top: 750px;
    left: 230px;
    height: 44px;
    padding: 0 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: Inter;
    font-size: 16px;
    line-height: 26px;
    font-weight: 400;
    color: white;
    background: rgba(255, 255, 255, 0.488);
    opacity: 1;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

.main {
    position: absolute;
    top: 750px;
    left: 400px;
    height: 44px;
    padding: 0 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-family: Inter;
    font-size: 16px;
    line-height: 26px;
    font-weight: 400;
    color: white;
    background: rgba(255, 255, 255, 0.488);
    opacity: 1;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}

/* Image 52 */
.game1 {
    position: absolute;
    top: 180px;
    left: 740px;
    width: 220px;
    height: 200px;
    border-radius: 8px;
    background-color: white;
}

.game1 img{
    width: 100%;
    height: 200px;
    border-radius: 8px;
}

.game2 {
    position: absolute;
    top: 180px;
    left: 1000px;
    width: 220px;
    height: 200px;
    border-radius: 8px;
    background-color: white;
}

.game2 img{
    width: 100%;
    height: 200px;
    border-radius: 8px;
}

.game3 {
    position: absolute;
    top: 180px;
    left: 1250px;
    width: 220px;
    height: 200px;
    border-radius: 8px;
    background-color: white;
}

.game3 img{
    width: 100%;
    height: 200px;
    border-radius: 8px;
}

.game4 {
    position: absolute;
    top: 500px;
    left: 740px;
    width: 220px;
    height: 200px;
    border-radius: 8px;
    background-color: white;
}

.game4 img{
    width: 100%;
    height: 200px;
    border-radius: 8px;
}

.game5 {
    position: absolute;
    top: 500px;
    left: 1000px;
    width: 220px;
    height: 200px;
    border-radius: 8px;
    background-color: white;
}

.game5 img{
    width: 100%;
    height: 200px;
    border-radius: 8px;
}

.game6 {
    position: absolute;
    top: 500px;
    left: 1250px;
    width: 220px;
    height: 200px;
    border-radius: 8px;
    background-color: white;
}

.game6 img{
    width: 100%;
    height: 200px;
    border-radius: 8px;
}

.rank, .myscore {
    display: inline-block; /* inline-block을 사용하여 한 줄에 나열 */
    margin-right: 10px; /* 두 요소 간의 간격 */
}


/* .myrank,.rank,.myscore{
    background-color: rgba(255, 255, 255, 0.146);
    color: white;
    
} */

.container3 {
    display: none;
}

.unregister{
    position: absolute;
    top: 780px;
    left: 1370px;
    height: 32px;
    width: 98px;
    padding: 0 16px;
    display: flex;
    align-items: center;
    justify-content: center;
    font-size: 16px;
    line-height: 26px;
    font-weight: 400;
    color: white;
    background: rgba(255, 255, 255, 0.541);
    opacity: 1;
    border: none;
    border-radius: 6px;
    cursor: pointer;
}
</style>
</head>
<body>

	<div class="container1">
        <div class="title">My Page</div>
        <div class="menu">
            <i class="fa-solid fa-clipboard-list" id="boardicon" style="color: #ffffff;"></i>
            <i class="fa-solid fa-gamepad" id="gameicon" style="color: #ffffff;"></i>
        </div>
        <div class="nickname">미르몬스터</div>
        <div class="id">mir5772</div>
        <div class="line1"></div>
        <div class="email"><i class="fa-solid fa-at"></i> xxxxx@gmail.com</div>
        <div class="phonenum"><i class="fa-solid fa-phone"></i> 010-1234-5678</div>
        <div class="address"><i class="fa-solid fa-location-dot"></i> 서울특별시 관악구 신림로 00길 땡땡오피스텔 303호</div>
        <div class="line2"></div>
        <div class="gamepoint1">게임포인트</div>
        <div class="gamepoint2">330</div>
        <div class="playtime1">총 플레이 시간</div>
        <div class="playtime2">15분</div>
        <div class="line3"></div>
        <div class="favourite">My FAVOURITE</div>
        <div class="gamebox1">&nbsp;&nbsp;길 건너기 게임</div>
        <div class="score1">score : 10</div>
        <div class="rank1">rank : 8</div>
        <div class="gamebox2">&nbsp;&nbsp;고기굽기 게임</div>
        <div class="score2">score : 10</div>
        <div class="rank2">rank : 8</div>
        <button class="modify">수정하기</button>
        <button class="main">메인화면</button>

    </div>

    <div class="container2">
        <div class="subtitle">내 커뮤니티 활동내역</div>
        <div class="post">내가 쓴 게시물</div>
        <div class="reply">내가 쓴 댓글</div>
        <table>
            <tr>
                <th></th>
                <th>제목</th>
                <th>조회수</th>
                <th class="date">작성일</th>
            </tr>
            <tbody>
                <tr>
                    <td>#1</td>
                    <td>제목 입니다.</td>
                    <td>65</td>
                    <td class="date">2015-05-10</td>
                </tr>
            </tbody>
        </table>
    </div>

    <div class="container3">
        <div class="subtitle">내 게임 순위</div>
        <div class="game1">
            <div class="gameimg"><img src="sign.jpg" alt=""></div>
            <div class="myrank">내 순위</div>
            <div class="rank"><i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> 2등</div>
            <div class="myscore"><i class="fa-solid fa-star" style="color: #ffffff;"></i> 15점</div>
        </div>

        <div class="game2">
            <div class="gameimg"><img src="sign.jpg" alt=""></div>
            <div class="myrank">내 순위</div>
            <div class="rank"><i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> 2등</div>
            <div class="myscore"><i class="fa-solid fa-star" style="color: #ffffff;"></i> 15점</div>
        </div>

        <div class="game3">
            <div class="gameimg"><img src="sign.jpg" alt=""></div>
            <div class="myrank">내 순위</div>
            <div class="rank"><i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> 2등</div>
            <div class="myscore"><i class="fa-solid fa-star" style="color: #ffffff;"></i> 15점</div>
        </div>

        <div class="game4">
            <div class="gameimg"><img src="sign.jpg" alt=""></div>
            <div class="myrank">내 순위</div>
            <div class="rank"><i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> 2등</div>
            <div class="myscore"><i class="fa-solid fa-star" style="color: #ffffff;"></i> 15점</div>
        </div>

        <div class="game5">
            <div class="gameimg"><img src="sign.jpg" alt=""></div>
            <div class="myrank">내 순위</div>
            <div class="rank"><i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> 2등</div>
            <div class="myscore"><i class="fa-solid fa-star" style="color: #ffffff;"></i> 15점</div>
        </div>

        <div class="game6">
            <div class="gameimg"><img src="sign.jpg" alt=""></div>
            <div class="myrank">내 순위</div>
            <div class="rank"><i class="fa-solid fa-ranking-star" style="color: #ffffff;"></i> 2등</div>
            <div class="myscore"><i class="fa-solid fa-star" style="color: #ffffff;"></i> 15점</div>
        </div>


    </div>

    <button class="unregister">회원탈퇴</button>


    <script>
        $("#gameicon").on("click", () => {
            $(".container2").css("display", "none");
            $(".container3").css("display", "block");
        })

        $("#boardicon").on("click", () => {
            $(".container2").css("display", "block");
            $(".container3").css("display", "none");
        })
    </script>
</body>
</html>