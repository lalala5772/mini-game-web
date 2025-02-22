<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
        <!DOCTYPE html>
        <html>

        <head>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <meta name="description" content="TechX Games - 최고의 온라인 게임 포털. 다양한 게임을 무료로 즐겨보세요.">
            <meta name="keywords" content="온라인게임, 웹게임, 무료게임, TechX, 게임포털">
            <meta name="author" content="TechX Games">
            <meta property="og:title" content="TechX Games - 최고의 게임 포털">
            <meta property="og:description" content="다양한 온라인 게임을 무료로 즐겨보세요">
            <meta property="og:type" content="website">
            <title>TechX Games - 최고의 온라인 게임 포털</title>
            <!-- font-awesome -->
            <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">
            <!-- 브라우저마다 기본적으로 적용되는 스타일이 다르기 때문에, 이를 제거해서 일관된 스타일을 유지하기 위해 추가하는 CSS 파일 -->
            <link rel="stylesheet" href="/assets/css/reset.css">
            <!-- 헤더 & 푸터 css  -->
            <link rel="stylesheet" href="/assets/css/layout.css">
            <!-- 커스텀 css -->
            <link rel="stylesheet" href="/assets/css/main.css">
            <link rel="stylesheet" href="/assets/css/all-games.css">

            <!-- GSAP -->
            <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/gsap.min.js"></script>
            <script src="https://cdnjs.cloudflare.com/ajax/libs/gsap/3.12.2/ScrollTrigger.min.js"></script>
            <!-- jQuery CDN  -->
            <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
            <script>
	            function goToPage(url) {
	                window.location.href = url;
	            }
            </script>

        </head>

        <body>
			        <!-- 공통 Header -->
			<%@ include file="/includes/header.jsp" %>
			
			<!-- 메인 화면 ::s-->
			<main>
			    <!-- 인트로 ::s  -->
			    <section class="intro-section">
			        <div class="title-container">
			            <h1>CONNECTING THE REAL<br>TO GAME-WORLD</h1>
			        </div>
			        <div class="content-container">
			            <div class="image-container">
			                <img src="https://picsum.photos/800/600" alt="Office collaboration">
			            </div>
			            <div class="right-container">
			                <%
			                if (loginUser != null) {
			                %>
			                    안녕하세요, <%= loginUser.getNickname() %>님!
			                <%
			                } else {
			                %>
			                    <div class="login-box">
			                        <button class="login-button" onclick="goToPage('views/auth/login.jsp')">ID 로그인</button>
			                        <div class="login-options">
			                            <span>OR</span>
			                            <div class="login-links">
			                                <a href="views/auth/findmyid.jsp">아이디 찾기</a>
			                                <a href="views/auth/findmypw.jsp">비밀번호 찾기</a>
			                                <a href="views/auth/signup.jsp">회원가입</a>
			                            </div>
			                        </div>
			                    </div>
			                <%
			                }
			                %>
			               <div class="chat-interface">
                                    <div class="chat-messages">
                                        <div class="message">사용자 1: 어떻구 저쩌구?</div>
                                        <div class="message">사용자 2: 어쩌구 저쩌구~</div>
                                        <div class="message">사용자 2: 어쩌구 저쩌구~</div>
                                    </div>
                                    <div class="message-input">
                                        <input type="text" placeholder="Message">
                                        <button style="background: none; border: none; cursor: pointer;">
                                            <i class="fa-regular fa-paper-plane"
                                                style="color: var(--color-primary);"></i>
                                        </button>
                                    </div>
                                </div>
			            </div>
			        </div>
			    </section>
			    <!-- 인트로 ::e  -->
        
                    <!-- Text Scale ::s -->
                    <section class="first-section">
                        <div class="vertical-line"></div>
                        <div class="quote">
                            CREATE ALL THE THINGS<br>
                            THAT WE IMAGINE
                        </div>
                    </section>

                    <section class="techx-section">
                        <canvas id="particle-canvas"></canvas>
                        <div class="content-wrapper">
                            <div class="techx-text">TECH X</div>
                            <div class="description">
                                <h2>TECH X는 게임 개발 팀입니다</h2>
                                <p>유저 경험을 최우선으로 고려하여,<br>누구나 쉽고 재밌게 플레이할 수 있는 게임을 만들어 나갑니다.</p>
                            </div>
                        </div>
                    </section>
                    <!-- Text Scale ::e -->

                    <!-- 인기게임 ::s -->
                    <section class="popular-section">
                        <div>
                            <div class="category">인기 게임</div>
                            <h1 class="title">TECH X의 인기게임을 소개합니다</h1>
                        </div>

                        <div class="games-container" id="gameList">
                        </div>

                        <div class="games-container" style="display: none;">
                            <div class="game-card">
                                <div class="game-content"
                                    style="background-image: url('https://picsum.photos/1200/800')">
                                    <div class="game-type">리듬게임</div>
                                    <h2 class="game-title">Rhythm Game</h2>
                                    <div class="game-tags">
                                        <span class="tag">#리듬게임</span>
                                        <span class="tag">#음악게임</span>
                                        <span class="tag">#아케이드</span>
                                    </div>
                                    <div class="game-description">
                                        <p>사용자가 음악에 맞춰 떨어지는 블럭을 간격에 맞춘다.</p>
                                        <ul>
                                            <li>음악에 맞춰 위에서 아래로 네모난 직사각형의 블록 4개가 떨어진다.</li>
                                            <li>사용자는 S,D,J,K 키를 이용하여 떨어지는 블록에 맞춰 키를 눌러야한다.</li>
                                            <li>정확히 맞춘 개수에 따라서 점수가 측정된다.</li>
                                        </ul>
                                        <a href="#" class="play-button">게임하기</a>
                                    </div>
                                </div>
                            </div>

                            <div class="game-card">
                                <div class="game-content"
                                    style="background-image: url('https://picsum.photos/1200/800')">
                                    <div class="game-type">길건너기 게임</div>
                                    <h2 class="game-title">Cross Road</h2>
                                    <div class="game-tags">
                                        <span class="tag">#아케이드</span>
                                        <span class="tag">#캐주얼</span>
                                        <span class="tag">#액션</span>
                                    </div>
                                    <div class="game-description">
                                        <p>사용자는 게임 내에서 캐릭터를 조작하여 도로 위의 장애물을 피해 길을 건넌다.</p>
                                        <ul>
                                            <li>사용자는 방향키를 이용해 캐릭터를 이동시키며 장애물을 피한다.</li>
                                            <li>일정 시간이 지나거나 장애물에 충돌하면 게임 오버가 되며, 플레이한 시간이 점수로 계산된다.</li>
                                            <li>게임 오버 후, 사용자는 최고 점수를 확인하고 게임을 다시 시작할 수 있다.</li>
                                        </ul>
                                        <a href="#" class="play-button">게임하기</a>
                                    </div>
                                </div>
                            </div>

                            <div class="game-card">
                                <div class="game-content"
                                    style="background-image: url('https://picsum.photos/1200/800')">
                                    <div class="game-type">고기굽기 게임</div>
                                    <h2 class="game-title">Barbecue Game</h2>
                                    <div class="game-tags">
                                        <span class="tag">#액션게임</span>
                                        <span class="tag">#타이밍게임</span>
                                        <span class="tag">#캐주얼게임</span>
                                    </div>
                                    <div class="game-description">
                                        <p>플레이어는 제한 시간 안에 불판 위에서 고기를 앞뒤로 구워 적절한 타이밍에 접시에 옮겨 담아야 합니다.</p>
                                        <ul>
                                            <li>플레이어는 제한 시간 안에 고기를 알맞게 구워 접시에 담아야 합니다.</li>
                                            <li>고기는 앞면과 뒷면을 번갈아 가며 구워야 합니다.</li>
                                            <li>고기가 너무 익거나 덜 익으면 실패합니다.</li>
                                        </ul>
                                        <a href="#" class="play-button">게임하기</a>
                                    </div>
                                </div>
                            </div>

                            <div class="game-card">
                                <div class="game-content"
                                    style="background-image: url('https://picsum.photos/1200/800')">
                                    <div class="game-type">참참참 게임</div>
                                    <h2 class="game-title">참참참!</h2>
                                    <div class="game-tags">
                                        <span class="tag">#반응속도</span>
                                        <span class="tag">#두뇌게임</span>
                                        <span class="tag">#캐주얼게임</span>
                                    </div>
                                    <div class="game-description">
                                        <p>플레이어는 카메라를 응시하고 타이머에 맞춰 고개를 좌/우로 움직여 승패를 결정합니다.</p>
                                        <ul>
                                            <li>카메라 이용 동의 후 게임 시작</li>
                                            <li>타이머에 맞춰 고개 좌/우 움직임</li>
                                            <li>총 3번 플레이 후 승리 횟수에 따라 점수 획득</li>
                                        </ul>
                                        <a href="#" class="play-button">게임하기</a>
                                    </div>
                                </div>
                            </div>

                            <div class="game-card">
                                <div class="game-content"
                                    style="background-image: url('https://picsum.photos/1200/800')">
                                    <div class="game-type">좀비 디펜스 게임</div>
                                    <h2 class="game-title">Zombie Crusher</h2>
                                    <div class="game-tags">
                                        <span class="tag">#전략게임</span>
                                        <span class="tag">#디펜스게임</span>
                                        <span class="tag">#시뮬레이션게임</span>
                                    </div>
                                    <div class="game-description">
                                        <p>당신은 Zombie Crusher라는 좀비 디펜스 게임의 세계에 들어왔습니다. 이 게임에서는 끊임없이 몰려오는 좀비 무리들을 막아내야
                                            합니다. 당신의 목표는 모든 좀비들을 물리치고 도시를 구하는 것입니다.</p>
                                        <ul>
                                            <li>게임 시작 시, 초기 자원으로 방어 유닛을 생산할 수 있습니다.</li>
                                            <li>각 스테이지마다 다양한 유형의 좀비들이 등장하며, 이를 막기 위해 적절한 전략을 세워야 합니다.</li>
                                            <li>좀비 유닛을 처치할 때마다 점수를 획득하며, 높은 점수를 얻을수록 더 강력한 무기와 방어 시설을 건설할 수 있습니다.</li>
                                            <li>하지만, 당신의 생명력은 한정되어 있으며, 생명력이 모두 소진되면 게임이 종료됩니다.</li>
                                        </ul>
                                        <a href="#" class="play-button">게임하기</a>
                                    </div>
                                </div>
                            </div>

                            <div class="game-card">
                                <div class="game-content"
                                    style="background-image: url('https://picsum.photos/1200/800')">
                                    <div class="game-type">스네이크 게임</div>
                                    <h2 class="game-title">Snake Game</h2>
                                    <div class="game-tags">
                                        <span class="tag">#아케이드게임</span>
                                        <span class="tag">#스네이크게임</span>
                                        <span class="tag">#캐주얼게임</span>
                                    </div>
                                    <div class="game-description">
                                        <p>플레이어는 벽에 부딪히지 않고 빨간 네모를 먹으며 뱀의 길이를 늘려나갑니다.</p>
                                        <ul>
                                            <li>랜덤 위치에 빨간 네모 생성</li>
                                            <li>방향키로 뱀 이동</li>
                                            <li>빨간 네모 획득 시 뱀 길이 증가 및 점수 획득</li>
                                            <li>벽에 충돌 시 게임 종료</li>
                                        </ul>
                                        <a href="#" class="play-button">게임하기</a>
                                    </div>
                                </div>
                            </div>


                        </div>
                    </section>
                    <!-- 인기게임 ::e -->


                    <!-- 공통 전체게임 -->
                    <%@ include file="../../includes/all-games.jsp" %>
                </main>
                <!-- 메인 화면 ::e-->

                <!-- 공통 Footer -->
                <%@ include file="/includes/footer.jsp" %>
                
             <%--    <!-- 채팅 기능 구현 -->
                <% if (loginUser != null && loginUser.getNickname() != null) { %>
    <script>
        let ws;

        function createWebSocket() {
            ws = new WebSocket("ws://localhost/chat");

            // WebSocket 메시지 수신 처리
            ws.onmessage = function(event) {
                let chatMessages = document.getElementById("chatMessages");
                let messageDiv = document.createElement("div");
                messageDiv.classList.add("message");
                messageDiv.textContent = event.data;
                chatMessages.appendChild(messageDiv);
            };

            // 연결이 닫히면 재연결 시도
            ws.onclose = function() {
                console.log("WebSocket closed. Attempting to reconnect...");
                setTimeout(createWebSocket, 5000);  // 5초 후 재연결 시도
            };

            // WebSocket 오류 처리
            ws.onerror = function() {
                console.log("WebSocket error. Attempting to reconnect...");
                setTimeout(createWebSocket, 5000);  // 5초 후 재연결 시도
            };
        }

        // WebSocket 연결 상태 확인 및 재연결 처리
        function reconnectWebSocket() {
            if (ws.readyState === WebSocket.CLOSED || ws.readyState === WebSocket.CLOSING) {
                console.log("Reconnecting...");
                createWebSocket();  // 새 WebSocket 연결 시도
            }
        }

        // 메시지 전송 처리
        document.getElementById("sendButton").addEventListener("click", function() {
            let messageInput = document.getElementById("messageInput");
            if (messageInput.value.trim() !== "") {
                ws.send(messageInput.value);
                messageInput.value = "";
            }
        });

        // Enter 키로 메시지 전송
        document.getElementById("messageInput").addEventListener("keypress", function(event) {
            if (event.key === "Enter") {
                document.getElementById("sendButton").click();
            }
        });

        // 처음 WebSocket 연결 시도
        createWebSocket();
    </script>
<% } %>
 --%>

<%-- <script>
let chatSocket = null;
let retryCount = 0;
const maxRetry = 5;
const retryDelay = 2000; // 2초

// 로그인한 유저 정보 확인 (JSP에서 전달)
let isLoggedIn = <%= (loginUser != null) ? "true" : "false" %>;
let senderID = <%= (loginUser != null) ? loginUser.getId() : "null" %>;
let senderName = "<%= (loginUser != null) ? loginUser.getNickname() : "" %>";

const messageInput = document.getElementById("messageInput");
const sendButton = document.getElementById("sendButton");
const chatRoom = document.getElementById("chatMessages");

// 비로그인 유저는 채팅 입력 비활성화
if (!isLoggedIn || senderID === "null") {
    messageInput.disabled = true;
    sendButton.disabled = true;
} else {
    connectWebSocket(); // 로그인한 경우 WebSocket 연결
}

// ✅ WebSocket 연결 함수
function connectWebSocket() {
    chatSocket = new WebSocket('ws://127.0.0.1:8000/ws/chat/public/');

    chatSocket.onopen = function () {
        console.log('✅ WebSocket 연결 성공');
        retryCount = 0; // 재연결 카운트 초기화
    };

    chatSocket.onerror = function () {
        if (retryCount < maxRetry) {
            setTimeout(() => {
                console.log(`⚠️ 연결 실패. ${retryCount + 1}번째 재연결 시도 중...`);
                retryCount++;
                connectWebSocket();
            }, retryDelay);
        } else {
            console.log('❌ WebSocket 연결 실패. 잠시 후 다시 시도해주세요.');
        }
    };

    chatSocket.onmessage = function (e) {
        const data = JSON.parse(e.data);
        const opponentName = document.createElement('div');
        const newMsg = document.createElement('div');
        newMsg.style.color = 'black';

        if (Number(data.sender_id) === Number(senderID)) {
            newMsg.textContent = data.message;
            newMsg.setAttribute('class', 'myChat');
            chatRoom.appendChild(newMsg);
            chatRoom.scrollTop = chatRoom.scrollHeight;
        } else {
            opponentName.textContent = data.sender_name;
            opponentName.style.color = 'black';
            opponentName.style.marginBottom = '-10px';
            newMsg.textContent = data.message;
            newMsg.setAttribute('class', 'friendChat');
            chatRoom.appendChild(opponentName);
            chatRoom.appendChild(newMsg);
            chatRoom.scrollTop = chatRoom.scrollHeight;
        }
    };
}

// ✅ 메시지 전송
sendButton.addEventListener("click", function () {
    if (messageInput.value.trim() !== "" && chatSocket.readyState === WebSocket.OPEN) {
        chatSocket.send(JSON.stringify({
            sender_id: senderID,
            sender_name: senderName,
            message: messageInput.value,
        }));
        messageInput.value = "";
    }
});

// ✅ 엔터 키 입력 시 전송
messageInput.addEventListener("keypress", function (event) {
    if (event.key === "Enter") {
        sendButton.click();
    }
});

</script> --%>

                    <script src="/assets/js/main.js"></script>
                    <script>
                        $(function () {
                            //인기 게임 목록
                            $.ajax({
                                url: "/popular.record", // 인기 게임 목록을 가져오는 URL
                                dataType: "json" // JSON 형식으로 응답 받음
                            }).done(function (data) { // success -> done 으로 변경
                                if (data && data.length > 0) { // 데이터가 있는지 확인
                                    $("#gameList").empty(); // 기존 내용을 비우고 시작

                                    // 게임 목록을 순서대로 나열
                                    for (let i = 0; i < 3; i++) {
                                        let game = data[i];
                                        let topGame = getGameInfo(game.gameName); // 함수를 사용하여 게임 카드 생성
                                        console.log(game);

                                        // 화면에 추가
                                        $("#gameList").append(topGame);
                                    }
                                } else {
                                    // 데이터가 없을 경우
                                    $("#gameList").html("<p>인기 게임이 없습니다.</p>");
                                }
                            }).fail(function (error) { // 에러 발생 시
                                console.error("인기 게임 목록을 불러오는 중 오류 발생:", error);
                                $("#gameList").html("<p>인기 게임 목록을 불러오는 중 오류가 발생했습니다.</p>");
                            });
                        });

                        function getGameInfo(gameName) {
                            let gameCard = $("<div>").addClass("game-card");
                            let gameContent = $("<div>").addClass("game-content").css("background-image", "url('https://picsum.photos/1200/800')"); // 배경 이미지 URL 수정 필요
                            let gameType = $("<div>").addClass("game-type"); // 게임 종류 데이터 추가 필요
                            let gameTitle = $("<h2>").addClass("game-title");
                            let gameTags = $("<div>").addClass("game-tags");
                            let gameDescription = $("<div>").addClass("game-description");

                            let descriptionText, descriptionList, playButton;

                            if (gameName === "Rhythm Game") {
                                gameType.html("리듬게임");
                                gameTitle.html("Rhythm Game");

                                // 태그 추가 (예시)
                                let tags = ["#리듬게임", "#음악게임", "#아케이드"];
                                tags.forEach(tag => {
                                    let tagSpan = $("<span>").addClass("tag").text(tag);
                                    gameTags.append(tagSpan);
                                });

                                // 설명 추가 (예시)
                                descriptionText = $("<p>").text("사용자가 음악에 맞춰 떨어지는 블럭을 간격에 맞춘다.");
                                descriptionList = $("<ul>");
                                descriptionItems = ["<li>음악에 맞춰 위에서 아래로 네모난 직사각형의 블록 4개가 떨어진다.</li>", "<li>사용자는 S,D,J,K 키를 이용하여 떨어지는 블록에 맞춰 키를 눌러야한다.</li>", "<li>정확히 맞춘 개수에 따라서 점수가 측정된다.</li>"];
                                descriptionItems.forEach(item => {
                                    descriptionList.append(item);
                                });

                                let playButton = $("<a>").addClass("play-button").text("게임하기").attr("href", "#"); // 게임 URL 수정 필요
                                gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가
                            } else if (gameName === "크로스 로드") {
                                gameType.html("길건너기 게임");
                                gameTitle.html("Cross Road");

                                // 태그 추가 (예시)
                                let tags = ["#아케이드", "#캐주얼", "#액션"];
                                tags.forEach(tag => {
                                    let tagSpan = $("<span>").addClass("tag").text(tag);
                                    gameTags.append(tagSpan);
                                });

                                // 설명 추가 (예시)
                                descriptionText = $("<p>").text("사용자는 게임 내에서 캐릭터를 조작하여 도로 위의 장애물을 피해 길을 건넌다.");
                                descriptionList = $("<ul>");
                                descriptionItems = ["<li>사용자는 방향키를 이용해 캐릭터를 이동시키며 장애물을 피한다.</li><li>일정 시간이 지나거나 장애물에 충돌하면 게임 오버가 되며, 플레이한 시간이 점수로 계산된다.</li><li>게임 오버 후, 사용자는 최고 점수를 확인하고 게임을 다시 시작할 수 있다.</li>"];
                                descriptionItems.forEach(item => {
                                    descriptionList.append(item);
                                });

                                let playButton = $("<a>").addClass("play-button").text("게임하기").attr("href", "#"); // 게임 URL 수정 필요
                                gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가
                            } else if (gameName === "Barbecue_Game") {
                                gameType.html("고기굽기 게임");
                                gameTitle.html("Barbecue Game");

                                // 태그 추가 (예시)
                                let tags = ["#액션게임", "#타이밍게임", "#캐주얼게임"];
                                tags.forEach(tag => {
                                    let tagSpan = $("<span>").addClass("tag").text(tag);
                                    gameTags.append(tagSpan);
                                });

                                // 설명 추가 (예시)
                                descriptionText = $("<p>").text("플레이어는 제한 시간 안에 불판 위에서 고기를 앞뒤로 구워 적절한 타이밍에 접시에 옮겨 담아야 합니다.");
                                descriptionList = $("<ul>");
                                descriptionItems = ["<li>플레이어는 제한 시간 안에 고기를 알맞게 구워 접시에 담아야 합니다.</li><li>고기는 앞면과 뒷면을 번갈아 가며 구워야 합니다.</li><li>고기가 너무 익거나 덜 익으면 실패합니다.</li>"];
                                descriptionItems.forEach(item => {
                                    descriptionList.append(item);
                                });

                                let playButton = $("<a>").addClass("play-button").text("게임하기").attr("href", "#"); // 게임 URL 수정 필요
                                gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가
                            } else if (gameName === "참참참!") {
                                gameType.html("참참참 게임");
                                gameTitle.html("참참참!");

                                // 태그 추가 (예시)
                                let tags = ["#반응속도", "#두뇌게임", "#캐주얼게임"];
                                tags.forEach(tag => {
                                    let tagSpan = $("<span>").addClass("tag").text(tag);
                                    gameTags.append(tagSpan);
                                });

                                // 설명 추가 (예시)
                                descriptionText = $("<p>").text("플레이어는 카메라를 응시하고 타이머에 맞춰 고개를 좌/우로 움직여 승패를 결정합니다.");
                                descriptionList = $("<ul>");
                                descriptionItems = ["<li>카메라 이용 동의 후 게임 시작</li><li>타이머에 맞춰 고개 좌/우 움직임</li><li>총 3번 플레이 후 승리 횟수에 따라 점수 획득</li>"];
                                descriptionItems.forEach(item => {
                                    descriptionList.append(item);
                                });

                                let playButton = $("<a>").addClass("play-button").text("게임하기").attr("href", "#"); // 게임 URL 수정 필요
                                gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가

                            } else if (gameName === "Zombie_Crusher") {
                                gameType.html("좀비 디펜스 게임");
                                gameTitle.html("Zombie Crusher");

                                // 태그 추가 (예시)
                                let tags = ["#전략게임", "#디펜스게임", "#시뮬레이션게임"];
                                tags.forEach(tag => {
                                    let tagSpan = $("<span>").addClass("tag").text(tag);
                                    gameTags.append(tagSpan);
                                });

                                // 설명 추가 (예시)
                                descriptionText = $("<p>").text("당신은 Zombie Crusher라는 좀비 디펜스 게임의 세계에 들어왔습니다. 이 게임에서는 끊임없이 몰려오는 좀비 무리들을 막아내야 합니다. 당신의 목표는 모든 좀비들을 물리치고 도시를 구하는 것입니다.");
                                descriptionList = $("<ul>");
                                descriptionItems = ["<li>게임 시작 시, 초기 자원으로 방어 유닛을 생산할 수 있습니다.</li><li>각 스테이지마다 다양한 유형의 좀비들이 등장하며, 이를 막기 위해 적절한 전략을 세워야 합니다.</li><li>좀비 유닛을 처치할 때마다 점수를 획득하며, 높은 점수를 얻을수록 더 강력한 무기와 방어 시설을 건설할 수 있습니다.</li><li>하지만, 당신의 생명력은 한정되어 있으며, 생명력이 모두 소진되면 게임이 종료됩니다.</li>"];
                                descriptionItems.forEach(item => {
                                    descriptionList.append(item);
                                });

                                let playButton = $("<a>").addClass("play-button").text("게임하기").attr("href", "#"); // 게임 URL 수정 필요
                                gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가

                            } else if (gameName === "스네이크 게입") {
                                gameType.html("스네이크 게임");
                                gameTitle.html("Snake Game");

                                // 태그 추가 (예시)
                                let tags = ["#아케이드게임", "#스네이크게임", "#캐주얼게임"];
                                tags.forEach(tag => {
                                    let tagSpan = $("<span>").addClass("tag").text(tag);
                                    gameTags.append(tagSpan);
                                });

                                // 설명 추가 (예시)
                                descriptionText = $("<p>").text("플레이어는 벽에 부딪히지 않고 빨간 네모를 먹으며 뱀의 길이를 늘려나갑니다.");
                                descriptionList = $("<ul>");
                                descriptionItems = ["<li>랜덤 위치에 빨간 네모 생성</li><li>방향키로 뱀 이동</li><li>빨간 네모 획득 시 뱀 길이 증가 및 점수 획득</li><li>벽에 충돌 시 게임 종료</li>"];
                                descriptionItems.forEach(item => {
                                    descriptionList.append(item);
                                });

                                let playButton = $("<a>").addClass("play-button").text("게임하기").attr("href", "#"); // 게임 URL 수정 필요
                                gameDescription.append(descriptionText, descriptionList, playButton); // gameDescription에 요소 추가

                            }

                            gameContent.append(gameType, gameTitle, gameTags, gameDescription); // gameContent에 요소 추가
                            gameCard.append(gameContent); // gameCard에 요소 추가

                            return gameCard;
                        }
                    </script>
        </body>

        </html>