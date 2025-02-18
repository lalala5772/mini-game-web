<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
    </head>

    <body>
        <!-- 공통 Header -->
        <%@ include file="./includes/header.jsp" %>

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
                        <div class="login-box">
                            <button class="login-button">ID 로그인</button>
                            <div class="login-options">
                                <span>OR</span>
                                <div class="login-links">
                                    <a href="#">아이디 찾기</a>
                                    <a href="#">비밀번호 찾기</a>
                                    <a href="#">회원가입</a>
                                </div>
                            </div>
                        </div>
                        <div class="chat-interface">
                            <div class="chat-messages">
                                <div class="message">사용자 1: 어떻구 저쩌구?</div>
                                <div class="message">사용자 2: 어쩌구 저쩌구~</div>
                                <div class="message">사용자 2: 어쩌구 저쩌구~</div>
                            </div>
                            <div class="message-input">
                                <input type="text" placeholder="Message">
                                <button style="background: none; border: none; cursor: pointer;">
                                    <i class="fa-regular fa-paper-plane" style="color: var(--color-primary);"></i>
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
        
                <div class="games-container">
                    <div class="game-card">
                        <div class="game-content" style="background-image: url('https://picsum.photos/1200/800')">
                            <div class="game-type">리듬게임</div>
                            <h2 class="game-title">비트 마스터</h2>
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
                        <div class="game-content" style="background-image: url('https://picsum.photos/1200/800')">
                            <div class="game-type">길건너기 게임</div>
                            <h2 class="game-title">크로스 로드</h2>
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
                        <div class="game-content" style="background-image: url('https://picsum.photos/1200/800')">
                            <div class="game-type">고기굽기 게임</div>
                            <h2 class="game-title">마스터 쉐프</h2>
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
                </div>
            </section>
            <!-- 인기게임 ::e -->
    
            <!-- 공통 전체게임 -->
            <div id="all-games-container"></div>
        </main>
        <!-- 메인 화면 ::e-->

        <!-- 공통 Footer -->
        <%@ include file="./includes/footer.jsp" %>

    
    <script src="/assets/js/main.js"></script>    
    </body>

    </html>