package admin.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;

import utils.DateUtils;

@WebServlet("/chartdatecontroller")
public class ChartDateController extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		List<String> LineChartLabels = DateUtils.getLineChartLabels();
		
		Gson g = new Gson();
		String json = g.toJson(LineChartLabels);
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF8");
		
		response.getWriter().print(json);
		response.getWriter().flush();
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}

}
