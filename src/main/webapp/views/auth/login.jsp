<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<style>
* {
	box-sizing: border-box;
	background-color: black;
}

.container1 {
	position: absolute;
	top: 0px;
	left: 70px;
	width: 800px;
	height: 848px;
}

.title img {
	position: absolute;
	top: 50px;
	left: 190px;
	width: 366px;
	height: 140px;
	font-size: 64px;
	line-height: 84px;
	font-weight: 400;
}

.subtitle {
	position: absolute;
	top: 210px;
	left: 316px;
	width: 124px;
	height: 52px;
	font-size: 32px;
	line-height: 48px;
	font-weight: 400;
	color: white;
}

.id {
	position: absolute;
	top: 287px;
	left: 134px;
	opacity: 1;
	width: 473px;
	height: 46px;
	padding-left: 12px;
	padding-right: 12px;
	font-size: 14px;
	line-height: 22px;
	font-weight: 400;
	background: rgb(77, 76, 77);
	border-radius: 10px;
	border-width: 1px;
	border-color: #BCC1CAFF;
	border-style: solid;
	outline: none;
	color: white;
}

.pw {
	position: absolute;
	top: 371px;
	left: 134px;
	opacity: 1;
	width: 473px;
	height: 46px;
	padding-left: 12px;
	padding-right: 12px;
	font-size: 14px;
	line-height: 22px;
	font-weight: 400;
	background: rgb(77, 76, 77);
	border-radius: 10px;
	border-width: 1px;
	border-color: #BCC1CAFF;
	border-style: solid;
	outline: none;
	color: white;
}

.rememberId {
	position: absolute;
	top: 227px;
	left: 68px;
	opacity: 1;
}

.rememberId div {
	position: absolute;
	top: 225px;
	left: 98px;
	opacity: 1;
	width: 100px;
	color: white;
}

.signIn {
	position: absolute;
	top: 494px;
	left: 134px;
	width: 473px;
	height: 47px;
	padding: 0 16px;
	align-items: center;
	justify-content: center;
	font-size: 16px;
	line-height: 26px;
	font-weight: 400;
	color: black;
	background: white;
	opacity: 1;
	border: none;
	border-radius: 10px;
	box-shadow: 0px 8px 17px #636AE826, 0px 0px 2px #636AE81F;
	cursor: pointer;
	transition: background-color 0.5s ease, opacity 0.5s ease, box-shadow
		0.5s ease;
}

.signIn:hover {
	background-color: #868789b9;
}

.join_membership {
	position: absolute;
	top: 555px;
	left: 144px;
	width: 91px;
	height: 24px;
	font-size: 14px;
	line-height: 22px;
	font-weight: 400;
	color: white;
}

.findId {
	position: absolute;
	top: 555px;
	left: 221px;
	width: 91px;
	height: 24px;
	font-size: 14px;
	line-height: 22px;
	font-weight: 400;
	color: white;
}

.findPw {
	position: absolute;
	top: 555px;
	left: 316px;
	width: 91px;
	height: 24px;
	font-size: 14px;
	line-height: 22px;
	font-weight: 400;
	color: white;
}

.container2 {
	position: absolute;
	top: 0px;
	left: 690px;
	width: 700px;
	height: 848px;
	border-radius: 0px;
}

.sign {
	width: 100%;
	height: 100%;
}

.logo {
	position: absolute;
	z-index: 20;
	/* logo가 sign.jpg보다 앞에 오도록 z-index 값을 높임 */
	width: 500px;
	height: 300px;
	top: 250px;
	/* logo를 원하는 위치로 배치 */
	left: 50%;
	transform: translateX(-50%);
	/* 수평 가운데 정렬 */
	background-color: rgba(255, 255, 255, 0);
}

html, body {
	overflow: hidden;
	margin: 0;
	padding: 0;
	height: 100%;
}

input::placeholder {
	color: white;
	/* 원하는 색상 코드로 변경 */
}

.with {
	position: absolute;
	top: 610px;
	left: 315px;
	width: 117px;
	height: 24px;
	font-size: 14px;
	line-height: 22px;
	font-weight: 400;
	color: white;
}

.google {
	position: absolute;
	top: 650px;
	left: 180px;
	width: 356px;
	height: 52px;
	padding: 0 16px;
	display: flex;
	align-items: center;
	justify-content: center;
	font-family: Inter;
	font-size: 16px;
	line-height: 26px;
	font-weight: 400;
	color: black;
	background: white;
	opacity: 1;
	border: none;
	border-radius: 26px;
	gap: 6px;
	cursor: pointer;
	transition: background-color 0.5s ease, opacity 0.5s ease, box-shadow
		0.5s ease;
}

.google:hover {
	color: #FFFFFFFF;
	background-color: #868789b9;
}

.google i {
	border: none;
	outline: none;
	background-color: rgba(255, 255, 255, 0);
}
</style>
</head>
<body>

	<div class="container1">
		<div class="title">
			<img src="logo.png" alt="">
		</div>
		<div class="subtitle">SIGN IN</div>
		<input type="text" class="id" placeholder="TechX 아이디 입력"> <input
			type="text" class="pw" placeholder="비밀번호 입력">
		<div class="rememberId">
			<input type="checkbox" class="rememberId">
			<div class="rememberId">Remember id</div>
		</div>


		<div class="container2">
			<img src="sign.jpg" alt="" class="sign"> <img src="logo.png"
				alt="" class="logo">
		</div>
		<button type="button" class="signIn">Sign In</button>
		<div class="join_membership">회원가입</div>
		<div class="findId">아이디 찾기</div>
		<div class="findPw">비밀번호 찾기</div>
		<div class="with">Or sign in with</div>
		<button class="google">
			<i class="fa-brands fa-google fa-lg" style="color: #ffa200;"></i>
			Google 계정으로 로그인
		</button>
</body>
</html>