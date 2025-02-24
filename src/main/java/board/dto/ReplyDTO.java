package board.dto;

import java.sql.Timestamp;

public class ReplyDTO {
	private int seq;
	private int parentBoardSeq;
	private String writer;
	private String contents;
	private Timestamp writeDate;
	private int parentReplySeq;
	
	public ReplyDTO() {
		
	}

	public ReplyDTO(int seq, int parentBoardSeq, String writer, String contents, Timestamp writeDate,
			int parentReplySeq) {
		this.seq = seq;
		this.parentBoardSeq = parentBoardSeq;
		this.writer = writer;
		this.contents = contents;
		this.writeDate = writeDate;
		this.parentReplySeq = parentReplySeq;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getParentBoardSeq() {
		return parentBoardSeq;
	}

	public void setParentBoardSeq(int parentBoardSeq) {
		this.parentBoardSeq = parentBoardSeq;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public Timestamp getWriteDate() {
		return writeDate;
	}

	public void setWriteDate(Timestamp writeDate) {
		this.writeDate = writeDate;
	}

	public int getParentReplySeq() {
		return parentReplySeq;
	}

	public void setParentReplySeq(int parentReplySeq) {
		this.parentReplySeq = parentReplySeq;
	}
	
}
