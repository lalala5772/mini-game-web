package socket;

import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;
import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import javax.servlet.http.HttpSession;
import javax.websocket.server.HandshakeRequest;
import javax.websocket.server.ServerEndpointConfig;
import auth.dto.UsersDTO;

@ServerEndpoint(value = "/chat", configurator = ChatServer.ChatConfigurator.class)
public class ChatServer {
    private static Set<Session> clients = new CopyOnWriteArraySet<>();

    @OnOpen
    public void onOpen(Session session, EndpointConfig config) {
    	System.out.println("✅ 새 WebSocket 연결됨: " + session.getId());
        clients.add(session);
        
        HttpSession httpSession = (HttpSession) config.getUserProperties().get("httpSession");
        if (httpSession == null || httpSession.getAttribute("loginUser") == null) {
            System.out.println("로그인하지 않은 유저의 접속 거부");
            try {
                session.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
            return;
        }

        UsersDTO loginUser = (UsersDTO) httpSession.getAttribute("loginUser");
        String nickname = loginUser.getNickname();
        session.getUserProperties().put("nickname", nickname);
        clients.add(session);

        broadcastMessage("📢 " + nickname + " 님이 입장하셨습니다.");
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        String sender = (String) session.getUserProperties().get("nickname");
        if (sender == null) return;

        broadcastMessage(sender + ": " + message);
    }

    @OnClose
    public void onClose(Session session) {
        clients.remove(session);
        String nickname = (String) session.getUserProperties().get("nickname");
        if (nickname != null) {
            broadcastMessage("📢 " + nickname + " 님이 퇴장하셨습니다.");
        }
    }

    private void broadcastMessage(String message) {
        for (Session client : clients) {
            try {
                client.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    public static class ChatConfigurator extends ServerEndpointConfig.Configurator {
        @Override
        public void modifyHandshake(ServerEndpointConfig config, HandshakeRequest request, HandshakeResponse response) {
            HttpSession httpSession = (HttpSession) request.getHttpSession();
            config.getUserProperties().put("httpSession", httpSession);
        }
    }
}
