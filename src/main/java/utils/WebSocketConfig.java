package utils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.websocket.DeploymentException;
import javax.websocket.server.ServerContainer;

import socket.ChatWebSocket;

@WebListener
public class WebSocketConfig implements ServletContextListener {
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        ServerContainer serverContainer = 
            (ServerContainer) sce.getServletContext().getAttribute("javax.websocket.server.ServerContainer");
        
        if (serverContainer != null) {
            try {
                // ChatWebSocket 클래스를 WebSocket 엔드포인트로 등록
                serverContainer.addEndpoint(ChatWebSocket.class);
                System.out.println("✅ WebSocket 엔드포인트 등록 성공: /chat");
            } catch (DeploymentException e) {
                throw new RuntimeException("❌ WebSocket 엔드포인트 등록 실패", e);
            }
        } else {
            System.err.println("❌ WebSocket ServerContainer를 찾을 수 없습니다.");
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("WebSocketConfig 종료");
    }
}
