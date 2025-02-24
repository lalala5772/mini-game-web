<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 확인</title>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
</head>
<body>
    <div class="textbox1">본인 확인을 위해 비밀번호를 입력 해주세요.</div>
    <input type="password" id="password" placeholder="비밀번호 입력">
    <input type="password" id="passwordConfirm" placeholder="비밀번호 확인">
    <button id="checkPw">확인</button>
    <button onclick="history.back();">취소</button>

    <script>
        $("#checkPw").on("click", function () {
            let pw = $("#password").val();
            let pwConfirm = $("#passwordConfirm").val();

            if (pw !== pwConfirm) {
                alert("비밀번호가 일치하지 않습니다.");
                return;
            }

            $.ajax({
                url: "/checkPassword.users", // 서블릿 경로
                method: "POST",
                data: { password: pw },
                success: function (response) {
                    if (response.trim() === "success") {
                        window.location.href = "/views/mypage/modify_information.jsp";
                    } else {
                        alert("비밀번호가 일치하지 않습니다.");
                    }
                },
                error: function () {
                    alert("서버 오류가 발생했습니다.");
                }
            });
        });
    </script>
</body>
</html>
