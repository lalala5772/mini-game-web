package admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import admin.dao.AdminDAO;

@WebServlet("*.chartdata")
public class ChartDataController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String cmd = request.getRequestURI();
		System.out.println(cmd);
		AdminDAO dao = AdminDAO.getInstance();
		
		if(cmd.equals("/linechart.chartdata")) {
			try {
				List<String> lineChartData = dao.getLineChartData();
				Gson g = new Gson();
				String json = g.toJson(lineChartData);
				response.setContentType("/application/json");
				response.setCharacterEncoding("UTF8");
				response.getWriter().print(json);
				response.getWriter().flush();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(cmd.equals("/doughnutchart.chartdata")) {
			try {
				List<String> doughnutChartData = dao.getDoughnutChartData();
				Gson g = new Gson();
				String json = g.toJson(doughnutChartData);
				response.setContentType("/application/json");
				response.setCharacterEncoding("UTF8");
				response.getWriter().print(json);
				response.getWriter().flush();
			} catch (Exception e) {
				e.printStackTrace();
			}
		} else if(cmd.equals("/barchart.chartdata")) {
				try {
					List<String> barChartData = dao.getBarChartData();
					Gson g = new Gson();
					String json = g.toJson(barChartData);
					response.setContentType("/application/json");
					response.setCharacterEncoding("UTF8");
					response.getWriter().print(json);
					response.getWriter().flush();
				} catch (Exception e) {
					e.printStackTrace();
				}
		} else if(cmd.equals("")) {
			
		}
	
	
	}
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
