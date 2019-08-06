package com.sp.admin.report;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;

@Controller("admin.report.reportController")
public class ReportController {

	@Autowired
	private ReportService service;
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/admin/report/list")
	public String listReport(@RequestParam(value="page", defaultValue="1") int current_page,
							@RequestParam(defaultValue="all") String condition,
							@RequestParam(defaultValue="") String keyword,
							HttpServletRequest req, Model model) throws Exception {
		int rows=10;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "UTF-8");
		}
		
		Map<String, Object> map=new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount=service.dataCount(map);
		if(dataCount!=0)
			total_page=util.pageCount(rows, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Report> list=service.listReport(map);
		
		int listNum, n=0;
		for(Report dto:list) {
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp=req.getContextPath();
		String query="";
		String listUrl=cp+"/admin/report/list";
		String articleUrl=cp+"/admin/report/article?page="+current_page;
		
		if(keyword.length()!=0) {
			query+="condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		if(query.length()!=0) {
			listUrl=cp+"/admin/report/list?"+query;
			articleUrl=cp+"/admin/report/article?page="+current_page+"&"+query;
		}
		
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".admin.report.list";
	}
	
	@RequestMapping(value="/admin/report/article")
	public String readReport(@RequestParam int reviewNum,
							@RequestParam String page,
							@RequestParam(defaultValue="all") String condition,
							@RequestParam(defaultValue="") String keyword,
							Model model) throws Exception {
		keyword=URLDecoder.decode(keyword, "UTF-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		Report dto=service.readReport(reviewNum);
		if(dto==null) {
			return "redirect:/admin/report/list?"+query;
		}
		
		dto.setReviewContent(dto.getReviewContent().replaceAll("\n", "<br>"));
		dto.setReportContent(dto.getReportContent().replaceAll("\n", "<br>"));
		
		Map<String, Object> map=new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("reviewNum", reviewNum);
		
		Report pdto=service.preReadReport(map);
		Report ndto=service.nextReadReport(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("pdto", pdto);
		model.addAttribute("ndto", ndto);
		
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".admin.report.article";
	}
	
	@RequestMapping(value="/admin/report/delete")
	public String deleteReivew(@RequestParam int reviewNum,
							@RequestParam String page,
							@RequestParam(defaultValue="all") String condition,
							@RequestParam(defaultValue="") String keyword,
							@RequestParam String mode) throws Exception {
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		try {
			service.deleteReview(reviewNum, mode);
		} catch (Exception e) {
		}
		return "redirect:/admin/report/list?"+query;
	}
}
