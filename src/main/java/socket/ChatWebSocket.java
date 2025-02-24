package socket;

import javax.websocket.*;
import javax.websocket.server.ServerEndpoint;
import java.io.IOException;
import java.util.Set;
import java.util.concurrent.CopyOnWriteArraySet;

@ServerEndpoint("/chat")
public class ChatWebSocket {
    private static final Set<Session> sessions = new CopyOnWriteArraySet<>();

    @OnOpen
    public void onOpen(Session session) {
        sessions.add(session);
        System.out.println("✅ 클라이언트 접속: " + session.getId());
    }

    @OnMessage
    public void onMessage(String message, Session session) {
        System.out.println("📩 받은 메시지: " + message);
        
        // 모든 클라이언트에게 브로드캐스트
        for (Session s : sessions) {
            try {
                s.getBasicRemote().sendText(message);
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @OnClose
    public void onClose(Session session) {
        sessions.remove(session);
        System.out.println("❌ 클라이언트 연결 종료: " + session.getId());
    }

    @OnError
    public void onError(Session session, Throwable throwable) {
        System.err.println("⚠ WebSocket 오류 발생: " + throwable.getMessage());
    }
}
