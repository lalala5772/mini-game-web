package board.dto;

import java.sql.Timestamp;

public class FilesDTO {
	int seq;
	int parentSeq;
	String id;
	String originName;
	String fileName;
	Timestamp uploadDate;
	
	public FilesDTO(int seq, int parentSeq, String id, String originName, String fileName, Timestamp uploadDate) {
		super();
		this.seq = seq;
		this.parentSeq = parentSeq;
		this.id = id;
		this.originName = originName;
		this.fileName = fileName;
		this.uploadDate = uploadDate;
	}

	public int getSeq() {
		return seq;
	}

	public int getParentSeq() {
		return parentSeq;
	}

	public String getId() {
		return id;
	}

	public String getOriginName() {
		return originName;
	}

	public String getFileName() {
		return fileName;
	}

	public Timestamp getUploadDate() {
		return uploadDate;
	}

}
