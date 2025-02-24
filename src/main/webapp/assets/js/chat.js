
document.addEventListener("DOMContentLoaded", function () {
    let chatSocket = null;
    const chatMessages = document.getElementById("chatMessages");
    const messageInput = document.getElementById("messageInput");
    const sendButton = document.getElementById("sendButton");

	console.log("isLoggedIn:", isLoggedIn);
	console.log("senderID:", senderID);
	console.log("senderName:", senderName);

	if (!isLoggedIn || senderID === "") {
	    document.getElementById("messageInput").disabled = true;
	    document.getElementById("sendButton").disabled = true;
	} else {
	    connectWebSocket();
	}

    if (!isLoggedIn) {
        messageInput.disabled = true;
        sendButton.disabled = true;
        return;
    }

    function connectWebSocket() {
        chatSocket = new WebSocket("ws://localhost:80/chat");

        chatSocket.onopen = function () {
            console.log("✅ WebSocket 연결 성공");
        };

        chatSocket.onmessage = function (event) {
            const newMsg = document.createElement("div");
            newMsg.textContent = event.data;
            chatMessages.appendChild(newMsg);
            chatMessages.scrollTop = chatMessages.scrollHeight;
        };

        chatSocket.onerror = function () {
            console.log("⚠️ WebSocket 연결 오류");
        };

        chatSocket.onclose = function () {
            console.log("❌ WebSocket 연결 종료");
        };
    }

    sendButton.addEventListener("click", function () {
        if (messageInput.value.trim() !== "" && chatSocket.readyState === WebSocket.OPEN) {
            chatSocket.send(messageInput.value);
            messageInput.value = "";
        }
    });

    messageInput.addEventListener("keypress", function (event) {
        if (event.key === "Enter") {
            sendButton.click();
        }
    });

    connectWebSocket();
});
