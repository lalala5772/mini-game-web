package games.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import games.dao.GameRecordDAO;
import games.dto.GameRankingDTO;
import games.dto.GameRecordDTO;
import games.dto.GameRecordRankingDTO;

@WebServlet("*.record")
public class GameRecordController extends HttpServlet{

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		Gson g = new Gson();
		String cmd = request.getRequestURI();

		System.out.print("클라이언트 요청: " + cmd);

		//dao 인스턴스 생성
		GameRecordDAO gameRecordDao = GameRecordDAO.getInstance();
		
		
		
		try {

			// 게임 record 등록
			if (cmd.equals("/add.record")) {
				String userId = request.getParameter("userId"); // userId 값으로 닉네임 받아야 함.
				int gameId = Integer.parseInt(request.getParameter("gameId"));
				int record = Integer.parseInt(request.getParameter("record"));
				
				gameRecordDao.insert(new GameRecordDTO(0, userId, gameId, record, null, null));
				
			} else if (cmd.equals("/list.record")) {
				// 처음 gameRecord들어가는 uri
				
			response.sendRedirect("/views/ranking/recordRanking.jsp");
			} else if (cmd.equals("/popular.record")) { // 인기 게임 목록 출력
				
				// DAO 메서드를 통해 인기 게임 리스트 가져오기
                List<GameRankingDTO> popularGames = gameRecordDao.getPopularGames();
                
                // Gson을 사용하여 JSON 변환
                Gson gson = new Gson();
                String json = gson.toJson(popularGames);

                // JSON 응답 보내기
                PrintWriter out = response.getWriter();
                out.print(json);
                out.flush();
				
			} else if (cmd.equals("/update.record")) {
				
			} else if (cmd.equals("/delete.record")) {
				
			} else if (cmd.equals("/rankinglist.record")) {
				// 랭킹 페이지에서 게임별 버튼 누를때 작동하는 ajax
				String checkId = request.getParameter("gameId");
				if (checkId==null||checkId.isEmpty()) {
					checkId = "4001";
				}
				int gameId = Integer.parseInt(checkId);
				List<GameRecordRankingDTO> rankingList = gameRecordDao.getGameRecordRanking(gameId);
				System.out.println(rankingList.get(1).getUserid());
				response.getWriter().append(g.toJson(rankingList));
				response.getWriter().flush();
				
				
			}
		} catch(Exception e) {
			e.printStackTrace();
		}

	}
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) 
			throws ServletException, IOException{
		doGet(request, response);
		

	    
	}
}


