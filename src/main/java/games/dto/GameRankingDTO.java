package games.dto;

public class GameRankingDTO {
    private String gameName;
    private int playCount;
    private int ranking;

    public GameRankingDTO(String gameName, int playCount, int ranking) {
        this.gameName = gameName;
        this.playCount = playCount;
        this.ranking = ranking;
    }

	public String getGameName() {
		return gameName;
	}

	public void setGameName(String gameName) {
		this.gameName = gameName;
	}

	public int getPlayCount() {
		return playCount;
	}

	public void setPlayCount(int playCount) {
		this.playCount = playCount;
	}

	public int getRanking() {
		return ranking;
	}

	public void setRanking(int ranking) {
		this.ranking = ranking;
	}


}