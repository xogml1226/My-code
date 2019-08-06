package com.sp.user.confirm;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.common.MyUtil;
import com.sp.user.member.SessionInfo;

@Controller("user.confirm.confirmController")
public class ConfirmController {

	@Autowired
	private ConfirmService service;
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/user/confirm/list")
	public String listConfirm(@RequestParam(value="page", defaultValue="1") int current_page,
							@RequestParam(defaultValue="") String condition,
							@RequestParam(defaultValue="") String keyword,
							HttpServletRequest req,
							HttpSession session, Model model) throws Exception {
		int rows=10;
		int total_page=0;
		int dataCount=0;
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "UTF-8");
		}
		Map<String, Object> map=new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		map.put("userId", info.getUserId());
		dataCount=service.dataCount(map);
		if(dataCount!=0) {
			total_page=util.pageCount(rows, dataCount);
		}
		
		if(current_page > total_page) {
			current_page=total_page;
		}
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Confirm> list=service.listConfirm(map);
		int listNum, n=0;
		for(Confirm dto:list) {
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		String cp=req.getContextPath();
		String query="";
		String listUrl=cp+"/user/confirm/list";
		String articleUrl=cp+"/user/confirm/article?page="+current_page;
		if(keyword.length()!=0) {
			query+="condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		if(query.length()!=0) {
			listUrl=cp+"/user/confirm/list?"+query;
			articleUrl=cp+"/user/confirm/article?page="+current_page+"&"+query;
		}
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".user.confirm.list";
	}
	
	@RequestMapping(value="/user/confirm/article")
	public String confirmArticle(@RequestParam int reservationNum,
								@RequestParam String page,
								@RequestParam(defaultValue="") String condition,
								@RequestParam(defaultValue="") String keyword,
								Model model) throws Exception {
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		Confirm dto=service.readConfirm(reservationNum);
		if(dto==null) {
			return "redirect:/user/confirm/list?"+query;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		model.addAttribute("mode", "member");
		
		return ".user.confirm.article";
	}
	
	@RequestMapping(value="/user/confirm/delete")
	public String deleteReservation(@RequestParam int reservationNum,
									@RequestParam String page,
									@RequestParam(defaultValue="") String condition,
									@RequestParam(defaultValue="") String keyword,
									@RequestParam String mode,
									String userName,
									String userEmail,
									String userTel,
									Model model) throws Exception {
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		try {
			service.deleteReservation(reservationNum);
		} catch (Exception e) {
		}
		if(mode.equals("member")) {
			return "redirect:/user/confirm/list?"+query;
		} else {
			String q="&userName="+URLEncoder.encode(userName, "UTF-8")+"&userEmail="+userEmail+"&userTel="+userTel;
			return "redirect:/user/confirm/send?"+query+q;
		}
	}
	
	@RequestMapping(value="/user/confirm/nomember")
	public String nomemberConfirmForm(String message, Model model) {
		model.addAttribute("message", message);
		return ".user.confirm.find";
	}
	
	@RequestMapping(value="/user/confirm/send")
	public String nomemberConfirmSubmit(@RequestParam(value="page", defaultValue="1") int current_page,
										String userName,
										String userEmail,
										String userTel,
										HttpServletRequest req,
										Model model) throws UnsupportedEncodingException {
		int rows=10;
		int total_page=0;
		int dataCount=0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			userName=URLDecoder.decode(userName, "UTF-8");
		}
		
		Map<String, Object> map=new HashMap<>();
		map.put("userName", userName);
		map.put("userEmail", userEmail);
		map.put("userTel", userTel);
		
		dataCount=service.noMemberdataCount(map);
		if(dataCount==0) {
			model.addAttribute("message", "입력하신 정보의 예약내역이 없습니다.");
			return "redirect:/user/confirm/nomember";
		}
		if(dataCount!=0) {
			total_page=util.pageCount(rows, dataCount);
		}
		
		if(current_page > total_page) {
			current_page=total_page;
		}
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Confirm> list=service.listNoMemberConfirm(map);
		int listNum, n=0;
		for(Confirm dto:list) {
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		String cp=req.getContextPath();
		String listUrl=cp+"/user/confirm/send";
		String articleUrl=cp+"/user/confirm/noMemberArticle?page="+current_page;
		
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return ".user.confirm.list";
	}
	
	@RequestMapping(value="/user/confirm/noMemberArticle")
	public String noMemberArticle(@RequestParam int reservationNum,
								@RequestParam String page,
								@RequestParam(defaultValue="") String condition,
								@RequestParam(defaultValue="") String keyword,
								Model model) throws Exception {
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		Confirm dto=service.readnoMemberConfirm(reservationNum);
		if(dto==null) {
			return "redirect:/user/confirm/send?"+query;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		model.addAttribute("mode", "nomember");
		
		return ".user.confirm.article";
	}
}
