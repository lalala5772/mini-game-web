package mypage.controller;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auth.dto.UsersDTO;
import board.dao.BoardDAO;
import board.dto.BoardDTO;
import games.dao.GameRecordDAO;
import games.dto.GameRecordDTO;


@WebServlet("*.mypage")
public class MyPageController  extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setContentType("text/html; charset=UTF-8");

        String cmd = request.getRequestURI();
        System.out.println("클라이언트 요청: " + cmd);
        
        GameRecordDAO gameRecordDao = new GameRecordDAO();
        BoardDAO userBoardDao = new BoardDAO();
        
        if(cmd.equals("/info.mypage")) {
        	
        	HttpSession session = request.getSession();
            UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
            try {
                // 게임 최고 기록 가져오기
                Map<String, Integer> highestScores = gameRecordDao.getHighestScoresByGame(loginUser.getId());

                // 사용자의 전체 게시글 목록
                List<BoardDTO> userBoardList = userBoardDao.userBoardList(loginUser.getId());

//                // 📌 무한스크롤을 위한 페이징 변수
//                int pageSize = 10; // 한 번에 불러올 게시글 개수
//                int page = 1; // 기본 페이지 번호
//                if (request.getParameter("page") != null) {
//                    page = Integer.parseInt(request.getParameter("page"));
//                }
//                int offset = (page - 1) * pageSize;
//
//                // 페이징된 게시글 목록 (무한스크롤용)
//                List<BoardDTO> userBoardList2 = userBoardDao.getUserPosts(loginUser.getId(), pageSize, offset);

                // 데이터 저장
                request.setAttribute("loginUser", loginUser);
                request.setAttribute("highestScores", highestScores);
                request.setAttribute("userBoardList", userBoardList);


                // 마이페이지 JSP로 이동
                request.getRequestDispatcher("/views/mypage/mypage.jsp").forward(request, response);
                
            } catch (Exception e) {
                e.printStackTrace();
                throw new ServletException(e);
            }
        }
        // 사용자가 작성한 게시판 목록 요청         
        else if(cmd.equals("/mypost.mypage")) {
        	
        	
        }
        // 사용자가 작성한 댓글 목록 요청   
        else if(cmd.equals("/myreply.mypage")) {
        	
        }

    }
}
	