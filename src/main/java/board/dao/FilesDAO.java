package board.dao;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import board.dto.FilesDTO;
import utils.Statics;

public class FilesDAO {
	private static FilesDAO instance;

	private FilesDAO() {

	}

	public synchronized static FilesDAO getInstance() {
		if (instance == null) {
			instance = new FilesDAO();
		}
		return instance;
	}

	private Connection getConnection() throws Exception {
		Context ctx = new InitialContext();
		DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
		return ds.getConnection();
	}

	// 파일 업로드
	public int insert(FilesDTO dto) throws Exception {
		String sql = "INSERT INTO FILES VALUES(SEQ_FILES.NEXTVAL, ?, ?, ?, ?, SYSDATE)";

		try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {

			pstat.setInt(1, dto.getParentSeq());
			pstat.setString(2, dto.getId());
			pstat.setString(3, dto.getOriginName());
			pstat.setString(4, dto.getFileName());

			return pstat.executeUpdate();
		}
	}

	// 파일 목록 받기
	public List<FilesDTO> getFilesBySeq(int seq) throws Exception {
		String sql = "SELECT * FROM FILES WHERE PARENTSEQ = ? ORDER BY 1 DESC";

		try (Connection con = this.getConnection(); PreparedStatement stat = con.prepareStatement(sql);) {
			stat.setInt(1, seq);
			try (ResultSet rs = stat.executeQuery();) {
				List<FilesDTO> fileList = new ArrayList<>();
				while (rs.next()) {
					int parentSeq = rs.getInt("PARENTSEQ");
					String id = rs.getString("ID");
					String originName = rs.getString("ORIGINNAME");
					String fileName = rs.getString("FILENAME");
					Timestamp uploadDate = rs.getTimestamp("UPLOADDATE");

					fileList.add(new FilesDTO(seq, parentSeq, id, originName, fileName, uploadDate));
				}
				return fileList;
			}
		}
	}

	// 파일 삭제 메소드
	public int deleteFile(int fileSeq) throws Exception {
		String sql = "DELETE FROM files WHERE seq = ?";
		try (Connection con = this.getConnection(); PreparedStatement stat = con.prepareStatement(sql);) {
			stat.setInt(1, fileSeq);
			int result = stat.executeUpdate();
			// 실제 파일 삭제
			String filePath = Statics.filePath;
			String fileName = this.getFileNameBySeq(fileSeq);
			File file = new File(filePath + "/" + fileName);
			if (file.exists()) {
				file.delete();
			}

			return result;

		}
	}

	// 파일 이름 가져오기 메소드
	public String getFileNameBySeq(int fileSeq) throws Exception {
		String sql = "SELECT filename FROM files WHERE seq = ?";
		try (Connection con = this.getConnection(); PreparedStatement stat = con.prepareStatement(sql);) {
			stat.setInt(1, fileSeq);
			try (ResultSet rs = stat.executeQuery();) {
				String fileName = null;
				if (rs.next()) {
					fileName = rs.getString("fileName");
				}
				return fileName;
			}
		}
	}

}
