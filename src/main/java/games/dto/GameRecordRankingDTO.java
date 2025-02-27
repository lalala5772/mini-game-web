package games.dto;

public class GameRecordRankingDTO {
	// 닉네임값을 넣어야하는것 유의
	private String userid;
	private int record;
	private int ranking;
	
	
	public GameRecordRankingDTO() {
		super();
	}
	public GameRecordRankingDTO(String userid, int record, int ranking) {
		super();
		this.userid = userid;
		this.record = record;
		this.ranking = ranking;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public int getRecord() {
		return record;
	}
	public void setRecord(int record) {
		this.record = record;
	}
	public int getRanking() {
		return ranking;
	}
	public void setRanking(int ranking) {
		this.ranking = ranking;
	}
}
