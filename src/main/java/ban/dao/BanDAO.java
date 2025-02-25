package ban.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BanDAO {

	private BanDAO() {

	};

	private static BanDAO instance;

	public static synchronized BanDAO getInstance() {
		if (instance == null) {
			instance = new BanDAO();
		}
		return instance;
	};

	private Connection getconnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();

	}

	public int modifyById(String isban, String id) throws Exception {
		String sql = "update ban set isban = ? where id = ?";

		try (Connection con = this.getconnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
			pstat.setString(1, isban);
			pstat.setString(2, id);

			return pstat.executeUpdate();
		}
	}

}
