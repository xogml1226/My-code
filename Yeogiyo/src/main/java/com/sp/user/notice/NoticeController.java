package com.sp.user.notice;

import java.text.SimpleDateFormat;
import java.util.Date;
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

@Controller("user.notice.noticeController")
public class NoticeController {

	@Autowired
	private NoticeService service;
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/user/notice/list")
	public String noticeList(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req, Model model) throws Exception {
		int rows=10;
		int total_page=0;
		int dataCount=service.dataCount();
		
		if(dataCount!=0)
			total_page=util.pageCount(rows, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		List<Notice> toplist=null;
		if(current_page==1)
			toplist=service.listNoticeTop();
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		Map<String, Object> map=new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		List<Notice> list=service.listNotice(map);
		
		Date edate=new Date();
		long gap;
		int listNum, n=0;
		for(Notice dto:list) {
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			
			SimpleDateFormat sdfm=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date sdate=sdfm.parse(dto.getNoticeCreated());
			gap=(edate.getTime() - sdate.getTime()) / (24 *60*60*1000);
			dto.setGap(gap);
			dto.setNoticeCreated(dto.getNoticeCreated().substring(0, 10));
			n++;
		}
		String cp=req.getContextPath();
		String listUrl=cp+"/user/notice/list";
		String articleUrl=cp+"/user/notice/article?page="+current_page;
		
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("toplist", toplist);
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		return ".user.notice.list";
	}
	
	@RequestMapping(value="/user/notice/article")
	public String noticeArticle(@RequestParam int noticeNum,
								@RequestParam String page, Model model) {
		
		Notice dto=service.readNotice(noticeNum);
		if(dto==null) {
			return "redirect:/user/notice/list?page="+page;
		}
		
		dto.setNoticeContent(dto.getNoticeContent().replaceAll("\n", "<br>"));
		Notice pdto=service.preReadNotice(noticeNum);
		Notice ndto=service.nextReadNotice(noticeNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("pdto", pdto);
		model.addAttribute("ndto", ndto);
		model.addAttribute("page", page);
		
		return ".user.notice.article";
	}
	
}
