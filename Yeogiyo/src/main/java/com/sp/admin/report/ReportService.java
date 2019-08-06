package com.sp.admin.report;

import java.util.List;
import java.util.Map;

public interface ReportService {
	
	public List<Report> listReport(Map<String, Object> map);
	public int dataCount(Map<String, Object> map);
	
	public Report readReport(int reviewNum);
	public Report preReadReport(Map<String, Object> map);
	public Report nextReadReport(Map<String, Object> map);
	
	public void deleteReview(int reviewNum, String mode) throws Exception;
	
}
