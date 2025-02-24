package admin.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import admin.dao.AdminDAO;
import auth.dao.UsersDAO;
import auth.dto.UsersDTO;
import board.dao.BoardDAO;
import board.dto.BoardDTO;
import utils.Statics;

@WebServlet("*.admin")
public class AdminController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		response.setContentType("application/json; charset=UTF-8"); // ✅ UTF-8 설정
		response.setCharacterEncoding("UTF-8");
		String cmd = request.getRequestURI();
		AdminDAO dao = AdminDAO.getInstance();
		UsersDAO udao = UsersDAO.getInstance();
		BoardDAO bdao = BoardDAO.getInstance();
		Gson g = new Gson();

		System.out.println("클라이언트 요청 : " + cmd);

		if (cmd.equals("/dashboard.admin")) {

			try {
				int todayVisit = dao.getTodayVisit();
				int todayPost = dao.getTodayPost();
				int todayPlayGame = dao.getTodayPlayGame();
				int onlineUser = dao.getOnlineUser();

				request.setAttribute("todayVisit", todayVisit);
				request.setAttribute("todayPost", todayPost);
				request.setAttribute("todayPlayGame", todayPlayGame);
				request.setAttribute("onlineUser", onlineUser);

				request.getRequestDispatcher("/views/admin/adminDashBoard.jsp").forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (cmd.equals("/customerlist.admin")) {
			try {
				String scpage = (String) (request.getParameter("cpage"));
				if (scpage == null) {
					scpage = "1";
				}
				int cpage = Integer.parseInt(scpage);

				int recordTotalCount = dao.getRecordUserListCount();

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
				request.getSession().setAttribute("last_user_cpage", scpage);

				int start = cpage * Statics.recordCountPerPage - (Statics.recordCountPerPage - 1);
				int end = cpage * Statics.recordCountPerPage;

				int startNavi = (cpage - 1) / Statics.naviCountPerPage * Statics.naviCountPerPage + 1;
				int endNavi = startNavi + Statics.naviCountPerPage - 1;

				if (endNavi > pageTotalCount) {
					endNavi = pageTotalCount;
				}
				boolean needPrev = true;
				boolean needNext = true;

				if (startNavi == 1) {
					needPrev = false;
				}
				if (endNavi == pageTotalCount) {
					needNext = false;
				}
//				System.out.println(needPrev + " 이전");
//				System.out.println(needNext+"다음");

				request.setAttribute("cpage", cpage);
				request.setAttribute("startNavi", startNavi);
				request.setAttribute("endNavi", endNavi);
				request.setAttribute("needPrev", needPrev);
				request.setAttribute("needNext", needNext);

				List<UsersDTO> userList = dao.selectFromTotalUsersList(start, end);
				List<UsersDTO> newUserList = dao.getNewUserList();
				request.setAttribute("newUserList", newUserList);
				request.setAttribute("userList", userList);

				request.getRequestDispatcher("views/admin/adminCustomerList.jsp").forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (cmd.equals("/getcustomerlist.admin")) {
			String scpage = request.getParameter("cpage");
			if (scpage == null) {
				scpage = "1";
			}
			int cpage = Integer.parseInt(scpage);

			int end = cpage * Statics.recordCountPerPage;
			int start = end - (Statics.recordCountPerPage - 1);

//			System.out.println("AJAX 요청 - 현재 페이지: " + cpage);
//			System.out.println("start: " + start + ", end: " + end);

			try {
				List<UsersDTO> userList = dao.selectFromTotalUsersList(start, end);
				response.getWriter().append(g.toJson(userList));
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (cmd.equals("/getnewcustomerlist.admin")) {
			try {
				List<UsersDTO> newUserList = dao.getNewUserList();
				response.getWriter().append(g.toJson(newUserList));

			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (cmd.equals("/deleteuser.admin")) {
			String userseq = request.getParameter("userid");
			try {
				int result = udao.withdraw(userseq);
				String isdelete;
				if (result > 0) {
					isdelete = "삭제 성공";
				} else {
					isdelete = "삭제 실패";
				}
				response.getWriter().append(g.toJson(isdelete));
				response.getWriter().flush();
			} catch (Exception e) {
				e.printStackTrace();
			}

		} else if (cmd.equals("/searchuser.admin")) {
			try {
				String nickName = request.getParameter("userNickName");
				UsersDTO user = dao.searchByNickName(nickName);
				response.getWriter().append(g.toJson(user));
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			
			
		} else if (cmd.equals("/boardlist.admin")) {

			// 현재페이지
			String scpage = (String) (request.getParameter("cpage"));

			// 현재 페이지 유효성 검사.
			if (scpage == null) {
				scpage = "1";
			}

			int cpage = Integer.parseInt(scpage);
			if (cpage < 1) {
				cpage = 1;
			}
			int recordTotalCount;
			try {
				recordTotalCount = bdao.getRecordTotalBoardListCount();
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

				List<BoardDTO> boardList = bdao.selectFromTotalBoardList(start, end);

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
				request.setAttribute("boardList", boardList);
				request.setAttribute("cpage", cpage);
				request.setAttribute("startNavi", startNavi);
				request.setAttribute("endNavi", endNavi);
				request.setAttribute("needPrev", needPrev);
				request.setAttribute("needNext", needNext);

				request.getRequestDispatcher("/views/admin/adminBoards.jsp").forward(request, response);

			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (cmd.equals("/getboardlist.admin")) {
//			System.out.println("주문받음");
			int cpage = Integer.parseInt(request.getParameter("cpage"));
			int end = cpage * Statics.recordCountPerPage;
			int start = cpage - (Statics.recordCountPerPage - 1);

			try {
				List<BoardDTO> boardList = bdao.selectFromTotalBoardList(start, end);
				String json = g.toJson(boardList);
				response.getWriter().append(json);
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if (cmd.equals("/boardlist.admin")) {
			// 현재페이지
			String searchKeyword = request.getParameter("searchKeyword");
			String scpage = (String) (request.getParameter("cpage"));

			// 현재 페이지 유효성 검사.
			if (scpage == null) {
				scpage = "1";
			}

			int cpage = Integer.parseInt(scpage);
			if (cpage < 1) {
				cpage = 1;
			}

			try {
				  int recordTotalCount;
			      List<BoardDTO> boardList;
				
		        // 검색어가 있는 경우와 없는 경우를 구분하여 처리
		        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
		            recordTotalCount = bdao.getSearchRecordCount(searchKeyword);
		        } else {
		            recordTotalCount = bdao.getRecordTotalBoardListCount();
		        }

		        // 페이지 계산
		        int pageTotalCount = (recordTotalCount + Statics.recordCountPerPage - 1) / Statics.recordCountPerPage;
		        
				if (recordTotalCount % Statics.recordCountPerPage > 0) {
					pageTotalCount = recordTotalCount / Statics.recordCountPerPage + 1;
				} else {
					pageTotalCount = recordTotalCount / Statics.recordCountPerPage;
				}        
				
				// 현재 페이지 범위 조정
		        if (cpage > pageTotalCount) {
		            cpage = pageTotalCount;
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
				
				
		        // 검색 또는 전체 목록 가져오기
		        if (searchKeyword != null && !searchKeyword.trim().isEmpty()) {
		            boardList = bdao.searchBoardListByWriter(start, end, searchKeyword);
		        } else {
		            boardList = bdao.selectFromTotalBoardList(start, end);
		        }


				List<BoardDTO> newBoardList = bdao.getNewBoardList();

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
				request.setAttribute("boardList", boardList);
				request.setAttribute("newBoardList", newBoardList);
				request.setAttribute("cpage", cpage);
				request.setAttribute("startNavi", startNavi);
				request.setAttribute("endNavi", endNavi);
				request.setAttribute("needPrev", needPrev);
				request.setAttribute("needNext", needNext);

				request.getRequestDispatcher("/views/admin/adminBoards.jsp").forward(request, response);

			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
		} else if (cmd.equals("/deletepost.admin")) {
			
			 try {
			        int seq = Integer.parseInt(request.getParameter("seq"));
			        System.out.println(seq);
			        int result = bdao.deleteBySeq(seq); // 게시글 삭제

			        if (result > 0) {
			            response.setStatus(HttpServletResponse.SC_OK); // 200 OK
			        } else {
			            response.setStatus(HttpServletResponse.SC_BAD_REQUEST); // 400 오류
			        }

			    } catch (Exception e) {
			        e.printStackTrace();
			        response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR); // 500 오류
       }
		} else if (cmd.equals("/getuserlist.admin")) {

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
