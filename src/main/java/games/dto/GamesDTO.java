package games.dto;

import java.sql.Timestamp;

public class GamesDTO {
	
	private int gameId;
	private String gameName;
	private Timestamp playTime;
	private String category;
	
	public GamesDTO(int gameId, String gameName, Timestamp playTime, String category) {
		super();
		this.gameId = gameId;
		this.gameName = gameName;
		this.playTime = playTime;
		this.category = category;
	}

	public int getGameId() {
		return gameId;
	}

	public String getGameName() {
		return gameName;
	}

	public Timestamp getPlayTime() {
		return playTime;
	}
	
	public String getCategory() {
		return category;
	}


}
