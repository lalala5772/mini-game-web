package auth.dao;

import java.sql.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class UserCheckDAO {

    // Singleton pattern 적용
    private static UserCheckDAO instance;
    
    public synchronized static UserCheckDAO getInstance() {
        if (instance == null) {
            instance = new UserCheckDAO();
        }
        return instance;
    }

    // DB 연결 설정
    private Connection getConnection() throws SQLException {
        try {
            Context ctx = new InitialContext();
            DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
            return ds.getConnection();
        } catch (Exception e) {
            throw new SQLException("Database connection error", e);
        }
    }

    // ID 중복 체크
    public boolean checkIdInDatabase(String userid) {
        String query = "select count(*) from users where id = ?";
        try (Connection con = this.getConnection(); 
             PreparedStatement pstat = con.prepareStatement(query)) {

            pstat.setString(1, userid);
            try (ResultSet rs = pstat.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;  // 중복이 있으면 true, 없으면 false
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // DB 오류나 기타 문제 발생 시 기본적으로 false 반환
    }

    // 닉네임 중복 체크
    public boolean checkNicknameInDatabase(String nickname) {
        String query = "select count(*) from users where nickname = ?";
        try (Connection con = this.getConnection(); 
             PreparedStatement stmt = con.prepareStatement(query)) {

            stmt.setString(1, nickname);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    int count = rs.getInt(1);
                    return count > 0;  // 중복이 있으면 true, 없으면 false
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false; // DB 오류나 기타 문제 발생 시 기본적으로 false 반환
    }
}
