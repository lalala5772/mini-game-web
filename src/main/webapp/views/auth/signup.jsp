<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Signup Form</title>
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            background-color: black;
        }

        img {
            width: 100px;
            height: 30px;
            object-fit: cover;
            margin: 30px 0 0 30px;
        }

        .signup-container {
            width: 80%;
            margin: 50px 50px 50px 50px;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.1);
        }


        /* 미디어 쿼리: 화면 크기 768px 이하 */
        @media screen and (max-width: 768px) {
            
            section {
                max-width: 90vw; /* 최대 너비 90% */
            }

        }

        .signup-form-box form {
            display: flex;
            flex-direction: column;
            align-items: center; /* 내부 요소들을 가운데 정렬 */
            justify-content: center;
            width: 100%; /* 폼 전체를 부모 크기에 맞춤 */
            max-width: 1440px; /* 폼 크기 제한 */
        }

        .signup-form-box input,
        .signup-form-box button {
            width: 100%; /* 입력 필드와 버튼을 부모 크기에 맞춤 */
            padding: 10px;
            margin: 5px 0;
            border: 1px solid #ccc;
            border-radius: 5px;
        }


        .form-title {
            text-align: center;
            margin-bottom: 40px;
        }

        .form-group {
            width: 70%;
            margin-bottom: 35px;
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 5px;
        }

        input, select, button {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        .inline-group {
            display: flex;
            gap: 5px;
        }

        .inline-group .inputs {
            flex: 1;
        } 

        .inline-group button {
            flex: 0.5;
            background-color: black;
            color: white;
            cursor: pointer;
        }

        .inline-group button:hover {
            background-color: #555;
        }

        .password-message {
            font-size: 12px;
            color: red;
            margin-top: 5px;
        }

        .register-btn {
            width: 50%;
            margin-top: 40px;
            background-color: black;
            color: white;
            cursor: pointer;
            font-size: 16px;
        }

        .register-btn:hover {
            background-color: #555;
        }
    </style>
</head>
<body>
     <div class="signup-container">
        <img src="assets/TechX_log.png" id="logo" alt="Tech X"></img>
        <h2 class="form-title">Sign Up</h2>

        <section class="hero signup-form-box">
            <form id="signup-form">
                <!-- ID 입력 -->
                <div class="form-group">
                    <label for="userid">ID 입력</label>
                    <div class="inline-group">
                        <input class="inputs" type="text" id="userid" placeholder="Enter ID">
                        <button type="button">중복확인</button>
                    </div>
                </div>

                <!-- Password 입력 -->
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" placeholder="Enter password">
                </div>

                <div class="form-group">
                    <label for="confirmPassword">Password 재입력</label>
                    <input type="password" id="confirmPassword" placeholder="Confirm password">
                    <p id="passwordMessage" class="password-message"></p>
                </div>

                <!-- Name 입력 -->
                <div class="form-group">
                    <label for="name">Name</label>
                    <input type="text" id="name" placeholder="Enter your name">
                </div>

                <!-- 닉네임 입력 -->
                <div class="form-group">
                    <label for="nickname">닉네임 입력</label>
                    <div class="inline-group">
                        <input  class="inputs" type="text" id="nickname" placeholder="Enter nickname">
                        <button type="button">중복확인</button>
                    </div>
                </div>

                <!-- <hr> -->

                <!-- 이메일 입력 -->
                <div class="form-group">
                    <label for="email">Email</label>
                    <div class="inline-group">
                        <input type="text" id="emailID" placeholder="Email ID">
                        <span>@</span>
                        <select id="emailDomain">
                            <option value="gmail.com">gmail.com</option>
                            <option value="naver.com">naver.com</option>
                            <option value="daum.net">daum.net</option>
                            <option value="custom">직접 입력</option>
                        </select>
                        <input type="text" id="customEmail" placeholder="Enter domain" style="display: none;">
                    </div>
                </div>

               
                <!-- 전화번호 입력 -->
                <div class="form-group">
                    <label for="phone">Phone Number</label>
                    <input type="text" id="phone" placeholder="010-0000-0000">
                </div>

                <!-- 생년월일 입력 -->
                <div class="form-group">
                    <label for="birth">생년월일</label>
                    <div class="inline-group">
                        <select id="birthYear"></select>
                        <select id="birthMonth"></select>
                        <select id="birthDay"></select>
                    </div>
                    <!-- 가입 버튼 -->
                    <button type="submit" class="register-btn">가입하기</button>
                </section>

            </form>
        </div>
    </div>

    <script>
    // 비밀번호 일치 확인
    document.addEventListener("DOMContentLoaded", function () {
    const password = document.getElementById("password");
    const confirmPassword = document.getElementById("confirmPassword");
    const passwordMessage = document.getElementById("passwordMessage");

    function checkPasswordMatch() {
        if (password.value && confirmPassword.value) {
            if (password.value === confirmPassword.value) {
                passwordMessage.textContent = "비밀번호가 일치합니다";
                passwordMessage.className = "message success";
                passwordMessage.style.color = "green";
            } else {
                passwordMessage.textContent = "비밀번호가 일치하지 않습니다";
                passwordMessage.className = "message error";
                passwordMessage.style.color = "red";
            }
        } else {
            passwordMessage.textContent = "";
        }
    }

    password.addEventListener("keyup", checkPasswordMatch);
    confirmPassword.addEventListener("keyup", checkPasswordMatch);
});


        // 이메일 도메인 선택 변경 시 입력 필드 표시/숨김
        document.getElementById("emailDomain").addEventListener("change", function() {
            let customEmailField = document.getElementById("customEmail");
            if (this.value === "custom") {
                customEmailField.style.display = "block";
            } else {
                customEmailField.style.display = "none";
            }
        });

          // 현재 연도를 기준으로 100년 전까지의 연도를 생성
            const yearSelect = document.getElementById("birthYear");
            const currentYear = new Date().getFullYear();
            let yearOptions = '<option value="">년도</option>';
            for (let i = currentYear; i >= currentYear - 100; i--) {
                yearOptions += `<option value="${i}">${i}</option>`;
            }
            yearSelect.innerHTML = yearOptions;

            // 1월~12월 생성
            const monthSelect = document.getElementById("birthMonth");
            let monthOptions = '<option value="">월</option>';
            for (let i = 1; i <= 12; i++) {
                monthOptions += `<option value="${String(i).padStart(2, '0')}">${i}</option>`;
            }
            monthSelect.innerHTML = monthOptions;

            // 일(1~31일) 동적 생성 (월별 일 수 반영)
            const daySelect = document.getElementById("birthDay");
            function updateDays() {
                let selectedYear = parseInt(yearSelect.value);
                let selectedMonth = parseInt(monthSelect.value);
                let daysInMonth = new Date(selectedYear || 2000, selectedMonth, 0).getDate(); // 월별 마지막 날짜 계산

                let dayOptions = '<option value="">일</option>';
                for (let i = 1; i <= daysInMonth; i++) {
                    dayOptions += `<option value="${String(i).padStart(2, '0')}">${i}</option>`;
                }
                daySelect.innerHTML = dayOptions;
            }

            // 월 선택 시 해당 월의 최대 일수 반영
            monthSelect.addEventListener("change", updateDays);
            yearSelect.addEventListener("change", updateDays);


    // 유효성 검사
    const signupForm = document.getElementById("signup-form");
    signupForm.onsubmit = function(event) {
        event.preventDefault(); // 폼 제출 방지
        
        if (!validateForm()) {
            return false;
        }

        // 모든 검사를 통과하면 폼 제출
        signupForm.submit();
    };
    
    function validateForm() {
    const userid = document.getElementById("userid").value.trim();
    const password = document.getElementById("password").value.trim();
    const confirmPassword = document.getElementById("confirmPassword").value.trim();
    const name = document.getElementById("name").value.trim();
    const nickname = document.getElementById("nickname").value;
    const emailID = document.getElementById("emailID").value;
    const emailDomain = document.getElementById("emailDomain").value;
    const customEmail = document.getElementById("customEmail").value;
    const phone = document.getElementById("phone").value.trim();
    const email = emailDomain === "custom" ? `${emailID}@${customEmail}` : `${emailID}@${emailDomain}`;

    if (!userid) {
        alert("ID는 필수 입력 사항입니다.");
        return false;
    }
    if (!password || !confirmPassword) {
        alert("패스워드는 필수 입력 사항입니다.");
        return false;
    }
    if (password !== confirmPassword) {
        alert("패스워드가 일치하지 않습니다.");
        return false;
    }
    if (!name) {
        alert("이름은 필수 입력 사항입니다.");
        return false;
    }
    if (!nickname) {
        alert("닉네임은 필수 입력 사항입니다.");
        return false;
    }
    if (!email) {
        alert("이메일은 필수 입력 사항입니다.");
        return false;
    }
    if (!phone) {
        alert("전화번호는 필수 입력 사항입니다.");
        return false;
    }

    const idRegex = /^[a-zA-Z][a-zA-Z0-9]{5,14}$/;
    const pwRegex = /^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[!@#$%^&*]).{8,}$/;
    const nicknameRegex = /^[\w가-힣]{1,9}$/; // 닉네임 10자 미만
    const nameRegex = /^[가-힣]{2,5}$/;
    const phoneRegex = /^01[0|1|6|7|8|9][- ]?\d{3,4}[- ]?\d{4}$/;
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;  // 이메일 형식 체크

    if (!idRegex.test(userid)) {
        alert("ID는 6~15자의 영문 또는 숫자 조합이어야 합니다.");
        return false;
    }

    if (!pwRegex.test(password)) {
        alert("비밀번호는 대문자, 소문자, 숫자, 특수문자를 포함하여 8자 이상으로 입력해주세요.");
        return false;
    }

    if (!nameRegex.test(name)) {
        alert("이름은 한글 2~5자로 입력해주세요.");
        return false;
    }

    if (!nicknameRegex.test(nickname)) {
        alert("닉네임은 한글 10자 미만으로 입력해주세요.");
        return false;
    }

    if (!emailRegex.test(email)) {
        alert("이메일 형식을 확인해주세요.");
        return false;
    }

    if (!phoneRegex.test(phone)) {
        alert("전화번호 형식을 확인해주세요. 예: 010-1234-5678");
        return false;
    }

    alert("회원가입에 성공하였습니다.");
    return true;
}

        
    </script>
</body>
</html>