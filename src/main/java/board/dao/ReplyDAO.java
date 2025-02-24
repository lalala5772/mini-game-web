package board.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.dto.ReplyDTO;

public class ReplyDAO {
private static ReplyDAO instance;
	
	private ReplyDAO() {
		
	}
	
	public synchronized static ReplyDAO getInstance() {
		if(instance == null) {
			instance = new ReplyDAO();
		}
		return instance;
	}
	
	private Connection getConnection() throws Exception{
		Context ctx = new InitialContext();
		DataSource ds = (DataSource)ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}
	
	// 댓글 목록 불러오기
	public List<ReplyDTO> selectByParentBoardSeq(int parentBoardSeq) throws Exception{
		String sql = "SELECT * FROM REPLY WHERE PARENTBOARDSEQ = ? ORDER BY SEQ";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, parentBoardSeq);
			try(ResultSet rs = pstat.executeQuery();){
				List<ReplyDTO> replyList = new ArrayList();
				while(rs.next()) {
					int seq = rs.getInt("SEQ");
					String writer = rs.getString("WRITER");
					String contents = rs.getString("CONTENTS");
					Timestamp writeDate = rs.getTimestamp("WRITEDATE");
					int parentReplySeq = rs.getInt("PARENTREPLYSEQ");
					
					replyList.add(new ReplyDTO(seq, parentBoardSeq, writer, contents, writeDate, parentReplySeq));
				}
				return replyList;
			}
		}
	}
	
	// 댓글 등록
	public int insert(ReplyDTO dto) throws Exception{
		// SEQ	PARENTBOARDSEQ  WRITER  CONTENTS  WRITEDATE  PARENTREPLYSEQ
		String sql = "INSERT INTO REPLY VALUES(SEQ_REPLY.NEXTVAL, ?, ?, ?, SYSDATE, NULL)";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, dto.getParentBoardSeq());
			pstat.setString(2, dto.getWriter());
			pstat.setString(3, dto.getContents());
			
			return pstat.executeUpdate();
		}
	}
	
	// 댓글 삭제
	public int deleteBySeq(int seq) throws Exception{
		String sql = "DELETE FROM REPLY WHERE SEQ = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			pstat.setInt(1, seq);
			return pstat.executeUpdate();
		}
	}
	
	// 댓글 수정
	public int updateBySeq(ReplyDTO dto) throws Exception{
		String sql = "UPDATE REPLY SET CONTENTS = ? WHERE SEQ = ?";
		try(Connection con = this.getConnection();
				PreparedStatement pstat = con.prepareStatement(sql);){
			
			pstat.setString(1, dto.getContents());
			pstat.setInt(2, dto.getSeq());
			
			return pstat.executeUpdate();
		}
	}
}
