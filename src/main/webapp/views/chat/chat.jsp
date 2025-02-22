<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="auth.dto.UsersDTO"%>
<%
    UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<title>실시간 채팅</title>
<script>
    const isLoggedIn = <%= (loginUser != null) ? "true" : "false" %>;
    const senderID = "<%= (loginUser != null) ? loginUser.getId() : "" %>";
    const senderName = "<%= (loginUser != null) ? loginUser.getNickname() : "" %>";
</script>
<script src="assets/js/chat.js"></script>

<style>
.chat-interface {
	width: 300px;
	border: 1px solid #ccc;
	padding: 10px;
}

.chat-messages {
	height: 200px;
	overflow-y: auto;
	border-bottom: 1px solid #ccc;
	padding: 5px;
}

.message-input {
	display: flex;
}

input {
	flex: 1;
	padding: 5px;
}

button {
	background-color: blue;
	color: white;
	border: none;
	padding: 5px;
	cursor: pointer;
}
</style>
</head>
<body>

	<div class="chat-interface">
		<div class="chat-messages" id="chatMessages"></div>
		<div class="message-input">
			<input type="text" id="messageInput" placeholder="Message">
			<button id="sendButton">📩</button>
		</div>
	</div>

</body>
</html>
