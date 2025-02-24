package board.controller;

import java.io.DataInputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import board.dao.FilesDAO;
import utils.Statics;

@WebServlet("*.files")
public class FilesController extends HttpServlet {

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		
		String cmd = request.getRequestURI();

		System.out.print("클라이언트 요청: " + cmd);

		//dao 인스턴스 생성
		FilesDAO fdao = FilesDAO.getInstance();

		try {
			//요청은 필요에 따라 추가/삭제 
			if (cmd.equals("/download.files")) {
				String fileName = request.getParameter("fileName");
				String originName = request.getParameter("originName");
				String path = Statics.filePath;
				System.out.println(fileName);

				File target = new File(path + "/" + fileName);
				byte[] fileContents = new byte[(int)target.length()];
				
				originName = new String(originName.getBytes("UTF-8"), "ISO-8859-1");
				response.reset();
				response.setHeader("Content-Disposition", "attachment; filename="+originName);
				
				try(DataInputStream dis = new DataInputStream(new FileInputStream(target));
						ServletOutputStream sos = response.getOutputStream();){
					
					dis.readFully(fileContents);
					
					sos.write(fileContents);
					sos.flush();
				}
			} else if(cmd.equals("/delete.files")) {
				
				int fileSeq = Integer.parseInt(request.getParameter("seq"));
				System.out.println(fileSeq);
				
				int result = fdao.deleteFile(fileSeq);
				
			}
			
		} catch(Exception e) {
			e.printStackTrace();
		}

	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}
}