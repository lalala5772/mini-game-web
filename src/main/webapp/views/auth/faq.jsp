<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>
<link rel="stylesheet" href="/assets/css/layout.css">
<link rel="stylesheet" href="/assets/css/reset.css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css">

<!-- ✅ jQuery -->
<script src="https://code.jquery.com/jquery-3.7.1.js"
	integrity="sha256-eKhayi8LEQwp4NKxN+CfCh+3qOVUtJn3QNZ0TciWLP4="
	crossorigin="anonymous"></script>

<!-- ✅ Bootstrap CSS -->
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">

<!-- ✅ Bootstrap JS (Bundle - includes Popper) -->
<script
	src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

</head>

<style>
html, body {
	height: 100%;
	margin: 0;
	display: flex;
	flex-direction: column;
}

/* main이 남는 공간을 차지하도록 설정 */
main {
	position: absolute;
	flex: 1;
	width: 90%;
	top: 120px;
	left: 90px;
}

/* CSS 커스텀 속성 정의 */
:root { -
	-color-black: #000 !important; -
	-color-gray: #868789 !important; -
	-color-white: #fff !important; -
	-color-primary: #7D3CCC !important; -
	-color-secondary: #FF4F80 !important;
}

/* ✅ title을 가운데 정렬 */
.title {
	display: flex;
	justify-content: center; /* 가로 가운데 정렬 */
	align-items: center; /* 세로 가운데 정렬 */
	font-size: 24px; /* 글자 크기 조절 (원하는 크기로 변경 가능) */
	font-weight: bold; /* 글자 굵게 */
	height: 60px; /* 높이 설정 (조정 가능) */
}

.nav-link {
	color: white !important;
	margin-bottom: 0 !important;
}

ul.nav-list {
	display: flex;
	gap: 2rem;
	list-style: none;
	padding-bottom:0!important;
	margin-bottom:0!important;
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
	color: var(--color-white)!important;
}

.signup-button {
	background-color: var(--color-primary)!important;
	color: var(--color-white)!important;
	padding: 0.8rem 1.5rem!important;
	border-radius: 5px!important;
	text-decoration: none!important;
	transition: opacity 0.3s!important;
}

</style>


<body>
	<%@ include file="/includes/header.jsp"%>

	<main>
		<div class="title">자주묻는 질문</div>
		<div class="accordion" id="accordionExample">
			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseOne"
						aria-expanded="true" aria-controls="collapseOne">
						Accordion Item #1</button>
				</h2>
				<div id="collapseOne" class="accordion-collapse collapse show"
					data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<strong><span>A.</span> This is the first item's
							accordion body.</strong> It is shown by default, until the collapse plugin
						adds the appropriate classes.
					</div>
				</div>
			</div>

			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseTwo"
						aria-expanded="false" aria-controls="collapseTwo">
						Accordion Item #2</button>
				</h2>
				<div id="collapseTwo" class="accordion-collapse collapse"
					data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<strong>This is the second item's accordion body.</strong> It is
						hidden by default, until the collapse plugin adds the appropriate
						classes.
					</div>
				</div>
			</div>

			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseThree"
						aria-expanded="false" aria-controls="collapseThree">
						Accordion Item #3</button>
				</h2>
				<div id="collapseThree" class="accordion-collapse collapse"
					data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<strong>This is the third item's accordion body.</strong> It is
						hidden by default, until the collapse plugin adds the appropriate
						classes.
					</div>
				</div>
			</div>

			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseFour"
						aria-expanded="false" aria-controls="collapseFour">
						Accordion Item #4</button>
				</h2>
				<div id="collapseFour" class="accordion-collapse collapse"
					data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<strong>This is the fourth item's accordion body.</strong> It is
						hidden by default, until the collapse plugin adds the appropriate
						classes.
					</div>
				</div>
			</div>

			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseFive"
						aria-expanded="false" aria-controls="collapseFive">
						Accordion Item #5</button>
				</h2>
				<div id="collapseFive" class="accordion-collapse collapse"
					data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<strong>This is the fifth item's accordion body.</strong> It is
						hidden by default, until the collapse plugin adds the appropriate
						classes.
					</div>
				</div>
			</div>

			<div class="accordion-item">
				<h2 class="accordion-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#collapseSix"
						aria-expanded="false" aria-controls="collapseSix">
						Accordion Item #6</button>
				</h2>
				<div id="collapseSix" class="accordion-collapse collapse"
					data-bs-parent="#accordionExample">
					<div class="accordion-body">
						<strong>This is the sixth item's accordion body.</strong> It is
						hidden by default, until the collapse plugin adds the appropriate
						classes.
					</div>
				</div>
			</div>
		</div>
	</main>

	<%@ include file="/includes/footer.jsp"%>
</body>
</html>