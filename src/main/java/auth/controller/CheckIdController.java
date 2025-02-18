package auth.controller;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import auth.dao.UserCheckDAO;

@WebServlet("*.duplication") // 특정 URL로 직접 매핑
public class CheckIdController extends HttpServlet {
    private UserCheckDAO checkHelper = new UserCheckDAO();
    
    

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setContentType("application/json; charset=UTF-8");
        
        String cmd = request.getRequestURI();

		System.out.print("클라이언트 요청: " + cmd);


        String userid = request.getParameter("userid");
        boolean isDuplicate = checkHelper.checkIdInDatabase(userid);

        request.setAttribute("result", isDuplicate);
		request.getRequestDispatcher("views/auth/idcheck.jsp").forward(request, response);
    }
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
