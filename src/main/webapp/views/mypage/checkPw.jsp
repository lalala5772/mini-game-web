<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>비밀번호 확인</title>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            text-align: center;
            margin: 50px;
        }
        .container {
            width: 300px;
            margin: auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 10px;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.1);
        }
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            box-sizing: border-box;
        }
        button {
            width: 100%;
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        button:hover {
            background-color: #45a049;
        }
        .error {
            color: red;
            margin-top: 10px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>비밀번호 확인</h2>
        <form id="checkPwForm">
            <input type="password" id="password" name="password" placeholder="비밀번호 입력">
            <button type="submit">확인</button>
        </form>
        <p class="error" id="errorMsg"></p>
    </div>

    <script>
        $(document).ready(function() {
            $("#checkPwForm").submit(function(event) {
                event.preventDefault(); // 폼 기본 제출 방지
                
                let password = $("#password").val();
                console.log("요청1: " + password);
                
                if (password === "") {
                    $("#errorMsg").text("비밀번호를 입력하세요.");
                    return;
                }
                
                $.ajax({
                    type: "POST",
                    url: "/views/mypage/checkPasswordAction.jsp",
                    data: { password: password },
                    dataType: "json",
                    success: function(response) {
                        if (response.status === "success") {
                            window.location.href = "/views/mypage/modifyUser.jsp";
                        } else {
                            $("#errorMsg").text("비밀번호가 올바르지 않습니다.");
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