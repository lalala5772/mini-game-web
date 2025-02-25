<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="auth.dto.UsersDTO" %>
<%@ page import="auth.dao.UsersDAO" %>
<%
    // 세션에서 로그인 사용자 정보 가져오기
	String id = (String) session.getAttribute("id");
	UsersDAO usersDAO = UsersDAO.getInstance();
    
    // 로그인하지 않은 경우
    if (id == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // 입력된 비밀번호 가져오기
    String inputPassword = request.getParameter("password").trim(); //추후 암호화 
    String storedPassword = usersDAO.getPassword(id); // 저장된 비밀번호
    
 // 디버깅을 위한 로그
    System.out.println("입력된 비밀번호: " + inputPassword);
    System.out.println("저장된 비밀번호: " + storedPassword);
    
    // JSON 응답 설정
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    
    // 비밀번호 비교 (실제 환경에서는 암호화된 비밀번호 비교 로직 필요)
    if (storedPassword != null && storedPassword.equals(inputPassword)) {
        out.print("{\"status\": \"success\"}");
    } else {
        out.print("{\"status\": \"fail\"}");
    }
%>