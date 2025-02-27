package games.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("*.games")
public class GamesController extends HttpServlet{

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();

		System.out.print("클라이언트 요청: " + cmd);

		//dao 인스턴스 생성

		try {
			//요청은 필요에 따라 추가/삭제 
			if (cmd.equals("/add.games")) {
				
			} else if (cmd.equals("/list.games")) {
				
			} else if (cmd.equals("/update.games")) {
				
			} else if (cmd.equals("/delete.games")) {
				
			} else if (cmd.equals("/barbecue.games")) {
				response.sendRedirect("/views/games/barbecue/barbecue-game.jsp");

			} else if (cmd.equals("/chamchamcham.games")) {
				response.sendRedirect("/views/games/chamchamcham/start-cham.jsp");

			}else if (cmd.equals("/crossRoad.games")) {
				response.sendRedirect("/views/games/crossRoad/cross-road.jsp");
	
			}else if (cmd.equals("/zombieCrusher.games")) {
				response.sendRedirect("/views/games/zombie_Crusher/main.jsp");

			}else if (cmd.equals("/rhythmGame.games")) {
				response.sendRedirect("/views/games/rhythmGame/rhythm.jsp");
				
			}else if (cmd.equals("/snakeGame.games")) {
				// response.sendRedirect("/views/games/??");
			}
		} catch(Exception e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}
