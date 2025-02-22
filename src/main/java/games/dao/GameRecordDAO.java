package games.dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import games.dto.GameRankingDTO;
import games.dto.GameRecordDTO;



public class GameRecordDAO {
	// 1. 싱글톤 패턴
	public static GameRecordDAO instance;

	// 2. 싱글톤 패턴
	public synchronized static GameRecordDAO getInstance() {
		if (instance == null) {
			instance = new GameRecordDAO();
		}
		return instance;
	}

	// Tomcat 서버의 DBCP를 사용하여 커넥션을 가져오는 코드(DB 연결 생성)
	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext(); //
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	// 인기게임 순위
	public List<GameRankingDTO> getPopularGames() throws Exception {
		String sql = "SELECT GAMENAME, 플레이횟수, ROW_NUMBER() OVER (ORDER BY 플레이횟수 DESC) AS 순위 FROM (SELECT g.GAMENAME, gr.플레이횟수 FROM games g JOIN (SELECT GAMEID, COUNT(*) AS 플레이횟수 FROM gamerecord GROUP BY GAMEID) gr ON g.SEQ = gr.GAMEID) 게임별플레이횟수";

		List<GameRankingDTO> rankings = new ArrayList<>();

		try (Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);
				ResultSet rs = pstat.executeQuery();) {
			while (rs.next()) {
				GameRankingDTO game = new GameRankingDTO(
	                    rs.getString("GAMENAME"),
	                    rs.getInt("플레이횟수"),
	                    rs.getInt("순위")
	                );
                rankings.add(game);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return rankings;
	}
	
	//게임 기록 정보를 모두 출력하는 함수
    public List<GameRecordDTO> gameRecordList() throws Exception {
        List<GameRecordDTO> gameRecordList = new ArrayList<>();
        String sql = "SELECT * FROM gamerecord";
        
        try (Connection con = this.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {

            try (ResultSet rs = pstat.executeQuery()) {
                while (rs.next()) {
                    GameRecordDTO gameRecord = new GameRecordDTO(rs.getInt("seq"), rs.getString("userid"), rs.getInt("gameid"), rs.getInt("record"),
                    		rs.getTimestamp("playtime"), rs.getTimestamp("duration"));

                    gameRecordList.add(gameRecord);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }        
        return gameRecordList;
    }
    
    // my page에서 특정 사용자의 게임 리스트를 출력하는 함수 
    public GameRecordDTO gameMypage(String userid) throws Exception {
 
        String sql = "SELECT * FROM gamerecord where userid = ?";
        
        try (Connection con = this.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            
            pstat.setString(1, userid);
            
            try (ResultSet rs = pstat.executeQuery()) {
                if (!rs.next()) {
                    System.out.println("해당 userid에 대한 게임 기록이 없습니다.");
                    return null;
                }

                // 결과 처리
                GameRecordDTO gameMypage = new GameRecordDTO(
                    rs.getInt("seq"),
                    rs.getString("userid"),
                    rs.getInt("gameid"),
                    rs.getInt("record"),
                    rs.getTimestamp("playtime"),
                    rs.getTimestamp("duration")
                );
                
                return gameMypage;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }        
    }
    
    //특정 유저의 점수(최고기록) 반환  
    public GameRecordDTO getGameScore(String userid) throws Exception {
    	 
    	//특정 유저의 게임별 최대 점수를 조회
    	//점수가 존재하지 않을 경우 0반환 
        String sql = "SELECT NVL(MAX(gr.score), 0) AS max_score\r\n"
        		+ "FROM games g\r\n"
        		+ "LEFT JOIN gamerecord gr ON g.seq = gr.gameid AND gr.userid = ?\r\n"
        		+ "WHERE g.seq IN (4001, 4002, 4003, 4004, 4005)\r\n"
        		+ "GROUP BY g.gamename";
        
        try (Connection con = this.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            
            pstat.setString(1, userid);
            
            try (ResultSet rs = pstat.executeQuery()) {
                if (!rs.next()) {
                    System.out.println("해당 userid에 대한 게임 기록이 없습니다.");
                    return null;
                }

                // 결과 처리
                // 수정 필요 
                GameRecordDTO gameMypage = new GameRecordDTO(
                    rs.getInt("seq"),
                    rs.getString("userid"),
                    rs.getInt("gameid"),
                    rs.getInt("record"),
                    rs.getTimestamp("playtime"),
                    rs.getTimestamp("duration")
                );
                
                return gameMypage;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }        
    }
    
    
    //특정 유저의 게임별 랭킹 
    public GameRecordDTO getGameTime(String userid) throws Exception {
   	 
    	//특정 유저의 게임별 랭킹을 조회 
        String sql = "SELECT RANK() OVER (PARTITION BY gr.game_seq ORDER BY gr.score DESC) AS ranking\r\n"
        		+ "FROM gamerecord gr\r\n"
        		+ "JOIN games g ON gr.game_seq = g.seq\r\n"
        		+ "WHERE gr.userid = ?\r\n"
        		+ "AND gr.game_seq IN (4001, 4002, 4003, 4004, 4005)\r\n"
        		+ "ORDER BY gr.game_seq, ranking";
        
        try (Connection con = this.getConnection();
             PreparedStatement pstat = con.prepareStatement(sql)) {
            
            pstat.setString(1, userid);
            
            try (ResultSet rs = pstat.executeQuery()) {
                if (!rs.next()) {
                    System.out.println("해당 userid에 대한 게임 기록이 없습니다.");
                    return null;
                }

                // 결과 처리
                GameRecordDTO gameMypage = new GameRecordDTO(
                    rs.getInt("seq"),
                    rs.getString("userid"),
                    rs.getInt("gameid"),
                    rs.getInt("record"),
                    rs.getTimestamp("playtime"),
                    rs.getTimestamp("duration")
                );
                
                return gameMypage;
            }
        } catch (Exception e) {
            e.printStackTrace();
            throw e;
        }        
    }
	
}
