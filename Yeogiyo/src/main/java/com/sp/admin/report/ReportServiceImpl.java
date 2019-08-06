package com.sp.admin.report;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sp.common.dao.CommonDAO;

@Service("admin.report.reportService")
public class ReportServiceImpl implements ReportService {

	@Autowired
	private CommonDAO dao;
	
	@Override
	public int dataCount(Map<String, Object> map) {
		int result=0;
		try {
			result=dao.selectOne("admin.report.dataCount", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
	@Override
	public List<Report> listReport(Map<String, Object> map) {
		List<Report> list=null;
		try {
			list=dao.selectList("admin.report.listReport", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}

	@Override
	public Report readReport(int reviewNum) {
		Report dto=null;
		try {
			dto=dao.selectOne("admin.report.readReport", reviewNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	@Override
	public Report preReadReport(Map<String, Object> map) {
		Report dto=null;
		try {
			dto=dao.selectOne("admin.report.preReadReport", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public Report nextReadReport(Map<String, Object> map) {
		Report dto=null;
		try {
			dto=dao.selectOne("admin.report.nextReadReport", map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}

	@Override
	public void deleteReview(int reviewNum, String mode) throws Exception {
		try {
			if(mode.equals("report")) {
				dao.deleteData("admin.report.deleteReport", reviewNum);
			} else if(mode.equals("review")) {
				dao.deleteData("admin.report.deleteReport", reviewNum);
				dao.deleteData("admin.report.deleteReply", reviewNum);
				dao.deleteData("admin.report.deleteReviewLike", reviewNum);
				dao.deleteData("admin.report.deleteReview", reviewNum);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

	

}
