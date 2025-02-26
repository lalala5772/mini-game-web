<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>비밀번호 변경</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<style>
  .error-msg {
    color: red;
    display: none;
  }
  .success-msg {
    color: green;
    display: none;
  }
</style>
</head>
<body>
<h2>비밀번호 변경</h2>
<form id="resetPwForm" action="resetpw.users" method="post">
  <input type="hidden" name="userId" value="<%= request.getAttribute("userId") %>">
  <div>
    <label for="newPassword">새로운 비밀번호:</label>
    <input type="password" id="newPassword" name="newPassword" required>
  </div>
  <div>
    <label for="confirmPassword">비밀번호 확인:</label>
    <input type="password" id="confirmPassword" name="confirmPassword" required>
  </div>
  <div class="error-msg" id="pwMatchError"></div>
  <button type="button" id="resetPwBtn">비밀번호 변경</button>
</form>

<script>
$(document).ready(function() {
  // 비밀번호 확인 검사
  $("#newPassword, #confirmPassword").on("input", function() {
    let pw = $("#newPassword").val().trim();
    let pwConfirm = $("#confirmPassword").val().trim();
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

  // 비밀번호 변경 버튼 클릭 이벤트
  $("#resetPwBtn").on("click", function() {
    let userId = $("input[name='userId']").val();
    let newPassword = $("#newPassword").val().trim();
    let confirmPassword = $("#confirmPassword").val().trim();

    // 비밀번호 정규식 (대문자, 소문자, 숫자, 특수문자 포함 8자 이상)
    const pwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$/;

    if (!pwRegex.test(newPassword)) {
      alert("비밀번호는 최소 8자 이상이며, 대문자, 소문자, 숫자, 특수문자를 포함해야 합니다.");
      return;
    }

    if (newPassword !== confirmPassword) {
      alert("비밀번호가 일치하지 않습니다.");
      return;
    }

    // 비밀번호 해싱
    let hashedPw = CryptoJS.SHA256(newPassword).toString();

    // AJAX 요청
    $.ajax({
      type: "POST",
      url: "resetpw.users",
      data: { 
        userId: userId, 
        newPassword: hashedPw 
      },
      success: function(response) {
        if (response.trim() === "비밀번호 변경 실패") {
          alert("비밀번호 변경에 실패했습니다.");
        } else {
          alert("비밀번호 변경 성공! 로그인 페이지로 이동합니다.");
          window.opener.location.href = "/index.jsp";
          window.close();
        }
      },
      error: function() {
        alert("서버 오류가 발생했습니다. 다시 시도해주세요.");
      }
    });
  });
});
</script>
</body>
</html>