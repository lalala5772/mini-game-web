package board.dto;

import java.sql.Timestamp;

public class ReplyDTO {
	private int seq;
	private int commonBoardSeq;
	private String id;
	private String contens;
	private Timestamp writeDate;
	private int parentComment;
	
	public ReplyDTO(int seq, int commonBoardSeq, String id, String contens, Timestamp writeDate, int parentComment) {
		super();
		this.seq = seq;
		this.commonBoardSeq = commonBoardSeq;
		this.id = id;
		this.contens = contens;
		this.writeDate = writeDate;
		this.parentComment = parentComment;
	}

	public int getSeq() {
		return seq;
	}

	public int getCommonBoardSeq() {
		return commonBoardSeq;
	}

	public String getId() {
		return id;
	}

	public String getContens() {
		return contens;
	}

	public Timestamp getWriteDate() {
		return writeDate;
	}

	public int getParentComment() {
		return parentComment;
	}
	

}
