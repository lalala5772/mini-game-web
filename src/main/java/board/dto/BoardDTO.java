package board.dto;

import java.sql.Timestamp;

public class BoardDTO {
	
	private int seq;
	private String title;
	private String contens;
	private Timestamp writeDate;
	private int viewCount;
	private boolean isNotice;
	private String boardCategory;
	
	
	public BoardDTO(int seq, String title, String contens, Timestamp writeDate, int viewCount, boolean isNotice,
			String boardCategory) {
		super();
		this.seq = seq;
		this.title = title;
		this.contens = contens;
		this.writeDate = writeDate;
		this.viewCount = viewCount;
		this.isNotice = isNotice;
		this.boardCategory = boardCategory;
	}


	public int getSeq() {
		return seq;
	}


	public String getTitle() {
		return title;
	}


	public String getContens() {
		return contens;
	}


	public Timestamp getWriteDate() {
		return writeDate;
	}


	public int getViewCount() {
		return viewCount;
	}


	public boolean isNotice() {
		return isNotice;
	}


	public String getBoardCategory() {
		return boardCategory;
	}

}
