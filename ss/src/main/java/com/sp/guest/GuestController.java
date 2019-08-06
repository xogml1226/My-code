package com.sp.guest;

import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

@Controller("guest.guestController")
public class GuestController {
	@Autowired
	private GuestService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/guest/guest")
	public String guest(Model model) {
		return ".guest.guest";
	}
	
	@RequestMapping(value="/guest/list")
	@ResponseBody
	public Map<String, Object> list(
		    @RequestParam(value="pageNo", defaultValue="1") int current_page) throws Exception {
		int rows=5;
		int dataCount=service.dataCount();
		int total_page=myUtil.pageCount(rows, dataCount);
		if(current_page>total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("start", start);
		map.put("end", end);
		
		int listNum, n = 0;
		List<Guest> list=service.listGuest(map);
		Iterator<Guest> it=list.iterator();
		while(it.hasNext()) {
			Guest dto=it.next();
			dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
			
			listNum = dataCount - (start + n - 1);
            dto.setListNum(listNum);
            n++;			
		}
		
		// 페이징 처리할 경우
		// String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
   	    // 작업 결과를 json으로 전송
		Map<String, Object> model = new HashMap<>(); 
		// 데이터개수
		model.put("total_page", total_page);
		model.put("dataCount", dataCount);
		model.put("pageNo", current_page);
		// model.put("paging", paging);
		// 게시물 리스트
		model.put("list", list);
		
		return model;
	}
	
	@RequestMapping(value="/guest/insert", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(
			Guest dto,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state="true";
		try {
			dto.setUserId(info.getUserId());
			service.insertGuest(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/guest/delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> guestDelete(
			@RequestParam int num,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String state="true";
		try {
			Map<String, Object> map=new HashMap<>();
			map.put("num", num);
			map.put("userId", info.getUserId());
			service.deleteGuest(map);
		} catch (Exception e) {
			state="false";
		}			
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
}
