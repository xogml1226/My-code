package com.sp.customer.inquiry;

import java.net.URLDecoder;
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
import com.sp.member.SessionInfo;

// 인콰이어리(inquiry, 1:1 문의)
@Controller("customer.inquiryController")
public class InquiryController {
	@Autowired
	private InquiryService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/customer/inquiry/list")
	public String list(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);
        map.put("userId", info.getUserId());

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows,  dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 리스트에 출력할 데이터를 가져오기
        int start = (current_page - 1) * rows + 1;
        int end = current_page * rows;
        map.put("start", start);
        map.put("end", end);

        // 글 리스트
        List<Inquiry> list = service.listInquiry(map);
        
        // ajax 페이징처리
        String paging = myUtil.paging(current_page, total_page);
        // String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);		
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "customer/inquiry/list";
	}

	@RequestMapping(value="/customer/inquiry/created", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception {

		model.addAttribute("pageNo", "1");
		model.addAttribute("mode", "created");
		return "customer/inquiry/created";
	}

	@RequestMapping(value="/customer/inquiry/created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(
			Inquiry dto,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		try {
			dto.setUserId(info.getUserId());
			service.insertInquiry(dto, "created");
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	@RequestMapping(value="/customer/inquiry/article")
	public String article(
			@RequestParam int num,
			@RequestParam String pageNo,
			HttpSession session,
			Model model) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Inquiry dto = service.readInquiry(num);
		if(dto==null) {
			return "customer/error";
		}
		
		if(! info.getUserId().equals("admin") && ! info.getUserId().equals(dto.getUserId())) {
			return "customer/error";
		}
		
		 List<Inquiry> list = service.relationInquiry(num);
		 for(Inquiry vo:list) {
			 vo.setContent(myUtil.htmlSymbols(vo.getContent()));
		 }
		
		 model.addAttribute("list", list);
		 model.addAttribute("dto", dto);
		 model.addAttribute("pageNo", pageNo);
		 
		return "customer/inquiry/article";
	}

	@RequestMapping(value="/customer/inquiry/update", method=RequestMethod.GET)
	public String updateForm(
			Model model
			) throws Exception {
		
		model.addAttribute("mode", "update");
		return "customer/inquiry/created";
	}

	@RequestMapping(value="/customer/inquiry/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSubmit(
			) throws Exception {
		String state="true";
		// 수정은 작성하지 않음
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	@RequestMapping(value="/customer/inquiry/reply", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replySubmit(
			Inquiry dto,
			HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="false";

		if(info.getUserId().equals("admin")) {
			try {
				dto.setUserId(info.getUserId());
				service.insertInquiry(dto, "reply");
				state="true";
			} catch (Exception e) {
			}
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		
		return model;
	}
	
	@RequestMapping(value="/customer/inquiry/delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int num,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="false";
		Inquiry dto = service.readInquiry(num);
		if(dto!=null) {
			if(info.getUserId().equals("admin") || info.getUserId().equals(dto.getUserId())) {
				try {
					service.deleteInquiry(num);
					state="true";
				} catch (Exception e) {
				}
			}
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
}
