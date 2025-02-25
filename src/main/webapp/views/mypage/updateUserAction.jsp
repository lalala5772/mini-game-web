<%@ page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*, java.util.*" %>
<%@ page import="auth.dto.UsersDTO" %>
<%@ page import="auth.dao.UsersDAO" %>
<%
    // 세션에서 로그인 사용자 정보 가져오기
    UsersDTO loginUser = (UsersDTO) session.getAttribute("loginUser");
    
    // 로그인하지 않은 경우
    if (loginUser == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // 입력된 정보 가져오기
    request.setCharacterEncoding("UTF-8");
    String userName = request.getParameter("userName");
    String userNickname = request.getParameter("userNickname");
    String userEmail = request.getParameter("userEmail");
    String userPhone = request.getParameter("userPhone");
    String userRnum = request.getParameter("userRnum");
    
    // JSON 응답 설정
    response.setContentType("application/json");
    response.setCharacterEncoding("UTF-8");
    
    try {
        // 사용자 정보 업데이트
        /* UsersDTO updateUser = new UsersDTO(); */
        UsersDTO updateUser = new UsersDTO(
                loginUser.getId(),
                null,
                userNickname,
                userName,
                userPhone,
                userEmail,
                userRnum, 
                null, 0, 0, 0, 0, null
            );
        
        
        // DAO를 통해 데이터베이스에 업데이트
        UsersDAO usersDAO = new UsersDAO();
        boolean result = usersDAO.updateUserDB(updateUser);
        
        if (result) {
            // 세션의 사용자 정보도 업데이트
            session.setAttribute("loginUser", updateUser);
            out.print("{\"status\": \"success\"}");
        } else {
            out.print("{\"status\": \"fail\", \"message\": \"회원정보 수정에 실패했습니다.\"}");
        }
    } catch (Exception e) {
        out.print("{\"status\": \"fail\", \"message\": \"" + e.getMessage() + "\"}");
    }
%>