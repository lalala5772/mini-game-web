<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="auth.dto.UsersDTO"%>
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

input[type="text"], input[type="password"], input[type="email"] {
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

.error-msg {
	color: red;
	font-size: 0.9em;
	margin-top: 5px;
	display: none;
}

.success-msg {
	color: green;
	font-size: 0.9em;
	margin-top: 5px;
	display: none;
}

.error {
	color: red;
	margin-top: 10px;
}

.success {
	color: green;
	margin-top: 10px;
}

.check-button {
	background-color: #2196F3;
	color: white;
	border: none;
	border-radius: 4px;
	padding: 8px 15px;
	cursor: pointer;
	margin-top: 5px;
	font-size: 14px;
}

.check-button:hover {
	background-color: #0b7dda;
}

.nickname-container {
	display: flex;
	align-items: center;
}

.nickname-container input {
	flex: 1;
}

.nickname-container button {
	width: auto;
	margin-left: 10px;
	margin-top: 0;
}
.withdraw-btn {
	background-color : red;
}
</style>
</head>
<body>
	<div class="container">
		<h2>회원정보 수정</h2>
		<form id="modifyForm" action="/info.mypage">
			<div class="form-group">
				<label for="userId">아이디</label> <input type="text" id="userId"
					name="userId" value="<%= loginUser.getId() %>" readonly>
			</div>
			<div class="form-group">
				<label for="userName">이름</label> <input type="text" id="userName"
					name="userName" value="<%= loginUser.getName() %>">
				<div id="userNameError" class="error-msg"></div>
			</div>
			<div class="form-group">
				<label for="userNickname">닉네임</label>
				<div class="nickname-container">
					<input type="text" id="userNickname" name="userNickname"
						value="<%= loginUser.getNickname() %>">
					<button type="button" id="checkNickname" class="check-button">중복확인</button>
				</div>
				<div id="userNicknameError" class="error-msg"></div>
				<div id="userNicknameSuccess" class="success-msg"></div>
			</div>
			<div class="form-group">
				<label for="userEmail">이메일</label> <input type="email"
					id="userEmail" name="userEmail" value="<%= loginUser.getEmail() %>">
				<div id="userEmailError" class="error-msg"></div>
			</div>
			<div class="form-group">
				<label for="userPhone">핸드폰 번호</label> <input type="text"
					id="userPhone" name="userPhone" value="<%= loginUser.getPhone() %>">
				<div id="userPhoneError" class="error-msg"></div>
			</div>
			<div class="form-group">
				<label for="userRnum">생년월일</label> <input type="text" id="userRnum"
					name="userRnum" value="<%= loginUser.getRnum() %>">
				<div id="userRnumError" class="error-msg"></div>
			</div>
			<button type="submit">수정하기</button>
		</form>
		<form id="withdraw-frm" action="/withdraw.users">
		<input type="hidden" name="withdrawId" id="hiddenWithdrawId" /> 
		<button type="button" id=withdraw-btn>탈퇴하기</button>
		</form>

		<p class="error" id="errorMsg"></p>
		<p class="success" id="successMsg"></p>
	</div>
	
	<script>
	$(document).ready(function () {
	    // 정규식 설정
	    const nameRegex = /^[가-힣]{2,5}$/;
	    const nicknameRegex = /^[\w가-힣]{1,9}$/;
	    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
	    const phoneRegex = /^01[0|1|6|7|8|9][- ]?\d{3,4}[- ]?\d{4}$/;
	    const rnumRegex = /^\d{6}$/;

	    // 각 필드의 유효성 상태를 저장할 객체
	    const validationState = {
	        userName: true,
	        userNickname: true,
	        userEmail: true,
	        userPhone: true,
	        userRnum: true,
	        nicknameChecked: false // 닉네임 중복 검사 여부
	    };

	    // 실시간 유효성 검사 함수
	    function validateInput(field, regex, errorMsg) {
	        const $input = $(field);
	        const $errorDiv = $(`#${field.slice(1)}Error`);
	        
	        $input.on("input", function () {
	            const value = $(this).val().trim();
	            
	            if (value === "") {
	                $errorDiv.hide();
	                validationState[field.slice(1)] = true;
	                return;
	            }
	            
	            if (regex.test(value)) {
	                $errorDiv.removeClass("error-msg").addClass("success-msg").text("올바른 형식입니다.").show();
	                validationState[field.slice(1)] = true;
	                
	                if (field === "#userNickname") {
	                    if (value !== "<%= loginUser.getNickname() %>") {
	                        validationState.nicknameChecked = false;
	                        $("#userNicknameSuccess").hide();
	                    } else {
	                        validationState.nicknameChecked = true;
	                    }
	                }
	            } else {
	                $errorDiv.removeClass("success-msg").addClass("error-msg").text(errorMsg).show();
	                validationState[field.slice(1)] = false;
	            }
	        });

	        $input.trigger("input");
	    }

	    // 각 필드에 유효성 검사 적용
	    validateInput("#userName", nameRegex, "이름은 한글 2~5자여야 합니다.");
	    validateInput("#userNickname", nicknameRegex, "닉네임은 한글, 영문, 숫자로 1~9자여야 합니다.");
	    validateInput("#userEmail", emailRegex, "올바른 이메일 형식이 아닙니다.");
	    validateInput("#userPhone", phoneRegex, "전화번호 형식이 올바르지 않습니다.");
	    validateInput("#userRnum", rnumRegex, "생년월일은 6자리 숫자여야 합니다.");

	    // 닉네임 중복 검사 버튼 이벤트
	    $("#checkNickname").click(function() {
	        const nickname = $("#userNickname").val().trim();
	        const $errorDiv = $("#userNicknameError");
	        const $successDiv = $("#userNicknameSuccess");

	        if (nickname === "") {
	            $errorDiv.removeClass("success-msg").addClass("error-msg").text("닉네임을 입력해주세요.").show();
	            $successDiv.hide();
	            return;
	        }

	        if (!nicknameRegex.test(nickname)) {
	            $errorDiv.removeClass("success-msg").addClass("error-msg").text("닉네임은 한글, 영문, 숫자로 1~9자여야 합니다.").show();
	            $successDiv.hide();
	            return;
	        }

	        if (nickname === "<%= loginUser.getNickname() %>") {
	            $successDiv.text("현재 사용 중인 닉네임입니다.").show();
	            $errorDiv.hide();
	            validationState.nicknameChecked = true;
	            return;
	        }

	        // AJAX로 닉네임 중복 검사
	        $.ajax({
	            type: "POST",
	            url: "/checkDuplicate.users",
	            data: { field: "NICKNAME", value: nickname },
	            success: function(response) {
	                if (response === "duplicate") {
	                    $errorDiv.removeClass("success-msg").addClass("error-msg").text("이미 사용 중인 닉네임입니다.").show();
	                    $successDiv.hide();
	                    validationState.nicknameChecked = false;
	                    validationState.userNickname = false;
	                } else {
	                    $successDiv.text("사용 가능한 닉네임입니다.").show();
	                    $errorDiv.hide();
	                    validationState.nicknameChecked = true;
	                    validationState.userNickname = true;
	                }
	            },
	            error: function() {
	                $errorDiv.removeClass("success-msg").addClass("error-msg").text("서버 오류가 발생했습니다. 다시 시도해주세요.").show();
	                $successDiv.hide();
	                validationState.nicknameChecked = false;
	            }
	        });
	    });

	    // 닉네임 변경 감지
	    $("#userNickname").on("input", function() {
	        const value = $(this).val().trim();
	        
	        if (value === "<%= loginUser.getNickname() %>") {
	            $("#userNicknameSuccess").text("현재 사용 중인 닉네임입니다.").show();
	            $("#userNicknameError").hide();
	            validationState.nicknameChecked = true;
	        } else {
	            $("#userNicknameSuccess").hide();
	            validationState.nicknameChecked = false;
	        }
	    });

	    // 페이지 로드 시 닉네임 초기 설정
	    if ($("#userNickname").val().trim() === "<%= loginUser.getNickname() %>") {
	        validationState.nicknameChecked = true;
	    }

	    // 폼 제출 시 최종 유효성 검사
	    $("#modifyForm").submit(function (event) {
	        event.preventDefault();

	        if ($("#userNickname").val().trim() !== "<%= loginUser.getNickname() %>" && !validationState.nicknameChecked) {
	            $("#userNicknameError").removeClass("success-msg").addClass("error-msg")
	                .text("닉네임 중복 확인이 필요합니다.").show();
	            $("#userNicknameSuccess").hide();
	            $("#errorMsg").text("닉네임 중복 확인이 필요합니다.").show();
	            return;
	        }

	        let isValid = true;

	        for (let field in validationState) {
	            if (field === 'nicknameChecked') continue;
	            if (!validationState[field]) {
	                isValid = false;
	                break;
	            }
	        }

	        if (!isValid) {
	            $("#errorMsg").text("입력값을 다시 확인해주세요.").show();
	            $("#successMsg").hide();
	            return;
	        }

	        $.ajax({
	            type: "POST",
	            url: "updateUserAction.jsp",
	            data: $("#modifyForm").serialize(),
	            dataType: "json",
	            success: function (response) {
	                if (response.status === "success") {
	                    $("#successMsg").text("회원정보가 성공적으로 수정되었습니다.").show();
	                    $("#errorMsg").hide();
	                    setTimeout(() => window.location.href = "/info.mypage", 1500);
	                } else {
	                    $("#errorMsg").text(response.message || "회원정보 수정에 실패했습니다.").show();
	                }
	            },
	            error: function () {
	                $("#errorMsg").text("서버 오류가 발생했습니다. 다시 시도해주세요.").show();
	            }
	        });
	    });
	});
	
	// 탈퇴하기 버튼 이벤트
    $("#withdraw-btn").on("click",function(){
    	if(confirm("정말 탈퇴하시겠습니까?")) {
    		$("#hiddenWithdrawId").val($("#userId").val());
        	$("#withdraw-frm").submit();
    	}
    	
    })
</script>

</body>
</html>