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
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.user.bbs.Bbs;
import com.sp.user.bbs.BbsService;
import com.sp.user.bbs.Reply;
import com.sp.user.member.SessionInfo;

@Controller("admin.bbs.bbsController")
public class BbsController {

	@Autowired
	private BbsService service;
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/admin/bbs/list")
	public String bbsList(@RequestParam(value="page", defaultValue="1") int current_page,
						@RequestParam(defaultValue="all") String condition,
						@RequestParam(defaultValue="") String keyword,
						HttpServletRequest req,
						HttpSession session, Model model) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null || info.getEnabled()!=3) {
			return "redirect:/user/member/noAuthorized";
		}
		
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
		if(dataCount != 0)
			total_page=util.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			current_page=total_page;
		
		int start=(current_page - 1) * rows + 1;
		int end=current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Bbs> list=service.listBbs(map);
		
		Date edate=new Date();
		Long gap;
		int listNum, n=0;
		for(Bbs dto:list) {
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			
			SimpleDateFormat sdfm=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date sdate=sdfm.parse(dto.getCreated());
			
			gap=(edate.getTime()-sdate.getTime()) / (24 *60*60*1000);
			dto.setGap(gap);
			
			dto.setCreated(dto.getCreated().substring(0, 10));
			n++;
		}
		String cp=req.getContextPath();
		String query="";
		String listUrl=cp+"/admin/bbs/list";
		String articleUrl=cp+"/admin/bbs/article?page="+current_page;
		
		if(keyword.length()!=0) {
			query+="condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		if(query.length()!=0) {
			listUrl=cp+"/admin/bbs/list?"+query;
			articleUrl=cp+"/admin/bbs/article?page="+current_page+"&"+query;
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
		
		return ".admin.bbs.list";
	}
	
	@RequestMapping(value="/admin/bbs/created", method=RequestMethod.GET)
	public String bbsCreatedForm(Model model, HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null) {
			return "redirect:/user/member/login";
		}
		
		model.addAttribute("mode", "created");
		return ".admin.bbs.created";
	}
	
	@RequestMapping(value="/admin/bbs/created", method=RequestMethod.POST)
	public String bbsCreatedSubmit(Bbs dto, HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		try {
			dto.setUserId(info.getUserId());
			service.insertBbs(dto);
		} catch (Exception e) {
		}
		return "redirect:/admin/bbs/list";
	}
	
	@RequestMapping(value="/admin/bbs/article")
	public String bbsArticle(@RequestParam int num,
							@RequestParam String page,
							@RequestParam(defaultValue="all") String condition,
							@RequestParam(defaultValue="") String keyword,
							Model model) throws Exception {
		keyword=URLDecoder.decode(keyword, "UTF-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		service.updateHitCount(num);
		
		Bbs dto=service.readBbs(num);
		if(dto==null) {
			return "redirect:/admin/bbs/list?"+query;
		}
		
		//dto.setContent(util.htmlSymbols(dto.getContent()));
		
		Map<String, Object> map=new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);
		
		Bbs pdto=service.preReadBbs(map);
		Bbs ndto=service.nextReadBbs(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("pdto", pdto);
		model.addAttribute("ndto", ndto);
		
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".admin.bbs.article";
	}
	
	@RequestMapping(value="/admin/bbs/update", method=RequestMethod.GET)
	public String bbsUpdateForm(@RequestParam int num,
								@RequestParam String page,
								Model model) throws Exception {
		Bbs dto=service.readBbs(num);
		if(dto==null) {
			return "redirect:/admin/bbs/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		model.addAttribute("page", page);
		return ".admin.bbs.created";
	}
	
	@RequestMapping(value="/admin/bbs/update", method=RequestMethod.POST)
	public String bbsUpdateSubmit(Bbs dto, @RequestParam String page,
								HttpSession session) throws Exception {
		try {
			service.updataBbs(dto);
		} catch (Exception e) {
		}
		return "redirect:/admin/bbs/list?page="+page;
	}
	
	@RequestMapping(value="/admin/bbs/delete")
	public String bbsDelete(@RequestParam int num,
							@RequestParam String page,
							@RequestParam(defaultValue="all") String condition,
							@RequestParam(defaultValue="") String keyword) throws Exception {
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		try {
			service.deleteBbs(num);
		} catch (Exception e) {
		}
		
		return "redirect:/admin/bbs/list?"+query;
	}
	@RequestMapping(value="/admin/bbs/insertBbsLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertBbsLike(@RequestParam int num,
											HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		int bbsLikeCount=0;
		
		Map<String, Object> map=new HashMap<>();
		map.put("num", num);
		map.put("userId", info.getUserId());
		
		try {
			service.insertBbsLike(map);
		} catch (Exception e) {
			state="false";
		}
		bbsLikeCount=service.bbsLikeCount(num);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("bbsLikeCount", bbsLikeCount);
		
		return model;
	}
	
	@RequestMapping(value="/admin/bbs/listReply")
	public String listReply(@RequestParam int num,
							@RequestParam(value="pageNo", defaultValue="1") int current_page,
							Model model) throws Exception {
		int rows=5;
		int total_page=0;
		int dataCount=service.replyCount(num);
		total_page=util.pageCount(rows, dataCount);
		if(current_page > total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		Map<String, Object> map=new HashMap<>();
		map.put("num", num);
		map.put("start", start);
		map.put("end", end);
		List<Reply> listReply=service.listReply(map);
		
		for(Reply dto:listReply) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		
		String paging=util.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return "admin/bbs/listReply";
	}
	
	@RequestMapping(value="/admin/bbs/insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReply(Reply dto, HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		try {
			dto.setUserId(info.getUserId());
			service.insertReply(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/admin/bbs/deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteBbsReply(
				@RequestParam int replyNum,
				@RequestParam String mode) throws Exception {
		String state="true";
		Map<String, Object> map=new HashMap<>();
		map.put("replyNum", replyNum);
		map.put("mode", mode);
		
		try {
			service.deleteReply(map);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/admin/bbs/insertReplyLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertReplyLike(
				@RequestParam int replyNum,
				HttpSession session) throws Exception {
		
		String state="true";
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map=new HashMap<>();
		map.put("replyNum", replyNum);
		map.put("userId", info.getUserId());
		try {
			service.insertReplyLike(map);
		} catch (Exception e) {
			state="false";
		}
		int likeCount=service.replyLikeCount(replyNum);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("likeCount", likeCount);
		
		return model;
	}
	
	@RequestMapping(value="/admin/bbs/listReplyAnswer")
	public String listReplyAnswer(@RequestParam(value="answer") int answer, 
								Model model) throws Exception {
		List<Reply> listReplyAnswer=service.listReplyAnswer(answer);
		for(Reply dto:listReplyAnswer) {
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		}
		int answerCount=service.replyAnswerCount(answer);
		
		model.addAttribute("answerCount", answerCount);
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		
		return "/admin/bbs/listReplyAnswer";
	}
	
	@RequestMapping(value="/admin/bbs/countReplyAnswer", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countReplyAnswer(@RequestParam(value="answer") int answer) {
		int answerCount=service.replyAnswerCount(answer);
		
		Map<String, Object> model=new HashMap<>();
		model.put("answerCount", answerCount);
		return model;
	}
}
