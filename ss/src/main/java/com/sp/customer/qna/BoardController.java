package com.sp.customer.qna;

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

//질문과 답변
@Controller("customer.qna.boardController")
public class BoardController {
	@Autowired
	private BoardService service;

	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/customer/qna/list")
	// @RequestMapping(value="/customer/{group}/list")
	public String list(
			// @PathVariable String group,
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model	) throws Exception {
		
		int rows = 10;
		int total_page;
		int dataCount;

		if (req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "UTF-8");
		}

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);

		dataCount = service.dataCount(map);
		total_page = myUtil.pageCount(rows, dataCount);

		if (total_page < current_page)
			current_page = total_page;

		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;

		map.put("start", start);
		map.put("end", end);

		List<Board> list = service.listBoard(map);

		// 글번호 만들기
		int listNum, n = 0;
		for(Board dto:list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}

        // ajax 페이징처리
        String paging = myUtil.pagingMethod(current_page, total_page, "listPage");

		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("paging", paging);
		model.addAttribute("total_page", total_page);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "customer/qna/list";
	}

	@RequestMapping(value="/customer/qna/created", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception {

		List<Board> listCategory = service.listCategory();
		
		model.addAttribute("pageNo", "1");
		model.addAttribute("listCategory", listCategory);
		model.addAttribute("mode", "created");
		return "customer/qna/created";
	}

	@RequestMapping(value="/customer/qna/created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(
			Board dto,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="true";
		
		try {
			dto.setUserId(info.getUserId());
			service.insertBoard(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	@RequestMapping(value="/customer/qna/article")
	public String article(
			@RequestParam int num,
			@RequestParam String pageNo,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model	) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Board questionDto = service.readQuestion(num);
		if(questionDto==null) {
			return "customer/error";
		}
		if(questionDto.getQuestionPrivate()==1 &&
				 (! info.getUserId().equals("admin") && ! info.getUserId().equals(questionDto.getUserId()))) {
			return "customer/error";
		}
		
		questionDto.setContent(questionDto.getContent().replaceAll("\n", "<br>"));
		
		Board answerDto = service.readAnswer(questionDto.getNum());
		if(answerDto!=null) {
			answerDto.setContent(answerDto.getContent().replaceAll("\n", "<br>"));
		}
		
		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("num", questionDto.getNum());
		map.put("condition", condition);
		map.put("keyword", keyword);

		Board preReadDto = service.preReadQuestion(map);
		Board nextReadDto = service.nextReadQuestion(map);

		model.addAttribute("questionDto", questionDto);
		model.addAttribute("answerDto", answerDto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("pageNo", pageNo);
		
		return "customer/qna/article";
	}

	@RequestMapping(value="/customer/qna/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String pageNo,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Board dto = service.readQuestion(num);
		if(dto==null) {
			return "customer/error";
		}
		
		if(! info.getUserId().equals(dto.getUserId())) {
			return "customer/error";
		}
		
		List<Board> listCategory = service.listCategory();
		
		model.addAttribute("mode", "update");
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("dto", dto);		
		model.addAttribute("listCategory", listCategory);

		return "customer/qna/created";
	}

	@RequestMapping(value="/customer/qna/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSubmit(
			Board dto,
			HttpSession session) throws Exception {

		String state="true";		

		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			dto.setUserId(info.getUserId());
			service.updateBoard(dto);
		} catch (Exception e) {
			state="false";
		}

		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	@RequestMapping(value="/customer/qna/answer", method=RequestMethod.GET)
	public String answerForm(
			@RequestParam int num,
			@RequestParam String pageNo,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Board dto = service.readQuestion(num);
		if(dto==null) {
			return "customer/error";
		}
		
		if(! info.getUserId().equals("admin")) {
			return "customer/error";
		}
		
		dto.setContent("["+dto.getSubject()+"] 에 대한 답변입니다.\n");
		
		List<Board> listCategory = service.listCategory();
		
		model.addAttribute("mode", "answer");
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("dto", dto);		
		model.addAttribute("listCategory", listCategory);		

		return "customer/qna/created";
	}

	@RequestMapping(value="/customer/qna/answer", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> answerSubmit(
			Board dto,
			HttpSession session) throws Exception {

		String state="true";
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			dto.setUserId(info.getUserId());
			service.insertBoard(dto);
		} catch (Exception e) {
			state="false";
		}

		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/customer/qna/delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int num,
			@RequestParam String mode,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="false";
		
		Board dto = service.readQuestion(num);
		if(dto!=null) {
			if(info.getUserId().equals(dto.getUserId())||info.getUserId().equals("admin")) {
				try {
					if(mode.equals("question")) {
						service.deleteQuestion(num);
					} else if(mode.equals("answer")) {
						service.deleteAnswer(num);
					}
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
