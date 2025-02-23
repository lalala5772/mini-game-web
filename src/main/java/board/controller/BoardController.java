package board.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.BoardDAO;
import board.dto.BoardDTO;
import utils.Statics;

@WebServlet("*.board")
public class BoardController extends HttpServlet {

   protected void doGet(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {

      request.setCharacterEncoding("UTF-8");
      response.setContentType("text/html; charset=UTF-8");

      String cmd = request.getRequestURI();
      
      // BoardDAO dao 인스턴스 생성
      BoardDAO dao = BoardDAO.getInstance();
      
      System.out.println("클라이언트 요청: " + cmd);

      try {
         
         if (cmd.equals("/add.board")) {
            
            
            response.sendRedirect("/views/board/write.jsp");
         }
         //공지사항게시판 목록 출력
         else if (cmd.equals("/noticeList.board")) {
            // 현재페이지
            String scpage = (String) (request.getParameter("cpage"));

            // 현재 페이지 유효성 검사.
            if (scpage == null) {
               scpage = "1";
            }

            int cpage = Integer.parseInt(scpage);

            int recordTotalCount = dao.getRecordTotalCountNotice();

            int pageTotalCount = 0;

            if (recordTotalCount % Statics.recordCountPerPage > 0) {
               pageTotalCount = recordTotalCount / Statics.recordCountPerPage + 1;
            } else {
               pageTotalCount = recordTotalCount / Statics.recordCountPerPage;
            }

            if (cpage < 1) {
               cpage = 1;
            } else if (cpage > pageTotalCount) {
               cpage = pageTotalCount;
            }
            request.getSession().setAttribute("last_cpage", cpage);

            // 네이게이션 시작번호
            int start = cpage * Statics.recordCountPerPage - (Statics.recordCountPerPage - 1);
            // 네이게이션 끝번호
            int end = cpage * Statics.recordCountPerPage;

            // 공지게시판 목록 출력
            List<BoardDTO> noticeList = dao.selectFromToNotice(start, end);

            int startNavi = (cpage - 1) / Statics.naviCountPerPage * Statics.naviCountPerPage + 1;
            int endNavi = startNavi + Statics.naviCountPerPage - 1;
            
            // endNavi 값은 페이지 전체 개수보다 클수없음!
            if (endNavi > pageTotalCount) {
               endNavi = pageTotalCount;
            } 
            // 이전
            boolean needPrev = true;
            // 다음
            boolean needNext = true;

            if (startNavi == 1) {
               needPrev = false;
            } else if (endNavi == pageTotalCount) {
               needNext = false;
            }

            request.setAttribute("noticeList", noticeList);
            request.setAttribute("cpage", cpage);
            request.setAttribute("startNavi", startNavi);
            request.setAttribute("endNavi", endNavi);
            request.setAttribute("needPrev", needPrev);
            request.setAttribute("needNext", needNext);

            request.getRequestDispatcher("/views/board/noticeList.jsp").forward(request, response);
         } 
         //자유게시판 게시글 목록 출력
         else if (cmd.equals("/generalList.board")) {
            // 현재페이지
            String scpage = (String) (request.getParameter("cpage"));

            // 현재 페이지 유효성 검사.
            if (scpage == null) {
               scpage = "1";
            }
            int cpage = Integer.parseInt(scpage);

            int recordTotalCount = dao.getRecordTotalCountGeneral();

            int pageTotalCount = 0;

            if (recordTotalCount % Statics.recordCountPerPage > 0) {
               pageTotalCount = recordTotalCount / Statics.recordCountPerPage + 1;
            } else {
               pageTotalCount = recordTotalCount / Statics.recordCountPerPage;
            }

            if (cpage < 1) {
               cpage = 1;
            } else if (cpage > pageTotalCount) {
               cpage = pageTotalCount;
            }
            request.getSession().setAttribute("last_cpage", cpage);

            // 네이게이션 시작번호
            int start = cpage * Statics.recordCountPerPage - (Statics.recordCountPerPage - 1);
            // 네이게이션 끝번호
            int end = cpage * Statics.recordCountPerPage;

            // 자유게시판 목록 출력
            List<BoardDTO> generalList = dao.selectFromToGeneral(start, end);
            
            int startNavi = (cpage - 1) / Statics.naviCountPerPage * Statics.naviCountPerPage + 1;
            int endNavi = startNavi + Statics.naviCountPerPage - 1;

            // endNavi 값은 페이지 전체 개수보다 클수없음!
            if (endNavi > pageTotalCount) {
               endNavi = pageTotalCount;
            } 

            // 이전
            boolean needPrev = true;
            // 다음
            boolean needNext = true;

            if (startNavi == 1) {
               needPrev = false;
            } else if (endNavi == pageTotalCount) {
               needNext = false;
            }
            
            request.setAttribute("generalList", generalList);
            
            request.setAttribute("cpage", cpage);
            request.setAttribute("startNavi", startNavi);
            request.setAttribute("endNavi", endNavi);
            request.setAttribute("needPrev", needPrev);
            request.setAttribute("needNext", needNext);

            request.getRequestDispatcher("/views/board/generalList.jsp").forward(request, response);

         } 
         //공지사항 게시판 검색내용 목록 출력
         else if (cmd.equals("/noticeSearchList.board")) {
            String searchNoticeKeyword = request.getParameter("searchKeyword");
            
            String searchNoticeCategory = request.getParameter("searchCategory");

            // 현재페이지
            String scpage = (String) (request.getParameter("cpage"));

            // 현재 페이지 유효성 검사.
            if (scpage == null) {
               scpage = "1";
            }

            int cpage = Integer.parseInt(scpage);

            int recordTotalCount = dao.getRecordTotalCountNoticeSearch(searchNoticeKeyword,searchNoticeCategory);

            int pageTotalCount = 0;

            if (recordTotalCount % Statics.recordCountPerPage > 0) {
               pageTotalCount = recordTotalCount / Statics.recordCountPerPage + 1;
            } else {
               pageTotalCount = recordTotalCount / Statics.recordCountPerPage;
            }

            if (cpage < 1) {
               cpage = 1;
            } else if (cpage > pageTotalCount) {
               cpage = pageTotalCount;
            }
            request.getSession().setAttribute("last_cpage", cpage);

            // 네이게이션 시작번호
            int start = cpage * Statics.recordCountPerPage - (Statics.recordCountPerPage - 1);
            // 네이게이션 끝번호
            int end = cpage * Statics.recordCountPerPage;

            List<BoardDTO> noticeSearchList = dao.searchFromToNotice(start, end, searchNoticeKeyword,searchNoticeCategory);

            int startNavi = (cpage - 1) / Statics.naviCountPerPage * Statics.naviCountPerPage + 1;
            int endNavi = startNavi + Statics.naviCountPerPage - 1;
            
            // endNavi 값은 페이지 전체 개수보다 클수없음!
            if (endNavi > pageTotalCount) {
               endNavi = pageTotalCount;
            } 

            // 이전
            boolean needPrev = true;
            // 다음
            boolean needNext = true;

            if (startNavi == 1) {
               needPrev = false;
            } else if (endNavi == pageTotalCount) {
               needNext = false;
            }

            request.setAttribute("noticeSearchList", noticeSearchList);

            request.setAttribute("cpage", cpage);
            request.setAttribute("startNavi", startNavi);
            request.setAttribute("endNavi", endNavi);
            request.setAttribute("needPrev", needPrev);
            request.setAttribute("needNext", needNext);

            request.getRequestDispatcher("/views/board/noticeSearchList.jsp").forward(request, response);

         } 
         //자유게시판 검색내용 목록 출력
         else if (cmd.equals("/generalSearchList.board")) {
            String searchGeneralKeyword = request.getParameter("searchKeyword");
            
            String searchGeneralCategory = request.getParameter("searchCategory");

            // 현재페이지
            String scpage = (String) (request.getParameter("cpage"));

            // 현재 페이지 유효성 검사.
            if (scpage == null) {
               scpage = "1";
            }

            int cpage = Integer.parseInt(scpage);

            int recordTotalCount = dao.getRecordTotalCountGeneralSearch(searchGeneralKeyword,searchGeneralCategory);

            int pageTotalCount = 0;

            if (recordTotalCount % Statics.recordCountPerPage > 0) {
               pageTotalCount = recordTotalCount / Statics.recordCountPerPage + 1;
            } else {
               pageTotalCount = recordTotalCount / Statics.recordCountPerPage;
            }

            if (cpage < 1) {
               cpage = 1;
            } else if (cpage > pageTotalCount) {
               cpage = pageTotalCount;
            }
            request.getSession().setAttribute("last_cpage", cpage);

            // 네이게이션 시작번호
            int start = cpage * Statics.recordCountPerPage - (Statics.recordCountPerPage - 1);
            // 네이게이션 끝번호
            int end = cpage * Statics.recordCountPerPage;

            List<BoardDTO> generalSearchList = dao.searchFromToGeneral(start, end, searchGeneralKeyword,searchGeneralCategory);

            int startNavi = (cpage - 1) / Statics.naviCountPerPage * Statics.naviCountPerPage + 1;
            int endNavi = startNavi + Statics.naviCountPerPage - 1;
            
            // endNavi 값은 페이지 전체 개수보다 클수없음!
            if (endNavi > pageTotalCount) {
               endNavi = pageTotalCount;
            } 

            // 이전
            boolean needPrev = true;
            // 다음
            boolean needNext = true;

            if (startNavi == 1) {
               needPrev = false;
            } else if (endNavi == pageTotalCount) {
               needNext = false;
            }

            request.setAttribute("generalSearchList", generalSearchList);

            request.setAttribute("cpage", cpage);
            request.setAttribute("startNavi", startNavi);
            request.setAttribute("endNavi", endNavi);
            request.setAttribute("needPrev", needPrev);
            request.setAttribute("needNext", needNext);

            request.getRequestDispatcher("/views/board/generalSearchList.jsp").forward(request, response);

         }
         //수정하기 페이지로 이동 컨트롤러
         else if (cmd.equals("/updateList.board")) {
            int seq = Integer.parseInt(request.getParameter("seq"));
            String boardCategory = request.getParameter("boardCategory");
            
            System.out.println(seq + boardCategory);
            BoardDTO updateList = dao.selectBySeq(seq);
            
            request.setAttribute("updateList", updateList);
            request.getRequestDispatcher("/views/board/update.jsp").forward(request, response);
            
         }
         // 수정페이지에서 수정 완료 컨트롤러
         else if (cmd.equals("/updateComplete.board")) {
            int seq = Integer.parseInt(request.getParameter("seq"));
            String title = request.getParameter("title");
            String boardCategory = request.getParameter("boardCategory");
            String contents = request.getParameter("contents");
            System.out.println(seq +" : "+ title +" : "+contents +" : "+ boardCategory);
            
            
            int UpdateResult = dao.updateByBoardList(seq, title, contents);
            
            response.sendRedirect("/generalList.board?cpage=1");
            
         }
         else if (cmd.equals("/delete.board")) {
            int seq = Integer.parseInt(request.getParameter("seq"));
            String boardCategory = request.getParameter("boardCategory");
            
            dao.deleteBySeq(seq);
         }
         else if (cmd.equals("/detail.board")) {
            // !!! 테스트용 코드 !!!
            request.getSession().setAttribute("nickname", "테스트용닉네임");
            // !!! 테스트용 코드 !!!
            
            int seq = Integer.parseInt(request.getParameter("seq"));
            
            BoardDTO post = dao.selectBySeq(seq);
            dao.incrementViewCount(seq);
            
            request.setAttribute("post", post);
            
            request.getRequestDispatcher("/views/board/detail.jsp").forward(request, response);
         }
         
         
         
      } catch (Exception e) {
         e.printStackTrace();
      }

   }

   protected void doPost(HttpServletRequest request, HttpServletResponse response)
         throws ServletException, IOException {
      doGet(request, response);
   }
}
