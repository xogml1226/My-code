package com.sp.admin.manage;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;
import com.sp.user.member.SessionInfo;
import com.sp.user.notice.Notice;
import com.sp.user.notice.NoticeService;

@Controller("admin.notice.noticeController")
public class NoticeController {

	@Autowired
	private NoticeService service;
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/admin/notice/list")
	public String noticeList(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			HttpSession session, Model model) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null || info.getEnabled()!=3) {
			return "redirect:/user/member/noAuthorized";
		}
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
		String listUrl=cp+"/admin/notice/list";
		String articleUrl=cp+"/admin/notice/article?page="+current_page;
		
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("toplist", toplist);
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("articleUrl", articleUrl);
		
		return ".admin.notice.list";
	}
	
	@RequestMapping(value="/admin/notice/created", method=RequestMethod.GET)
	public String createdForm(Model model, HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info.getEnabled()!=3) {
			return "redirect:/admin/notice/list";
		}
		
		model.addAttribute("mode", "created");
		return ".admin.notice.created";
	}
	
	@RequestMapping(value="/admin/notice/created", method=RequestMethod.POST)
	public String createdSubmit(Notice dto) {
		
		try {
			service.insertNotice(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/admin/notice/list";
	}
	
	@RequestMapping(value="/admin/notice/article")
	public String noticeArticle(@RequestParam int noticeNum,
								@RequestParam String page, Model model) {
		
		Notice dto=service.readNotice(noticeNum);
		if(dto==null) {
			return "redirect:/admin/notice/list?page="+page;
		}
		
		dto.setNoticeContent(dto.getNoticeContent().replaceAll("\n", "<br>"));
		Notice pdto=service.preReadNotice(noticeNum);
		Notice ndto=service.nextReadNotice(noticeNum);
		
		model.addAttribute("dto", dto);
		model.addAttribute("pdto", pdto);
		model.addAttribute("ndto", ndto);
		model.addAttribute("page", page);
		
		return ".admin.notice.article";
	}
	
	@RequestMapping(value="/admin/notice/update", method=RequestMethod.GET)
	public String updateForm(@RequestParam int noticeNum,
							@RequestParam String page,
							HttpSession session, Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info.getEnabled()!=3)
			return "redirect:/admin/notice/list?page="+page;
		
		Notice dto=service.readNotice(noticeNum);
		if(dto==null) {
			return "redirect:/admin/notice/list?page="+page;
		}
		
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		model.addAttribute("dto", dto);
		
		return ".admin.notice.created";
	}
	
	@RequestMapping(value="/admin/notice/update", method=RequestMethod.POST)
	public String updateSubmit(Notice dto,
							@RequestParam String page,
							HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info.getEnabled()!=3)
			return "redirect:/admin/notice/list?page="+page;
		
		try {
			service.updateNotice(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/admin/notice/list?page="+page;
	}
	
	@RequestMapping(value="/admin/notice/delete")
	public String deleteNotice(@RequestParam int noticeNum,
								@RequestParam String page,
								HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info.getEnabled()!=3)
			return "redirect:/admin/notice/list?page="+page;
		try {
			service.deleteNotice(noticeNum);
		} catch (Exception e) {
		}
		return "redirect:/admin/notice/list?page="+page;
	}
	
}
