package auth.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import auth.dto.UsersDTO;

public class UsersDAO {

    // Singleton pattern 적용
    private static UsersDAO instance;

    public synchronized static UsersDAO getInstance() {
    	System.out.println("dao 생성");
        if (instance == null) {
            instance = new UsersDAO();
        }
        return instance;
    }

    private Connection getConnection() throws Exception {
        Context ctx = new InitialContext();
        DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
        return ds.getConnection();
    }
    
    //로그인 기능 구현 : 사용자의 아이디와 패스워드를 받아 사용자 인스턴스를 반환 
    public UsersDTO login(String id, String pw) throws Exception {
        String sql = "SELECT id, name, nickname, phone, email FROM users WHERE id = ? AND pw = ?";

        try (Connection con = this.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {

            pstat.setString(1, id);
            pstat.setString(2, pw);

            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    return new UsersDTO(
                        rs.getString("id"),
                        null, // pw는 반환하지 않음
                        rs.getString("nickname"),
                        rs.getString("name"),
                        rs.getString("phone"),
                        rs.getString("email"),
                        null, null, 0, 0, 0, 0, null
                    );
                }
            }
        }
        return null; 
    }

    // 중복 검사 메서드
    // field - db 칼럼 , value - db 칼럼 값 
    public boolean isDuplicate(String field, String value) {
        String query = "SELECT COUNT(*) FROM USERS WHERE " + field + " = ?";
        
        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(query)) {
            pstmt.setString(1, value);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1) > 0; 
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // 회원가입 메서드
    public int signup(UsersDTO dto) throws Exception {
        String sql = "INSERT INTO users(id, pw, nickname, name, phone, email, rnum, joindate, warningcount, withdraw, status, isadmin, lastLogin) "
                   + "VALUES(?, ?, ?, ?, ?, ?, ?, sysdate, 0, 0, 0, 0, sysdate)";
        
        try (Connection conn = getConnection();
             PreparedStatement pstat = conn.prepareStatement(sql)) {

            pstat.setString(1, dto.getId());
            pstat.setString(2, dto.getPw());
            pstat.setString(3, dto.getNickname());
            pstat.setString(4, dto.getName());
            pstat.setString(5, dto.getPhone());
            pstat.setString(6, dto.getEmail());
            pstat.setString(7, dto.getRnum());

            return pstat.executeUpdate();
        }
    }
    
    //selectAll
    public List<UsersDTO> userList() throws Exception {
        List<UsersDTO> userList = new ArrayList<>();
        String sql = "SELECT * FROM users";
        
        try (Connection con = this.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {

            try (ResultSet rs = pstat.executeQuery()) {
                while (rs.next()) {
                    UsersDTO user = new UsersDTO(rs.getString("id"), rs.getString("pw"), rs.getString("name"), rs.getString("nickname"),
                    		rs.getString("phone"), rs.getString("email"), rs.getString("rnum"), rs.getTimestamp("joinDate"), 
                    		rs.getInt("warningCount"), rs.getInt("withdraw"), rs.getInt("status"), rs.getInt("isAdmin"), rs.getTimestamp("lastLogin"));

                    userList.add(user);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }        
        return userList;
    }
    
    public boolean checkPassword(String id, String pw) throws Exception  {
        String sql = "SELECT pw FROM users WHERE id = ?";
        
        UsersDTO dto = null;
        try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, id);
                       
            try (ResultSet rs = pstat.executeQuery()) {
            	if (rs.next()) {
                    String dbPassword = rs.getString("password");
                    return dbPassword.equals(pw); // 해싱된 비밀번호 비교할 경우 BCrypt 사용
                }
            }
        }
        return false;
    }
    
    
 // 마이페이지
    public UsersDTO myPage(String id) throws Exception {
        String sql = "SELECT * FROM users WHERE id=?";

        UsersDTO dto = null;
        try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
            pstat.setString(1, id);

            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    dto = new UsersDTO(
                            rs.getString("id"),
                            null, // 비밀번호는 반환하지 않음
                            rs.getString("name"),
                            rs.getString("nickname"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            null, null, 0, 0, 0, 0, null
                    );
                }
            }
        }
        return dto;
    }
    
 // 개인정보 수정페이지 -> 다시 작성하기 
 	public UsersDTO modifyPage(String id) throws Exception {
 		String sql = "select id, name, pw, nickname, phone, email, rnum, joindate from users where id='user1'";

 		UsersDTO dto = null;
 		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {

// 			pstat.setString(1, id);

 			try (ResultSet rs = pstat.executeQuery();) {
 				if (rs.next()) {
 					id = rs.getString("id");
 					String name = rs.getString("name");
 					String pw = rs.getString("pw");
 					String nickname = rs.getString("nickname");
 					String phone = rs.getString("phone");
 					String email = rs.getString("email");
 					String rnum = rs.getString("rnum");
 					Timestamp joindate = rs.getTimestamp("joindate");

 					dto = new UsersDTO(
                            rs.getString("id"),
                            null, // 비밀번호는 반환하지 않음
                            rs.getString("name"),
                            rs.getString("nickname"),
                            rs.getString("phone"),
                            rs.getString("email"),
                            null, null, 0, 0, 0, 0, null
                    );
 				}
 				return dto;
 			}
 		}
 	}
 	
 	public int withdraw(String id) throws Exception { // 탈퇴
		String sql = "delete from users where id = ?";
		
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, id);
			int result = pstat.executeUpdate();
			return result;
		}
	}
	
	public String isExistID(String name,String email) throws Exception { //아이디 찾기
		String sql = "select * from users where name=? and email=?";
		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			String id = "";
			pstat.setString(1, name);
			pstat.setString(2, email);
			try (ResultSet rs = pstat.executeQuery();) {
				while(rs.next()) {
					id = rs.getString("id");
				}
				return id;
			}
		}
	}
	
	public boolean isExistPW(String id, String email) throws Exception { // 비밀번호 찾기
	    String sql = "select * from users where id=? and email=?";
	    try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {

	        pstat.setString(1, id);
	        pstat.setString(2, email);

	        try (ResultSet rs = pstat.executeQuery();) {
	            return rs.next();
	        }
	    }
	}
	
	public boolean updatePassword(String id, String email, String newPassword) throws Exception { // 비밀번호 찾기 후 수정
		
	    String sql = "update users set pw = ? where id = ? and email = ?";
	    try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql)) {
	        pstat.setString(1, newPassword);
	        pstat.setString(2, id);
	        pstat.setString(3, email);

	        int result = pstat.executeUpdate();
	        return result > 0;
	    }
	}

}
