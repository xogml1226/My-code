package com.sp.user.faq;

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

@Controller("user.faq.faqController")
public class FaqController {
	
	@Autowired
	private FaqService service;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/user/faq/list")
	public String faqlist(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			Model model) throws Exception {
		int rows=10;
		int total_page=0;
		int dataCount=service.dataCount();
		
		if(dataCount!=0)
			total_page=util.pageCount(rows, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		Map<String, Object> map=new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		List<Faq> list=service.listFaq(map);
		
		String cp=req.getContextPath();
		String listUrl=cp+"/user/faq/list";
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("list", list);
		return ".user.faq.list";
	}
}

