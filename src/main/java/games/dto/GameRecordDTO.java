package games.dto;

import java.sql.Timestamp;

public class GameRecordDTO {
	
	private int seq;
	private String userId;
	private int gameId;
	private int record;
	private Timestamp playTime;
	private Timestamp duration;
	
	public GameRecordDTO(int seq, String userId, int gameId, int record, Timestamp playTime, Timestamp duration) {
		super();
		this.seq = seq;
		this.userId = userId;
		this.gameId = gameId;
		this.record = record;
		this.playTime = playTime;
		this.duration = duration;
	}

	public int getSeq() {
		return seq;
	}

	public String getUserId() {
		return userId;
	}

	public int getGameId() {
		return gameId;
	}
	
	public int getRecord() {
		return record;
	}

	public Timestamp getPlayTime() {
		return playTime;
	}
	
	public Timestamp getDuration() {
		return duration;
	}

}
