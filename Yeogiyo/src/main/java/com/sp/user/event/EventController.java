package com.sp.user.event;

import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Calendar;
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
import com.sp.user.member.SessionInfo;

@Controller("user.eventController")
public class EventController {

	@Autowired
	private EventService service;
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/user/event/list")
	public String eventlist(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="") String status,
			HttpServletRequest req, Model model) throws Exception {
		
		int rows=6;
		int total_page;
		int dataCount;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword=URLDecoder.decode(keyword, "UTF-8");
			status=URLDecoder.decode(status, "UTF-8");
		}
		
		Map<String, Object> map=new HashMap<>();
		map.put("keyword", keyword);
		map.put("status", status);
		
		dataCount=service.dataCount(map);
		total_page=util.pageCount(rows, dataCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		
		List<Event> plist=service.listEvent(map);
		
		for(Event dto:plist) {
			SimpleDateFormat sdfm=new SimpleDateFormat("yyyy-MM-dd");
			Calendar c1=Calendar.getInstance();
			String today=sdfm.format(c1.getTime());
		
			Map<String, Object> smap=new HashMap<>();
			smap.put("eventNum", dto.getEventNum());
			smap.put("eventStatus", "진행예정");
			
			if(today.compareTo(dto.getEventStart()) > 0) {
				smap.put("eventStatus", "진행중");
			} 
			if(today.compareTo(dto.getEventEnd()) > 0) {
				smap.put("eventStatus", "진행종료");
			}
			service.updateEventStatus(smap);
		}
		
		List<Event> list=service.listEvent(map);
		
		String cp=req.getContextPath();
		String query="";
		String listUrl=cp+"/user/event/list";
		String articleUrl=cp+"/user/event/article?page="+current_page;
		
		if(keyword.length()!=0) {
			query="keyword="+URLEncoder.encode(keyword, "UTF-8");
		} else if(status.length()!=0) {
			query="status="+URLEncoder.encode(status, "UTF-8");;
		}
		if(query.length()!=0) {
        	listUrl = cp+"/user/event/list?" + query;
        	articleUrl = cp+"/user/event/article?page=" + current_page + "&"+ query;
        }
		
		String paging=util.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("keyword", keyword);
		
		return ".user.event.list";
	}
	
	@RequestMapping(value="/user/event/article", method=RequestMethod.GET)
	public String eventArticle(@RequestParam int eventNum,
								@RequestParam String page,
								@RequestParam(defaultValue="") String keyword,
								@RequestParam(defaultValue="") String status,
								Model model) throws Exception {
		keyword=URLDecoder.decode(keyword, "UTF-8");
		status=URLDecoder.decode(status, "UTF-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&keyword="+URLEncoder.encode(keyword, "UTF-8");
		} else if(status.length()!=0) {
			query+="&status="+URLEncoder.encode(status, "UTF-8");
		}
		
		Event dto=service.readEvent(eventNum);
		if(dto==null) {
			return "redirect:/user/event/list?"+query;
		}
		
		dto.setEventContent(dto.getEventContent().replaceAll("\n", "<br>"));
		
		Map<String, Object> map=new HashMap<>();
		map.put("keyword", keyword);
		map.put("status", status);
		map.put("eventNum", eventNum);
		
		Event pdto=service.preReadEvent(map);
		Event ndto=service.nextReadEvent(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("pdto", pdto);
		model.addAttribute("ndto", ndto);
		
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".user.event.article";
	}
	
	@RequestMapping(value="/user/event/insertEventLike", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertEventLike(@RequestParam int eventNum,
									HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		
		Map<String, Object> map=new HashMap<>();
		map.put("eventNum", eventNum);
		map.put("userId", info.getUserId());
		try {
			service.insertEventLike(map);
		} catch (Exception e) {
			state="false";
		}
		int eventLikeCount=service.eventLikeCount(eventNum);
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		model.put("eventLikeCount", eventLikeCount);
		return model;
	}
	
	@RequestMapping(value="/user/event/listReply")
	public String listEventReply(@RequestParam int eventNum,
							@RequestParam(value="pageNo", defaultValue="1") int current_page,
							Model model) {
		int rows=5;
		int total_page=0;
		int dataCount=service.eventReplyCount(eventNum);
		total_page=util.pageCount(rows, dataCount);
		if(current_page > total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		Map<String, Object> map=new HashMap<>();
		map.put("eventNum", eventNum);
		map.put("start", start);
		map.put("end", end);
		List<EventReply> listReply=service.listEventReply(map);
		
		for(EventReply dto:listReply) {
			dto.setEventreplyContent(dto.getEventreplyContent().replaceAll("\n", "<br>"));
		}
		
		String paging=util.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("listReply", listReply);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("replyCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		
		return "user/event/listReply";
	}
	
	@RequestMapping(value="/user/event/insertReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> insertEventReply(EventReply dto, 
						HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		try {
			dto.setUserId(info.getUserId());
			service.insertEventReply(dto);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/user/event/deleteReply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteEventReply(@RequestParam int eventreplyNum,
												@RequestParam String mode) throws Exception {
		String state="true";
		Map<String, Object> map=new HashMap<>();
		map.put("eventreplyNum", eventreplyNum);
		map.put("mode", mode);
		try {
			service.deleteEventReply(map);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/user/event/listReplyAnswer")
	public String listReplyAnswer(@RequestParam int eventreplyAnswer,
								Model model) throws Exception {
		List<EventReply> listReplyAnswer=service.listEventReplyAnswer(eventreplyAnswer);
		for(EventReply dto:listReplyAnswer) {
			dto.setEventreplyContent(dto.getEventreplyContent().replaceAll("\n", "<br>"));
		}
		int answerCount=service.eventReplyAnswerCount(eventreplyAnswer);
		
		model.addAttribute("listReplyAnswer", listReplyAnswer);
		model.addAttribute("answerCount", answerCount);
		return "user/event/listReplyAnswer";
	}
	
	@RequestMapping(value="/user/event/countReplyAnswer", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> countReplyAnswer(@RequestParam int eventreplyAnswer) {
		int answerCount=service.eventReplyAnswerCount(eventreplyAnswer);
	
		Map<String, Object> model=new HashMap<>();
		model.put("answerCount", answerCount);
		return model;
	}
	
}
