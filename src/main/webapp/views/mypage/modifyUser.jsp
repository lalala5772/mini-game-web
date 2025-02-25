<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="auth.dto.UsersDTO" %>
<%
    // 세션에서 로그인 사용자 정보 가져오기
    UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
    
    // 로그인하지 않은 경우
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>회원정보 수정</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 50px;
        }
        .container {
            width: 500px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        h2 {
            text-align: center;
        }
        .form-group {
            margin-bottom: 15px;
        }
        label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        input[type="text"],
        input[type="password"],
        input[type="email"] {
            width: 100%;
            padding: 10px;
            box-sizing: border-box;
            border: 1px solid #ddd;
            border-radius: 5px;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
            margin-top: 10px;
        }
        button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
        .success {
            color: green;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>회원정보 수정</h2>
        <form id="modifyForm">
            <div class="form-group">
                <label for="userId">아이디</label>
                <input type="text" id="userId" name="userId" value="<%= loginUser.getId() %>" readonly>
            </div>
            <div class="form-group">
                <label for="userName">이름</label>
                <input type="text" id="userName" name="userName" value="<%= loginUser.getName() %>">
            </div>
             <div class="form-group">
                <label for="userNickname">닉네임</label>
                <input type="text" id="userNickname" name="userNickname" value="<%= loginUser.getNickname() %>">
            </div>
            <div class="form-group">
                <label for="userEmail">이메일</label>
                <input type="email" id="userEmail" name="userEmail" value="<%= loginUser.getEmail() %>">
            </div>
            <div class="form-group">
                <label for="userPhone">핸드폰 번호</label>
                <input type="text" id="userPhone" name="userPhone" value="<%= loginUser.getPhone() %>">
            </div>
            <div class="form-group">
                <label for="userRnum">생년월일</label>
                <input type="text" id="userRnum" name="userRnum" value="<%= loginUser.getRnum() %>">
            </div>
            <button type="submit">수정하기</button>
        </form>
        <p class="error" id="errorMsg"></p>
        <p class="success" id="successMsg"></p>
    </div>

    <script>
        $(document).ready(function() {
            $("#modifyForm").submit(function(event) {
                event.preventDefault(); // 폼 기본 제출 방지
                
                // 유효성 검사
                let userName = $("#userName").val();
                let userNickname = $("#userNickname").val();
                let userEmail = $("#userEmail").val();
                let userPhone = $("#userPhone").val();
                let userRnum = $("#userRnum").val();
                
                // 에러 메시지 초기화
                $("#errorMsg").text("");
                $("#successMsg").text("");
                
                if (userName === "") {
                    $("#errorMsg").text("이름을 입력하세요.");
                    return;
                }
                
                if (userNickname === "") {
                    $("#errorMsg").text("닉네임을 입력하세요.");
                    return;
                }
                
                if (userEmail === "") {
                    $("#errorMsg").text("이메일을 입력하세요.");
                    return;
                }
                
                if (userPhone === "") {
                    $("#errorMsg").text("핸드폰 번호를 입력하세요.");
                    return;
                }
                
                if (userRnum === "") {
                    $("#errorMsg").text("생년월일을 입력하세요.");
                    return;
                }
                
                // AJAX를 통해 서버에 수정 요청 보내기
                $.ajax({
                    type: "POST",
                    url: "updateUserAction.jsp",
                    data: {
                        userName: userName,
                        userNickname : userNickname,
                        userEmail: userEmail,
                        userPhone: userPhone,
                        userRnum: userRnum
                    },
                    dataType: "json",
                    success: function(response) {
                        if (response.status === "success") {
                            $("#successMsg").text("회원정보가 성공적으로 수정되었습니다.");
                            window.location.href = "/info.mypage";
                        } else {
                            $("#errorMsg").text(response.message || "회원정보 수정에 실패했습니다.");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.log("AJAX Error:", status, error);
                        console.log("Response:", xhr.responseText);
                        $("#errorMsg").text("서버 오류가 발생했습니다. 다시 시도해주세요.");
                    }
                });
            });
        });
    </script>
</body>
</html>