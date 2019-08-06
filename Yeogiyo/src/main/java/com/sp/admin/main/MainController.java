package com.sp.admin.main;

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

@Controller("admin.mainController")
public class MainController {
	
	@Autowired
	private GrantedService service;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/admin/main")
	public String test(
			@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req,
			HttpSession session, Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		if(info==null || info.getEnabled()!=3) {
			return "redirect:/user/member/noAuthorized";
		}
		
		int rows =10;
		int total_page;
		int dataCount;
		
		dataCount=service.dataCount();
		total_page=util.pageCount(rows, dataCount);
		
		if(current_page > total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		Map<String, Object> map=new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		List<Granted> list=service.listHotel(map);
		
		int listNum, n=0;
		for(Granted dto:list) {
			listNum=dataCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String cp=req.getContextPath();
		
		String listUrl=cp+"/admin/main";
		String articleUrl=cp+"/admin/granted/article?page="+current_page;
		
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		
		return ".admin.granted.list"; 
	}
	
	@RequestMapping(value="/admin/granted/article", method=RequestMethod.GET)
	public String article(@RequestParam String hotelId,
						@RequestParam String page,
						Model model) {
		
		Granted dto=service.readHotel(hotelId);
		
		if(dto==null)
			return "redirect:/admin/main?page="+page;
		
		dto.setDetail(dto.getDetail().replaceAll("\n", "<br>"));
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		
		return ".admin.granted.article";
	}
	
	@RequestMapping(value="/admin/granted/update")
	public String grantedUpdate(@RequestParam String hotelId,
								@RequestParam String page) {
		Granted dto=service.readHotel(hotelId);
		try {
			service.updateGranted(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/admin/main?page="+page;
	}
}
