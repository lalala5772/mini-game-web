package auth.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import auth.dao.UsersDAO;
import auth.dto.UsersDTO;

@WebServlet("*.users")
public class UsersController extends HttpServlet {

	//	post, get 요청 모두 수용 
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response); // POST 요청도 동일하게 처리
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		processRequest(request, response); // GET 요청도 동일하게 처리
	}

	protected void processRequest(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String cmd = request.getRequestURI();

		System.out.println("클라이언트 요청: " + cmd);

		// 유저 기능 인스턴스 생성
		UsersDAO dao = UsersDAO.getInstance();

		try {
			if (cmd.equals("/login.users")) {
				System.out.println("Processing /login.users...");

				String id = request.getParameter("id");
				String pw = request.getParameter("pw");

				UsersDTO dto = dao.login(id, pw);  // 로그인한 유저 정보를 가져옴

				//유저 정보가 존재할 경우, 세션에 사용자 정보 저장 
				if (dto != null) {
					HttpSession session = request.getSession();
					session.setAttribute("loginUser", dto);
					
					//디버깅용 
					System.out.println("로그인 성공 - 세션 저장 완료: " + dto.getNickname());
					
					request.getRequestDispatcher("/index.jsp").forward(request, response);
					
				} else {
					System.out.println("로그인 실패 - 아이디 또는 비밀번호 불일치");
					response.sendRedirect("/views/auth/login.jsp"); 
				}
			}
			//로그아웃 요청 
			else if (cmd.trim().equals("/logout.users")) {
				HttpSession session = request.getSession();
				session.invalidate(); // 세션 초기화
				
				response.sendRedirect(request.getContextPath() + "/index.jsp"); // 로그아웃 후 메인 페이지로 이동
			}
			//회원가입 요청 
			else if (cmd.trim().equals("/signup.users")) {
				String id = request.getParameter("id");
				String pw = request.getParameter("pw");
				String nickname = request.getParameter("nickname");
				String name = request.getParameter("name");
				String email = request.getParameter("email");
				String rnum = request.getParameter("rnum");
				String phone = request.getParameter("phone");
				

				if (dao.isDuplicate("id", id)) { //db id칼럼의 값이 id변수 값과 같을 경우   
					request.setAttribute("errorMsg", "이미 사용 중인 아이디입니다.");
				} 
				else if (dao.isDuplicate("NICKNAME", nickname)) { //db nickname칼럼의 값이 nickname변수 값과 같을 경우  
					request.setAttribute("errorMsg", "이미 사용 중인 닉네임입니다.");
				} 
				else {
					UsersDTO loginUser = new UsersDTO(id, pw, nickname, name, phone, email, rnum, 0, 0, 0, 0);
					if (dao.signup(loginUser) > 0) {
						// 회원가입 성공 후 세션 저장
						HttpSession session = request.getSession();
						session.setAttribute("loginUser",loginUser);

						// 회원가입 성공 시
						request.getRequestDispatcher("/index.jsp").forward(request, response);

						return;
					} else {
						System.out.println("회원가입 실패");
					}
					request.setAttribute("id", id);
					request.setAttribute("nickname", nickname);
					request.setAttribute("name", name);
					request.setAttribute("email", email);
					request.setAttribute("rnum", rnum);
					request.setAttribute("phone", phone);
					request.getRequestDispatcher("views/auth/signup.jsp").forward(request, response);
				}
			}
			// 아이디 찾기 기능 
			else if (cmd.equals("/findId.users")) { 
				String name = request.getParameter("name");
				String email = request.getParameter("email");

				String result = dao.isExistID(name, email);

				if(result != null && !result.isEmpty()) {
					// 아이디를 찾은 경우, JSON 응답으로 반환
					response.setContentType("application/json");
					response.getWriter().write("{\"id\":\"" + result + "\"}");
				} else {
					// 아이디를 찾지 못한 경우, 에러 메시지 반환
					response.setContentType("application/json");
					response.getWriter().write("{\"error\":\"아이디를 찾을 수 없습니다.\"}");
				}
			} 
			// 비밀번호 찾기 기능 
			else if (cmd.equals("/findPw.users")) { 
				String id = request.getParameter("id");
				String email = request.getParameter("email");

				boolean result = dao.isExistPW(id, email);

				// JSON 응답으로 처리
				response.setContentType("application/json");
				PrintWriter out = response.getWriter();

				if (result) {
					// 일치하는 아이디와 이메일이 있으면 "match" true로 응답
					out.write("{\"match\": true}");
				} else {
					// 일치하지 않으면 "match" false로 응답
					out.write("{\"match\": false}");
				}
				out.flush();
			} else if (cmd.equals("/resetPw.users")) { // 비밀번호 찾기 후 수정
				String id = request.getParameter("id");
				String email = request.getParameter("email");
				String newPassword = request.getParameter("newPassword");

				// 비밀번호 변경
				boolean isUpdated = dao.updatePassword(id, email, newPassword);

				if (isUpdated) {
					// 비밀번호 변경이 성공하면 홈페이지로 리디렉션
					response.sendRedirect("/index.jsp");
				} else {
					// 실패 시 메시지 출력
					response.getWriter().write("비밀번호 변경 실패");
				}
			} 
			else if (cmd.equals("/modify.users")) { // 개인정보수정
				String id = (String) request.getSession().getAttribute("loginID");
				
				UsersDTO dto = dao.modifyPage(id);
				request.setAttribute("dto", dto);
				request.getRequestDispatcher("/views/auth/modify_information.jsp").forward(request, response);
				
			}
			else if (cmd.equals("/checkPassword.users")){
				HttpSession session = request.getSession();
		        String pw = request.getParameter("pw");
		        String id = (String) session.getAttribute("id"); // 로그인한 유저 ID

		        boolean isMatch = dao.checkPassword(id, pw);

		        response.setContentType("text/plain");
		        response.setCharacterEncoding("UTF-8");

		        if (isMatch) {
		            response.getWriter().write("success");
		        } else {
		            response.getWriter().write("fail");
		        }
			}
			else if (cmd.equals("/chat.users")){
				HttpSession session = request.getSession();
		        UsersDTO loginUser = (UsersDTO) session.getAttribute("id"); 

		        request.setAttribute("loginUser", loginUser);
				request.getRequestDispatcher("/views/chat/chat.jsp").forward(request, response);
			}
			// 
//			else if (cmd.equals("/checkDuplicate.users")) {
//				response.setContentType("text/plain;charset=UTF-8");
//				String field = request.getParameter("field");
//				String value = request.getParameter("value");
//				try (PrintWriter out = response.getWriter()) {
//					out.write(dao.isDuplicate(field, value) ? "duplicate" : "available");
//				}
//			}
//			
//
//			
//
//			else if (cmd.equals("/withdraw.users")) { //회원탈퇴
//				String id = (String) request.getSession().getAttribute("id");
//				int result = dao.withdraw(id);
//
//				if (result > 0) {
//					System.out.println("탈퇴 성공");
//					request.getSession().invalidate();// 세션에서 정보 삭제
//					response.sendRedirect("/index.jsp");
//				} 
//
//			}  
//			
//
//
//						   else if (cmd.equals("/withdraw.users")) { //회원탈퇴
//							String id = (String) request.getSession().getAttribute("loginID");
//							int result = dao.withdraw(id);
//							
//							if (result > 0) {
//								System.out.println("탈퇴 성공");
//								request.getSession().invalidate();// 세션에서 정보 삭제
//								response.sendRedirect("/index.jsp");
//							} 
//							
//						} else if (cmd.equals("/findID.users")) { //아이디 찾기
//							String id = request.getParameter("id");
//							String email = request.getParameter("email");
//						}

				
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}