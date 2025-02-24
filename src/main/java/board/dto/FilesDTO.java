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

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public int getParentSeq() {
		return parentSeq;
	}

	public void setParentSeq(int parentSeq) {
		this.parentSeq = parentSeq;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getOriginName() {
		return originName;
	}

	public void setOriginName(String originName) {
		this.originName = originName;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Timestamp getUploadDate() {
		return uploadDate;
	}

	public void setUploadDate(Timestamp uploadDate) {
		this.uploadDate = uploadDate;
	}

}
