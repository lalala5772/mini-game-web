package auth.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;


public class UsersDAO {
	
	//singleton pattern 적용 
		private static UsersDAO instance;
		public synchronized static UsersDAO getInstance(){
			if(instance == null){
				instance = new UsersDAO();
			}
			return instance;
		}

		private Connection getConnection() throws Exception{

			Context ctx = new InitialContext();
			DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");

			return ds.getConnection();

		}
		
		 // 아이디 중복 확인
	    public boolean isIdDuplicate(String id) {
	        String sql = "select count(*) from users where id = ?";
	        try (Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql)){
	        	pstat.setString(1, id);
	            try (ResultSet rs = pstat.executeQuery()) {
	                if (rs.next() && rs.getInt(1) > 0) {
	                    return true; 
	                }
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

	    // 닉네임 중복 확인
	    public boolean isNicknameDuplicate(String nickname) {
	        String sql = "select count(*) from users where nickname = ?";
	        try (Connection con = this.getConnection();
					PreparedStatement pstat = con.prepareStatement(sql)) {
	        	pstat.setString(1, nickname);
	            try (ResultSet rs = pstat.executeQuery()) {
	                if (rs.next() && rs.getInt(1) > 0) {
	                    return true; 
	                }
	            }
	        } catch (Exception e) {
	            e.printStackTrace();
	        }
	        return false;
	    }

}
