package auth.controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import auth.dao.*;

@WebServlet("/check-nickname")
public class CheckNicknameController extends HttpServlet {
    private UserCheckDAO checkHelper = new UserCheckDAO();
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
    	
    	request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();

		System.out.print("클라이언트 요청: " + cmd);
    	
        String nickname = request.getParameter("nickname");
        
        boolean isDuplicate = checkHelper.checkNicknameInDatabase(nickname);
        
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();
        out.write("{\"isDuplicate\": " + isDuplicate + "}");
    }
}