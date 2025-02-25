package ban.dto;

import java.sql.Timestamp;

public class BanDTO {
	private int seq;
	private String id;
	private String isBan;
	private Timestamp banDate;
	private Timestamp banUntill;
	private int banCount;
	public int getSeq() {
		return seq;
	}
	public void setSeq(int seq) {
		this.seq = seq;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getIsBan() {
		return isBan;
	}
	public void setIsBan(String isBan) {
		this.isBan = isBan;
	}
	public Timestamp getBanDate() {
		return banDate;
	}
	public void setBanDate(Timestamp banDate) {
		this.banDate = banDate;
	}
	public Timestamp getBanUntill() {
		return banUntill;
	}
	public void setBanUntill(Timestamp banUntill) {
		this.banUntill = banUntill;
	}
	public int getBanCount() {
		return banCount;
	}
	public void setBanCount(int banCount) {
		this.banCount = banCount;
	}
	public BanDTO(int seq, String id, String isBan, Timestamp banDate, Timestamp banUntill, int banCount) {
		super();
		this.seq = seq;
		this.id = id;
		this.isBan = isBan;
		this.banDate = banDate;
		this.banUntill = banUntill;
		this.banCount = banCount;
	}
	public BanDTO() {
		super();
	}
	
	

}
