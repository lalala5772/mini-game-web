package admin.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AdminDAO {
	private AdminDAO() {

	};

	private static AdminDAO instance;

	public static synchronized AdminDAO getInstance() {
		if (instance == null) {
			instance = new AdminDAO();

		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	public List<String> getLineChartData() throws Exception {
		List<String> lineChartData = new ArrayList<>();

		String sql = "select m.month, (select count(*) from users where trunc(joindate,'MM') = to_date(m.month,'YYYY-MM')) as newusers from (select to_char(add_months(trunc(sysdate,'MM'),level-5),'YYYY-MM')as month from dual connect by level <=5) m order by m.month";
		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			while (rs.next()) {
				lineChartData.add(rs.getString(2));
			}
			return lineChartData;

		}
	}
	public List<String> getDoughnutChartData() throws Exception {
		List<String> doughnutChartData = new ArrayList<>();

		String sql = "SELECT NVL(COUNT(U.AGE), 0) FROM (SELECT LEVEL*10 AS AGE_GROUP FROM DUAL CONNECT BY LEVEL <= 5) AG LEFT JOIN (SELECT TO_NUMBER(TO_CHAR(SYSDATE,'YYYY'))-(CASE WHEN TO_NUMBER(SUBSTR(RNUM,1,2))<=TO_NUMBER(TO_CHAR(SYSDATE,'YY')) THEN 2000+TO_NUMBER(SUBSTR(RNUM,1,2)) ELSE 1900+TO_NUMBER(SUBSTR(RNUM,1,2)) END) AS AGE FROM USERS) U ON (U.AGE BETWEEN AG.AGE_GROUP AND AG.AGE_GROUP+9 OR (AG.AGE_GROUP=50 AND U.AGE>=50)) GROUP BY AG.AGE_GROUP ORDER BY AG.AGE_GROUP";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			while (rs.next()) {
				doughnutChartData.add(rs.getString(1));
			}
			return doughnutChartData;
		}

	}

	public List<String> getBarChartData() throws Exception {
		List<String> barChartData = new ArrayList<>();

		String sql = "select count(*) from GAMERECORD group by GAMEID";

		Connection con = this.getConnection();
		PreparedStatement pstat = con.prepareStatement(sql);
		ResultSet rs = pstat.executeQuery();

		while (rs.next()) {
			barChartData.add(rs.getString(1));
		}
		return barChartData;
	}

	public int getTodayVisit() throws Exception {
		String sql = "select count(*) from USERS where trunc(lastlogin,'dd')=trunc(sysdate,'dd')";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}

	}

	public int getTodayPost() throws Exception {
		String sql = "select count(*) from board where trunc(writedate,'dd') = trunc(sysdate,'dd')";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	public int getTodayPlayGame() throws Exception {
		String sql = "select count(*) from GAMERECORD where trunc(playtime,'dd') = trunc(sysdate,'dd')";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}

	public int getOnlineUser() throws Exception {
		String sql = "select count(*) from users where status = 0";

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			rs.next();
			return rs.getInt(1);
		}
	}
}