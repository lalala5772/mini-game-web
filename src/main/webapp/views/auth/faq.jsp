<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
	<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
		<!DOCTYPE html>
		<html>

		<head>
			<meta charset="UTF-8">
			<meta name="viewport" content="width=device-width, initial-scale=1.0">
			<title>TECH X - 고객센터 | 자주묻는 질문</title>
			<script src="https://code.jquery.com/jquery-3.7.1.js"
				integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>
			<link rel="stylesheet" href="/assets/css/layout.css">
			<link rel="stylesheet" href="/assets/css/reset.css">
			<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

			<!-- ✅ jQuery -->
			<script src="https://code.jquery.com/jquery-3.7.1.js"
				integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4=" crossorigin="anonymous"></script>

			<!-- ✅ Bootstrap CSS -->
			<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

			<!-- ✅ Bootstrap JS (Bundle - includes Popper) -->
			<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>


			<!-- 커스텀 css -->
			<link rel="stylesheet" href="/assets/css/faq.css">

		</head>

		<style>
			/* html, body {
	height: 100%;
	margin: 0;
	display: flex;
	flex-direction: column;
} */

			/* main이 남는 공간을 차지하도록 설정 */
			/* main {
	position: absolute;
	flex: 1;
	width: 90%;
	top: 120px;
	left: 90px;
} */

			/* CSS 커스텀 속성 정의 */
			:root {
				--color-black: #000 !important;
				--color-gray: #868789 !important;
				--color-white: #fff !important;
				--color-primary: #7D3CCC !important;
				--color-secondary: #FF4F80 !important;
			}

			.nav-link {
				color: white !important;
				margin-bottom: 0 !important;
			}

			ul.nav-list {
				display: flex;
				gap: 2rem;
				list-style: none;
				padding-bottom: 0 !important;
				margin-bottom: 0 !important;
			}

			.nav-link {
				color: var(--color-white);
				text-decoration: none;
				font-weight: 500;
				transition: color 0.3s;
			}

			.nav-link:hover {
				color: var(--color-primary) !important;
			}

			.nav-link .logo-img {
				line-height: 0;
			}

			.nav-link.signup-button:hover {
				color: var(--color-white) !important;
			}

			.signup-button {
				background-color: var(--color-primary) !important;
				color: var(--color-white) !important;
				padding: 0.8rem 1.5rem !important;
				border-radius: 5px !important;
				text-decoration: none !important;
				transition: opacity 0.3s !important;
			}
		</style>


		<body>
			<%@ include file="/includes/header.jsp" %>

				<main>
					<div class="title">자주묻는 질문</div>
					<div class="accordion" id="accordionExample">
						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button" type="button" data-bs-toggle="collapse"
									data-bs-target="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
									<span class="question-number">Q1.</span> <span class="faq-category">계정</span> 게임 계정은
									어떻게 생성하나요?
								</button>
							</h2>
							<div id="collapseOne" class="accordion-collapse collapse show"
								data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<div class="faq-content">
										<p><span class="answer-label">A.</span> 게임 계정 생성은 다음과 같은 방법으로 진행할 수 있습니다.</p>
										<p>1. 메인 페이지 우측 상단의 '회원가입' 버튼을 클릭합니다.</p>
										<p>2. 필수 정보(이메일, 비밀번호, 닉네임, 이름, 전화번호 이메일, 생년월일)를 입력합니다.</p>
										<p>3. 약관에 동의하신 후 가입을 완료합니다.</p>
										<p>계정 생성 후에는 바로 모든 게임을 이용하실 수 있습니다. 회원가입 관련 추가 문의사항은 고객센터로 연락해 주시기 바랍니다.</p>
									</div>
								</div>
							</div>
						</div>

						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
									data-bs-target="#collapseFour" aria-expanded="false" aria-controls="collapseFour">
									<span class="question-number">Q2.</span> <span class="faq-category">기술</span> 게임 실행
									시 오류가 발생합니다
								</button>
							</h2>
							<div id="collapseFour" class="accordion-collapse collapse"
								data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<div class="faq-content">
										<p><span class="answer-label">A.</span> 게임 실행 시 발생하는 오류 해결 방법은 다음과 같습니다.</p>
										<p>1. 브라우저 캐시 및 쿠키 삭제: 브라우저의 설정에서 캐시와 쿠키를 삭제한 후 다시 시도해 보세요.</p>
										<p>2. 브라우저 업데이트: 최신 버전의 크롬, 파이어폭스, 엣지 등의 브라우저를 사용하는 것이 권장됩니다.</p>
										<p>3. 인터넷 연결 확인: 안정적인 인터넷 연결이 필요합니다.</p>
										<p>4. 광고 차단 확장 프로그램 비활성화: 일부 확장 프로그램이 게임 실행을 방해할 수 있습니다.</p>
										<p>5. 다른 브라우저로 시도: 다른 브라우저에서 게임 실행을 시도해 보세요.</p>
										<p>위의 방법으로도 문제가 해결되지 않는 경우, 오류 메시지와 사용 중인 기기 정보를 포함하여 고객센터로 문의해 주시기 바랍니다.</p>
									</div>
								</div>
							</div>
						</div>

						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
									data-bs-target="#collapseSix" aria-expanded="false" aria-controls="collapseSix">
									<span class="question-number">Q3.</span> <span class="faq-category">계정</span> 비밀번호를
									잊어버렸습니다
								</button>
							</h2>
							<div id="collapseSix" class="accordion-collapse collapse"
								data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<div class="faq-content">
										<p><span class="answer-label">A.</span> 비밀번호를 잊어버리신 경우 다음 절차를 통해 재설정할 수 있습니다.
										</p>
										<p>1. 로그인 페이지에서 '비밀번호 찾기' 링크를 클릭합니다.</p>
										<p>2. 가입 시 등록한 이메일 주소를 입력합니다.</p>
										<p>3. 입력하신 이메일로 비밀번호 재설정 링크가 발송됩니다.</p>
										<p>4. 이메일에 포함된 링크를 클릭하여 새 비밀번호를 설정합니다.</p>
										<p>비밀번호 재설정 이메일이 수신되지 않는 경우, 스팸 폴더를 확인해 주세요. 그래도 이메일을 받지 못하셨다면, 다른 이메일 주소로 가입했을
											가능성이 있으니 다른 이메일로도 시도해 보시거나 고객센터로 문의해 주시기 바랍니다.</p>
									</div>
								</div>
							</div>
						</div>

						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
									data-bs-target="#collapseSeven" aria-expanded="false" aria-controls="collapseSeven">
									<span class="question-number">Q4.</span> <span class="faq-category">게임</span>
									Barbecue Game 게임 방법이 궁금합니다.
								</button>
							</h2>
							<div id="collapseSeven" class="accordion-collapse collapse"
								data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<div class="faq-content">
										<p><span class="answer-label">A.</span> Barbecue Game은 불판 위에서 펼쳐지는 짜릿한 고기 굽기
											게임입니다. 제한 시간 안에 완벽하게 익은 고기를 접시에 담아 최고의 점수를 기록하세요!</p>
										<p>[게임 방법]</p>
										<p>1. 고기를 마우스로 드래그하여 불판 위에 올려놓습니다.</p>
										<p>2. 고기를 적절한 타이밍에 뒤집어줍니다.</p>
										<p>3. 익은 고기는 오른쪽 접시에 놓습니다.</p>
										<p>4. 제한 시간 내에 최대한 많은 고기를 구워서 높은 점수를 얻는 것이 목표입니다.</p>
										<p>5. 고기를 태우면 점수가 깎이므로 주의해야 합니다.</p>
									</div>
								</div>
							</div>
						</div>

						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
									data-bs-target="#collapseEight" aria-expanded="false" aria-controls="collapseEight">
									<span class="question-number">Q5.</span> <span class="faq-category">게임</span> Cross
									Road 게임 방법이 궁금합니다.
								</button>
							</h2>
							<div id="collapseEight" class="accordion-collapse collapse"
								data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<div class="faq-content">
										<p><span class="answer-label">A.</span> 크로스 로드: 아슬아슬 도로 횡단 도전! 짜릿한 긴장감이 넘치는 아기
											고양이의 도로 위 모험! 제한 시간 안에 위험한 도로를 건너 안전 지대에 도착해 최고의 점수를 기록하세요!</p>
										<p>[게임 방법]</p>
										<p>1. 캐릭터를 방향키로 조작하여 도로에 진입합니다.</p>
										<p>2. 빠르게 움직이는 차량들 사이를 적절한 타이밍에 피해 지나갑니다.</p>
										<p>3. 중간 안전 지대에서 잠시 쉬어갈 수 있습니다.</p>
										<p>4. 제한 시간 내에 최대한 빨리 도로를 건너 높은 점수를 얻는 것이 목표입니다.</p>
									</div>
								</div>
							</div>
						</div>

						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
									data-bs-target="#collapseNine" aria-expanded="false" aria-controls="collapseNine">
									<span class="question-number">Q6.</span> <span class="faq-category">게임</span> 리듬 게임
									방법이 궁금합니다.
								</button>
							</h2>
							<div id="collapseNine" class="accordion-collapse collapse"
								data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<div class="faq-content">
										<p><span class="answer-label">A.</span> 노래와 리듬에 맞춰 블록을 파괴하는 게임입니다. 리듬의 승리자는
											당신입니다! 노래에 따라 블록을 맞춰 스코어를 획득하세요.</p>
										<p>[게임 방법]</p>
										<p>1. 키보드의 D,F,J,K 키를 눌러 블록을 파괴합니다.</p>
										<p>2. 하단 판정선에 정확히 블록이 일치해야 점수를 획득할 수 있습니다.</p>
										<p>3. 판정선에서 정확히 일치하지 않으면 Miss 카운트가 증가합니다.</p>
										<p>4. Miss 카운트가 5회가 될 경우 게임 오버입니다.</p>
										<p>5. 노래가 끝나고 Miss 카운트가 5회 미만일 때 성공입니다.</p>
									</div>
								</div>
							</div>
						</div>

						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
									data-bs-target="#collapseTen" aria-expanded="false" aria-controls="collapseTen">
									<span class="question-number">Q7.</span> <span class="faq-category">게임</span> 스네이크
									게임 방법이 궁금합니다.
								</button>
							</h2>
							<div id="collapseTen" class="accordion-collapse collapse"
								data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<div class="faq-content">
										<p><span class="answer-label">A.</span> 길어질수록 더 어려워진다! 클래식 스네이크 게임! 배고픈 뱀의 모험!
											먹이를 먹고 성장하세요!</p>
										<p>[게임 방법]</p>
										<p>1. 플레이어는 화살표 키(← ↑ → ↓)를 사용해 뱀을 이동시킵니다.</p>
										<p>2. 화면 내에 나타나는 먹이를 먹으면 점수가 올라가고 뱀의 길이가 길어집니다.</p>
										<p>3. 벽이나 자신의 몸에 부딪히면 게임이 종료됩니다.</p>
									</div>
								</div>
							</div>
						</div>

						<div class="accordion-item">
							<h2 class="accordion-header">
								<button class="accordion-button collapsed" type="button" data-bs-toggle="collapse"
									data-bs-target="#collapseEleven" aria-expanded="false"
									aria-controls="collapseEleven">
									<span class="question-number">Q8.</span> <span class="faq-category">게임</span> Zombie
									Crusher 게임 방법이 궁금합니다.
								</button>
							</h2>
							<div id="collapseEleven" class="accordion-collapse collapse"
								data-bs-parent="#accordionExample">
								<div class="accordion-body">
									<div class="faq-content">
										<p><span class="answer-label">A.</span> 몰려오는 좀비들, 준비된 건 돌멩이뿐! 최대한 많은 좀비를 돌멩이로
											물리치고 점수를 획득하세요.</p>
										<p>[게임 방법]</p>
										<p>1. 방향키를 이용하여 좀비들을 피합니다.</p>
										<p>2. 스페이스바를 눌러 돌멩이를 던집니다.</p>
										<p>3. 좀비에게 캐릭터가 닿으면 게임이 종료됩니다.</p>
										<p>4. 최대한 오래 살아남아 많은 좀비를 물리칩니다.</p>
									</div>
								</div>
							</div>
						</div>

					</div>
				</main>

				<%@ include file="/includes/footer.jsp" %>
		</body>

		</html>