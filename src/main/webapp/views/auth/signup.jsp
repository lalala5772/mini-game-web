<%@ page contentType="text/html; charset=UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입</title>
<link rel="stylesheet" href="/assets/css/layout.css">
<link rel="stylesheet" href="/assets/css/reset.css">
	<!-- font-awesome -->
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
<link rel="stylesheet" href="/assets/css/signup.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<script>
$(document).ready(function () {
    const idRegex = /^[a-zA-Z][a-zA-Z0-9]{5,14}$/;
    const pwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$/;
    const nicknameRegex = /^[\w가-힣]{1,9}$/;
    const nameRegex = /^[가-힣]{2,5}$/;
    const phoneRegex = /^01[0|1|6|7|8|9][- ]?\d{3,4}[- ]?\d{4}$/;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    const rnumRegex = /^\d{6}$/;

    function validateInput(selector, regex, errorMsg) {
        $(selector).on("input", function () {
            let value = $(this).val().trim();
            let errorDiv = $(selector + "Error");

            if (value === "") {
                errorDiv.hide();
                return;
            }

            if (regex.test(value)) {
                errorDiv.removeClass("error-msg").addClass("success-msg").text("올바른 형식입니다.").show();
            } else {
                errorDiv.removeClass("success-msg").addClass("error-msg").text(errorMsg).show();
            }
        });
    }

    validateInput("#id", idRegex, "아이디는 영문자로 시작하며 6~15자여야 합니다.");
    validateInput("#pw", pwRegex, "비밀번호는 대소문자, 숫자, 특수문자를 포함한 8자 이상이어야 합니다.");
    validateInput("#nickname", nicknameRegex, "닉네임은 한글, 영문, 숫자로 1~9자여야 합니다.");
    validateInput("#name", nameRegex, "이름은 한글 2~5자여야 합니다.");
    validateInput("#phone", phoneRegex, "전화번호 형식이 올바르지 않습니다.");
    validateInput("#email", emailRegex, "올바른 이메일 형식이 아닙니다.");
    validateInput("#rnum", rnumRegex, "생년월일은 6자리 숫자여야 합니다.");

    // 비밀번호 확인 검사
    $("#pw, #pwConfirm").on("input", function () {
        let pw = $("#pw").val().trim();
        let pwConfirm = $("#pwConfirm").val().trim();
        let errorDiv = $("#pwMatchError");

        if (pw === "" || pwConfirm === "") {
            errorDiv.hide();
            return;
        }

        if (pw === pwConfirm) {
            errorDiv.removeClass("error-msg").addClass("success-msg").text("비밀번호가 같습니다.").show();
        } else {
            errorDiv.removeClass("success-msg").addClass("error-msg").text("비밀번호가 다릅니다.").show();
        }
    });

    // 아이디 & 닉네임 중복 검사 (AJAX)
    function checkDuplicate(field, selector) {
        $(selector).on("blur", function () {
            let value = $(this).val();
            if (value.length < 2) return;

            $.ajax({
                type: "POST",
                url: "/checkDuplicate.users",
                data: { field: field, value: value },
                success: function (response) {
                    let errorDiv = $(selector + "Error");

                    if (response === "duplicate") {
                        errorDiv.removeClass("success-msg").addClass("error-msg").text("이미 사용 중입니다.").show();
                    } else {
                        errorDiv.removeClass("error-msg").addClass("success-msg").text("사용 가능합니다.").show();
                    }
                }
            });
        });
    }

    checkDuplicate("ID", "#id");
    checkDuplicate("NICKNAME", "#nickname");

    // 폼 제출 시 최종 유효성 검사
    function validateForm() {
        let isValid = true;

        $("input").each(function () {
            let errorDiv = $("#" + $(this).attr("id") + "Error");
            if (errorDiv.hasClass("error-msg") && errorDiv.is(":visible")) {
                isValid = false;
            }
        });

        if (!isValid) {
            alert("입력값을 다시 확인해주세요.");
        }

        return isValid;
    }

    $("form").on("submit", function () {
        return validateForm();
    });
});

</script>
</head>
<body>
	<%@ include file="../../includes/header.jsp" %>
	
	<div class="main-container">
	<div class="container">
		<img src="../../assets/img/logoW.png" id="logo" alt="Tech X"> </img>
        <h2 class="form-title">Sign Up</h2>
        <section class="hero signup-form-box">
		<form action="/signup.users" method="post" onsubmit="return validateForm()" class="form-detail">
			<div class="form-group">
				<label for="id">아이디</label> <input type="text" id="id" name="id"
					required>
				<div class="error-msg" id="idError"></div>
			</div>

			<div class="form-group">
				<label for="pw">비밀번호</label> <input type="password" id="pw" name="pw"
					required>
				<div class="error-msg" id="pwError"></div>
			</div>

			<div class="form-group">
				<label for="pwConfirm">비밀번호 확인</label> <input type="password"
					id="pwConfirm" required>
				<div class="error-msg" id="pwMatchError"></div>
			</div>

			<div class="form-group">
				<label for="nickname">닉네임</label> <input type="text" id="nickname"
					name="nickname" required>
				<div class="error-msg" id="nicknameError"></div>
			</div>
			
			<div class="form-group">
				<label for="name">이름</label> <input type="text" id="name" name="name"
					required>
				<div class="error-msg" id="nameError"></div>
			</div>
			
			<div class="form-group">
				<label for="phone">전화번호</label> <input type="text" id="phone"
					name="phone" required placeholder="010-1234-5678">
				<div class="error-msg" id="phoneError"></div>
			</div>
			
			<div class="form-group">
				<label for="email">이메일</label> <input type="email" id="email"
					name="email" required>
				<div class="error-msg" id="emailError"></div>
			</div>
			
			<div class="form-group">
				<label for="rnum">생년월일 (YYMMDD)</label> <input type="text" id="rnum"
					name="rnum" required placeholder="YYMMDD">
				<div class="error-msg" id="rnumError"></div>
			</div>
			<button class="register-btn" type="submit">가입하기</button>
		</form>
		</section>
	</div>
	</div>
	
	<%@ include file="../../includes/footer.jsp" %>
</body>
</html>