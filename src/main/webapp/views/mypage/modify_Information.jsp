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
<link rel="stylesheet" href="/assets/css/modify_information.css">

</head>
<body>
	<div class="container">
	  <h2>개인 정보 수정</h2>
    <form action="updateUser.users" method="post" onsubmit="return validateForm()">
        <label>아이디: <input type="text" id="id" name="id" value="${dto.id}" readonly></label><br>
        <label>비밀번호: <input type="text" value="******" disabled></label><br>
        <label>이름: <input type="text" id="name" name="name" value="${dto.name}"></label><br>
        <label>닉네임: <input type="text" id="nickname" name="nickname" value="${dto.nickname}"></label><br>
        <label>전화번호: <input type="text" id="phone" name="phone" value="${dto.phone}"></label><br>
        <label>이메일: <input type="text" id="email" name="email" value="${dto.email}"></label><br>
        <label>생년월일(6자리): <input type="text" id="rnum" name="rnum" value="${dto.rnum}"></label><br>
        <button type="submit">수정하기</button>
    </form>

		<a href="/mypage.users">
		<button class="cancel_btn">이전으로</button>
		</a>
		<a href="/withdraw.users">
		<button class="unregister_btn">회원탈퇴</button>
		</a> 
	</div>
	
	<script>
        function validateForm() {
            const idRegex = /^[a-zA-Z][a-zA-Z0-9]{5,14}$/;
            const nicknameRegex = /^[\w가-힣]{1,9}$/;
            const nameRegex = /^[가-힣]{2,5}$/;
            const phoneRegex = /^01[0|1|6|7|8|9][- ]?\d{3,4}[- ]?\d{4}$/;
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            const rnumRegex = /^\d{6}$/;

            const id = document.getElementById("id").value;
            const nickname = document.getElementById("nickname").value;
            const name = document.getElementById("name").value;
            const phone = document.getElementById("phone").value;
            const email = document.getElementById("email").value;
            const rnum = document.getElementById("rnum").value;

            if (!idRegex.test(id)) {
                alert("아이디는 6~15자의 영문 및 숫자로 시작해야 합니다.");
                return false;
            }
            if (!nicknameRegex.test(nickname)) {
                alert("닉네임은 1~9자의 한글, 영문, 숫자만 가능합니다.");
                return false;
            }
            if (!nameRegex.test(name)) {
                alert("이름은 2~5자의 한글만 가능합니다.");
                return false;
            }
            if (!phoneRegex.test(phone)) {
                alert("올바른 전화번호 형식을 입력하세요.");
                return false;
            }
            if (!emailRegex.test(email)) {
                alert("올바른 이메일 형식을 입력하세요.");
                return false;
            }
            if (!rnumRegex.test(rnum)) {
                alert("생년월일은 6자리 숫자로 입력하세요.");
                return false;
            }
            
            return true;
        }
    </script>
</body>

</html>