package admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import admin.dao.AdminDAO;

@WebServlet("*.admin")
public class AdminController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		String cmd = request.getRequestURI();
		AdminDAO dao = AdminDAO.getInstance();

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

		} else if (cmd.equals("/boardlist.admin")) {

		} else {

		}
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
	}

}
