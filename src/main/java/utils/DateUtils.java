package utils;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

public class DateUtils {
	
	public static List<String> getLineChartLabels (){
		List<String> labels = new ArrayList<>();;
		SimpleDateFormat sdf = new SimpleDateFormat("M월");
		
		for (int i = 4 ; i >= 0 ; i --) {
			Calendar cal = Calendar.getInstance();
			cal.add(Calendar.MONTH, -i); 	// 현재 날짜부터 i개월 전으로 설정
			labels.add(sdf.format(cal.getTime()));
		}
		return labels;
	}
	
}