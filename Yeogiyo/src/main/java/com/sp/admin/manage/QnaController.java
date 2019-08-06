package com.sp.admin.manage;

import java.net.URLDecoder;
import java.net.URLEncoder;
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
import com.sp.user.qna.Qna;
import com.sp.user.qna.QnaService;

@Controller("admin.qna.qnaController")
public class QnaController {
	
	@Autowired
	private QnaService service;
	
	@Autowired
	private MyUtil util;

	@RequestMapping(value="/admin/qna/list")
	public String qnalist(@RequestParam(value="page", defaultValue="1") int current_page,
						@RequestParam(defaultValue="all") String condition,
						@RequestParam(defaultValue="") String keyword,
						HttpServletRequest req,
						HttpSession session, Model model) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null || info.getEnabled()!=3) {
			return "redirect:/user/member/noAuthorized";
		}
		
		int total_page;
		int dataCount;
		int rows=10;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "UTF-8");
		}
		Map<String, Object> map=new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		dataCount=service.dataCount(map);
		total_page=util.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Qna> list=service.listQna(map);
		
		Date edate=new Date();
		long gap;
		int listNum, n=0;
		for(Qna dto:list) {
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			
			SimpleDateFormat sdfm=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date sdate=sdfm.parse(dto.getQnaCreated());
			
			gap=(edate.getTime()-sdate.getTime()) / (24 *60*60*1000);
			dto.setGap(gap);
			
			dto.setQnaCreated(dto.getQnaCreated().substring(0, 10));
			n++;
		}
		String cp=req.getContextPath();
		String query="";
		String listUrl=cp+"/admin/qna/list";
		String articleUrl=cp+"/admin/qna/article?page="+current_page;
		
		if(keyword.length()!=0) {
			query+="condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		 if(query.length()!=0) {
	        	listUrl = cp+"/admin/qna/list?" + query;
	        	articleUrl = cp+"/admin/qna/article?page=" + current_page + "&"+ query;
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
		
		return ".admin.qna.list";
	}
	
	
	@RequestMapping(value="/admin/qna/created", method=RequestMethod.GET)
	public String qnaCreatedForm(HttpSession session, Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/user/member/login";
		}
		model.addAttribute("mode", "created");
		return ".admin.qna.created";
	}
	
	@RequestMapping(value="/admin/qna/created", method=RequestMethod.POST)
	public String qnaCreatedSubmit(Qna dto, HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/user/member/login";
		}
		try {
			dto.setUserId(info.getUserId());
			service.insertQna(dto, "created");
		} catch (Exception e) {
		}
		return "redirect:/admin/qna/list";
	}
	
	@RequestMapping(value="/admin/qna/article")
	public String qnaArticle(@RequestParam int qnaNum,
							@RequestParam String page,
							@RequestParam(defaultValue="all") String condition,
							@RequestParam(defaultValue="") String keyword,
							Model model) throws Exception {
		keyword=URLDecoder.decode(keyword, "UTF-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+
					"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		Qna dto=service.readQna(qnaNum);
		
		if(dto==null) {
			return "redirect:/admin/qna/list?"+query;
		}
		
		dto.setQnaContent(dto.getQnaContent().replaceAll("\n", "<br>"));
		
		Map<String, Object> map=new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("qnaGroupNum", dto.getQnaGroupNum());
		map.put("qnaOrderNo", dto.getQnaOrderNo());
		Qna pdto=service.preReadQna(map);
		Qna ndto=service.nextReadQna(map);
		
		List<Qna> listArticle=service.listArticleQna(dto.getQnaGroupNum());
		
		model.addAttribute("dto", dto);
		model.addAttribute("pdto", pdto);
		model.addAttribute("ndto", ndto);
		model.addAttribute("query", query);
		model.addAttribute("page", page);
		model.addAttribute("listArticle", listArticle);
		
		return ".admin.qna.article";
	}
	
	@RequestMapping(value="/admin/qna/reply", method=RequestMethod.GET)
	public String qnaReplyForm(@RequestParam int qnaNum,
							@RequestParam String page,
							Model model) throws Exception {
		Qna dto=service.readQna(qnaNum);
		if(dto==null) {
			return "redirect:/admin/qna/list?page="+page;
		}
		
		dto.setQnaContent("["+dto.getQnaTitle()+"] 에 대한 답변입니다.");
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "reply");
		return ".admin.qna.created";
	}
	
	@RequestMapping(value="/admin/qna/reply", method=RequestMethod.POST)
	public String qnaReplySubmit(Qna dto, @RequestParam String page,
								HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		try {
			dto.setUserId(info.getUserId());
			service.insertQna(dto, "reply");
		} catch (Exception e) {
		}
		return "redirect:/admin/qna/list?page="+page;
	}
	
	@RequestMapping(value="/admin/qna/update", method=RequestMethod.GET)
	public String qnaUpdateForm(@RequestParam int qnaNum,
								@RequestParam String page,
								HttpSession session,
								Model model) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Qna dto=service.readQna(qnaNum);
		if(dto==null || ! dto.getUserId().equals(info.getUserId())) {
			return "redirect:/admin/qna/list?page="+page;
		}
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		return ".admin.qna.created";
	}
	
	@RequestMapping(value="/admin/qna/update", method=RequestMethod.POST)
	public String qnaUpdateSubmit(Qna dto, @RequestParam String page,
								HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		try {
			dto.setUserId(info.getUserId());
			service.updateQna(dto);
		} catch (Exception e) {
		}
		return "redirect:/admin/qna/list?page="+page;
	}
	
	@RequestMapping(value="/admin/qna/delete")
	public String deleteQna(@RequestParam int qnaNum,
							@RequestParam String page,
							@RequestParam(defaultValue="all") String condition,
							@RequestParam(defaultValue="") String keyword,
							HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		try {
			service.deleteQna(qnaNum, info.getUserId());
		} catch (Exception e) {
		}
		return "redirect:/admin/qna/list?"+query;
	}
}
