package board.dto;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;

public class BoardDTO {
	
	private int seq;
	private String writer;
	private String title;
	private String contents;
	private Timestamp writeDate;
	private int viewCount;
	private int isAdmin;
	private String boardCategory;
	//타임스탬프로 받아온 시간을 메서드에서 변환하여 string 타입으로 반환.
	private String dateWrite;
	//게시글 당 댓글 수 저장변수
	private int boardReplyCount;
	
	public BoardDTO() {
		
	}

	public BoardDTO(int seq, String writer, String title, String contents, Timestamp writeDate, int viewCount,
			int isAdmin, String boardCategory) {
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.contents = contents;
		this.writeDate = writeDate;
		this.viewCount = viewCount;
		this.isAdmin = isAdmin;
		this.boardCategory = boardCategory;
	}
	
	public BoardDTO(int seq, String writer, String title, String contents, Timestamp writeDate, int viewCount,
			int isAdmin, String boardCategory, int boardReplyCount) {
		super();
		this.seq = seq;
		this.writer = writer;
		this.title = title;
		this.contents = contents;
		this.writeDate = writeDate;
		this.viewCount = viewCount;
		this.isAdmin = isAdmin;
		this.boardCategory = boardCategory;
		this.boardReplyCount = boardReplyCount;
	}
	
	/* 데이터베이스에서 가지고 온 게시글 저장시간 커스텀 후 출력 */
	public String getDateWrite() {
        long conData = this.writeDate.getTime(); // 데이터베이스에서 가지고온 시간
        long currentTime = System.currentTimeMillis(); //현재시간
        long getTime = (currentTime - conData)/1000; // (현재시간 - 데이터베이스에서 가지고온 시간)/1000
        if(getTime < 60) {
            return "방금 전";
        }else if(getTime < 300) {
            return "5분 이내";
        }else if(getTime < 3600) {
            return "1시간 이내";
        }else {
        	//SimpleDateFormat은 .format에 들어간 데이터를 SimpleDateFormat("YYYY-MM-dd")패턴으로 변경
            this.dateWrite = new SimpleDateFormat("YYYY-MM-dd").format(conData);
            
            return dateWrite;
        }
    }

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getWriter() {
		return writer;
	}

	public void setWriter(String writer) {
		this.writer = writer;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
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

	public int getViewCount() {
		return viewCount;
	}

	public void setViewCount(int viewCount) {
		this.viewCount = viewCount;
	}

	public int getIsAdmin() {
		return isAdmin;
	}

	public void setIsAdmin(int isAdmin) {
		this.isAdmin = isAdmin;
	}

	public String getBoardCategory() {
		return boardCategory;
	}

	public void setBoardCategory(String boardCategory) {
		this.boardCategory = boardCategory;
	}
	
	public int getBoardReplyCount() {
        return boardReplyCount;
    }
	
	public void setBoardReplyCount(int boardReplyCount) {
		this.boardReplyCount = boardReplyCount;
	}
}
