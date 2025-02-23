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

import board.dto.BoardDTO;

public class BoardDAO {

   // 1. 싱글톤 패턴
   public static BoardDAO instance;

   // 2. 싱글톤 패턴
   public synchronized static BoardDAO getInstance() {
      if (instance == null) {
         instance = new BoardDAO();
      }
      return instance;
   }

   // Tomcat 서버의 DBCP를 사용하여 커넥션을 가져오는 코드(DB 연결 생성)
   private Connection getConnection() throws Exception {
      Context ctx = new InitialContext(); //
      DataSource ds = (DataSource) ctx.lookup("java:comp/env/jdbc/orcl");
      return ds.getConnection();
   }
   
   // 전체 게시판 목록 출력(start 부터 end 갯수만 나오게 해놨음-관리자용)
      public List<BoardDTO> selectFromTotalBoardList(int start, int end) throws Exception {
         String sql = "SELECT * FROM (SELECT board.*,(SELECT COUNT(*) FROM reply WHERE parentboardseq = board.seq) AS boardreplycount, ROW_NUMBER() OVER (ORDER BY board.seq DESC) AS rnum FROM board) sub WHERE rnum BETWEEN ? AND ?";
         try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
            pstat.setInt(1, start);
            pstat.setInt(2, end);

            try (ResultSet rs = pstat.executeQuery();) {
               List<BoardDTO> totalList = new ArrayList<>();
               while (rs.next()) {
                  int seq = rs.getInt("seq");
                  String writer = rs.getString("writer");
                  String title = rs.getString("title");
                  String contents = rs.getString("contents");
                  Timestamp writeDate = rs.getTimestamp("writedate");
                  int viewCount = rs.getInt("viewcount");
                  int isAdmin = rs.getInt("isadmin");
                  String boardCategory = rs.getString("boardcategory");
                  int boardReplyCount = rs.getInt("boardreplycount");
                  
                  BoardDTO bdto = new BoardDTO(seq, writer, title, contents, writeDate, viewCount, isAdmin,
                        boardCategory,boardReplyCount);
                  totalList.add(bdto);
               }
               return totalList;
            }
         }
      }
      
      // 게시글 총 갯수 확인(관리자용)
      public int getRecordTotalBoardListCount() throws Exception {
         String sql = "select count(*) from board";
         try (Connection con = this.getConnection();
               PreparedStatement pstat = con.prepareStatement(sql);
               ResultSet rs = pstat.executeQuery();) {
            rs.next();
            return rs.getInt(1);
         }
      }
   

   // 공지게시글 총 갯수 확인
   public int getRecordTotalCountNotice() throws Exception {
      String sql = "select count(*) from board where writer ='admin'";
      try (Connection con = this.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql);
            ResultSet rs = pstat.executeQuery();) {
         rs.next();
         return rs.getInt(1);
      }
   }

   // 자유게시글 총 갯수 확인
   public int getRecordTotalCountGeneral() throws Exception {
      String sql = "select count(*) from board where writer !='admin'";
      try (Connection con = this.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql);
            ResultSet rs = pstat.executeQuery();) {
         rs.next();
         return rs.getInt(1);
      }
   }

   // 공지게시글 검색 된 내용 총 갯수 확인
   public int getRecordTotalCountNoticeSearch(String searchNoticeKeyword,String searchNoticeCategory) throws Exception {
      String sql = "select count(*) from board where writer ='admin' and "+searchNoticeCategory+" like '%" + searchNoticeKeyword + "%'";
      try (Connection con = this.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql);
            ResultSet rs = pstat.executeQuery();) {
         rs.next();
         return rs.getInt(1);
      }
   }

   // 자유게시글 검색 된 내용 총 갯수 확인
   public int getRecordTotalCountGeneralSearch(String searchGeneralKeyword,String searchGeneralCategory) throws Exception {
      String sql = "select count(*) from board where writer !='admin' and "+searchGeneralCategory+" like '%" + searchGeneralKeyword + "%'";
      try (Connection con = this.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql);
            ResultSet rs = pstat.executeQuery();) {
         rs.next();
         return rs.getInt(1);
      }
   }

   // 공지게시판 목록 출력
   public List<BoardDTO> selectFromToNotice(int start, int end) throws Exception {
      String sql = "SELECT * FROM (SELECT board.*,(SELECT COUNT(*) FROM reply WHERE parentboardseq = board.seq) AS boardreplycount, ROW_NUMBER() OVER (ORDER BY board.seq DESC) AS rnum FROM board WHERE writer = 'admin') sub WHERE rnum BETWEEN ? AND ?";
      try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
         pstat.setInt(1, start);
         pstat.setInt(2, end);

         try (ResultSet rs = pstat.executeQuery();) {
            List<BoardDTO> noticeList = new ArrayList<>();
            while (rs.next()) {
               int seq = rs.getInt("seq");
               String writer = rs.getString("writer");
               String title = rs.getString("title");
               String contents = rs.getString("contents");
               Timestamp writeDate = rs.getTimestamp("writedate");
               int viewCount = rs.getInt("viewcount");
               int isAdmin = rs.getInt("isadmin");
               String boardCategory = rs.getString("boardcategory");
               int boardReplyCount = rs.getInt("boardreplycount");
               
               BoardDTO bdto = new BoardDTO(seq, writer, title, contents, writeDate, viewCount, isAdmin,
                     boardCategory,boardReplyCount);
               noticeList.add(bdto);
            }
            return noticeList;
         }
      }
   }

   // 자유게시판 목록 출력
   public List<BoardDTO> selectFromToGeneral(int start, int end) throws Exception {
      String sql = "SELECT * FROM (SELECT board.*,(SELECT COUNT(*) FROM reply WHERE parentboardseq = board.seq) AS boardreplycount, ROW_NUMBER() OVER (ORDER BY board.seq DESC) AS rnum FROM board WHERE writer != 'admin') sub WHERE rnum BETWEEN ? AND ?";
      
      try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
         pstat.setInt(1, start);
         pstat.setInt(2, end);
         try (ResultSet rs = pstat.executeQuery();) {
            List<BoardDTO> generalList = new ArrayList<>();
            while (rs.next()) {
               int seq = rs.getInt("seq");
               String writer = rs.getString("writer");
               String title = rs.getString("title");
               String contents = rs.getString("contents");
               Timestamp writeDate = rs.getTimestamp("writedate");
               int viewCount = rs.getInt("viewcount");
               int isAdmin = rs.getInt("isadmin");
               String boardCategory = rs.getString("boardcategory");
               int boardReplyCount = rs.getInt("boardreplycount");
               
               BoardDTO bdto = new BoardDTO(seq, writer, title, contents, writeDate, viewCount, isAdmin,
                     boardCategory,boardReplyCount);
               generalList.add(bdto);
            }
            return generalList;
         }
      }
   }

   // 공지게시판 검색 목록 출력
   public List<BoardDTO> searchFromToNotice(int start, int end, String searchNoticeKeyword,String searchNoticeCategory) throws Exception {
      String sql = "SELECT * FROM (SELECT board.*,(SELECT COUNT(*) FROM reply WHERE parentboardseq = board.seq) AS boardreplycount, ROW_NUMBER() OVER (ORDER BY board.seq DESC) AS rnum FROM board WHERE writer = 'admin' and "+searchNoticeCategory+" like '%"+searchNoticeKeyword+"%') sub WHERE rnum BETWEEN ? AND ?";
      try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
         pstat.setInt(1, start);
         pstat.setInt(2, end);
         try (ResultSet rs = pstat.executeQuery();) {
            List<BoardDTO> noticeSearchList = new ArrayList<>();
            while (rs.next()) {
               int seq = rs.getInt("seq");
               String writer = rs.getString("writer");
               String title = rs.getString("title");
               String contents = rs.getString("contents");
               Timestamp writeDate = rs.getTimestamp("writedate");
               int viewCount = rs.getInt("viewcount");
               int isAdmin = rs.getInt("isadmin");
               String boardCategory = rs.getString("boardcategory");
               int boardReplyCount = rs.getInt("boardreplycount");
               
               BoardDTO bdto = new BoardDTO(seq, writer, title, contents, writeDate, viewCount, isAdmin,
                     boardCategory,boardReplyCount);
               noticeSearchList.add(bdto);
            }
            return noticeSearchList;
         }
      }
   }

   // 자유게시판 검색 목록 출력
   public List<BoardDTO> searchFromToGeneral(int start, int end, String searchGeneralKeyword, String searchGeneralCategory) throws Exception {
      String sql = "SELECT * FROM (SELECT board.*,(SELECT COUNT(*) FROM reply WHERE parentboardseq = board.seq) AS boardreplycount, ROW_NUMBER() OVER (ORDER BY board.seq DESC) AS rnum FROM board WHERE writer != 'admin' and "+searchGeneralCategory+" like '%"+searchGeneralKeyword+"%') sub WHERE rnum BETWEEN ? AND ?";
      try (Connection con = this.getConnection(); PreparedStatement pstat = con.prepareStatement(sql);) {
         pstat.setInt(1, start);
         pstat.setInt(2, end);
         try (ResultSet rs = pstat.executeQuery();) {
            List<BoardDTO> generalSearchList = new ArrayList<>();
            while (rs.next()) {
               int seq = rs.getInt("seq");
               String writer = rs.getString("writer");
               String title = rs.getString("title");
               String contents = rs.getString("contents");
               Timestamp writeDate = rs.getTimestamp("writedate");
               int viewCount = rs.getInt("viewcount");
               int isAdmin = rs.getInt("isadmin");
               String boardCategory = rs.getString("boardcategory");
               int boardReplyCount = rs.getInt("boardreplycount");
               
               BoardDTO bdto = new BoardDTO(seq, writer, title, contents, writeDate, viewCount, isAdmin,
                     boardCategory,boardReplyCount);
               
               generalSearchList.add(bdto);
            }
            return generalSearchList;
         }
      }
   }
   
   //게시글 조회수 증가 메서드
   public int incrementViewCount(int seq)throws Exception {
       String sql = "UPDATE board SET viewcount = viewcount + 1 WHERE seq = ?";
       try(
            Connection con = this.getConnection();
            PreparedStatement pstat = con.prepareStatement(sql);
            ){
          pstat.setInt(1, seq);
          int result = pstat.executeUpdate();
          
          return result;
          }
       
       }
   
   // 하나의 게시글 불러오는 메소드 for detail.jsp
      public BoardDTO selectBySeq(int seq) throws Exception{
         String sql = "SELECT * FROM BOARD WHERE SEQ = ?";
         
         try(Connection con = this.getConnection();
               PreparedStatement pstat = con.prepareStatement(sql)){
            pstat.setInt(1, seq);
            
            try(ResultSet rs = pstat.executeQuery();){
               rs.next();
               String writer = rs.getString("WRITER");
               String title = rs.getString("TITLE");
               String contents = rs.getString("CONTENTS");
               Timestamp writeDate = rs.getTimestamp("WRITEDATE");
               int viewCount = rs.getInt("VIEWCOUNT");
               int isAdmin = rs.getInt("ISADMIN");
               String boardCategory = rs.getString("BOARDCATEGORY");
               
               return new BoardDTO(seq, writer, title, contents, writeDate, viewCount, isAdmin, boardCategory);
            }
         }
      }
      
      // 게시글 삭제 메서드
      public int deleteBySeq(int seq) throws Exception{
         String sql = "DELETE FROM BOARD WHERE SEQ = ?";
         try(Connection con = this.getConnection();
               PreparedStatement pstat = con.prepareStatement(sql);){
            
            pstat.setInt(1, seq);
            return pstat.executeUpdate();
         }
      }
      
      // 게시글 수정 메서드
      public int updateByBoardList(int seq,String title,String contents) throws Exception{
         String sql = "update board set title=?,contents=?,writedate=sysdate WHERE SEQ = ?";
         try(Connection con = this.getConnection();
               PreparedStatement pstat = con.prepareStatement(sql);){
            
            pstat.setInt(1, seq);
            pstat.setString(2, title);
            pstat.setString(3, contents);
            return pstat.executeUpdate();
         }
      }
      
   
   
   
   

//class 끝   
}
