package com.sp.board;

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
import com.sp.member.SessionInfo;

@Controller("board.boardController")
public class BoardController {
	@Autowired
	private BoardService service;
	
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/board/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(value="rows", defaultValue="10") int rows,
			HttpServletRequest req,
			Model model
			) throws Exception{
		
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

		// 글번호 만들기, 오늘날짜와 게시글 입력 날짜차이 계산
		Date endDate = new Date();
        long gap;
        int listNum, n = 0;
        for(Board dto : list) {
            listNum = dataCount - (start + n - 1);
            dto.setListNum(listNum);
            
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date beginDate = formatter.parse(dto.getCreated());
/*            
            // 날짜차이(일)
            gap=(endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60* 1000);
            data.setGap(gap);
*/
         // 날짜차이(시간)
            gap=(endDate.getTime() - beginDate.getTime()) / (60*60* 1000);
            dto.setGap(gap);
            
            dto.setCreated(dto.getCreated().substring(0, 10));
            
            n++;
        }
        
		String cp = req.getContextPath();
		String query = "rows="+rows;
		String listUrl = cp + "/board/list";
		String articleUrl = cp + "/board/article?page=" + current_page;

		if (keyword.length() != 0) {
			query += "&condition=" + condition + "&keyword="
					+ URLEncoder.encode(keyword, "UTF-8");
		}
		listUrl += "?" + query;
		articleUrl += "&" + query;
		
		String paging = myUtil.paging(current_page, total_page, listUrl);

		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("page", current_page);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("paging", paging);
		
		model.addAttribute("rows", rows);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return ".board.list";
	}
	
	@RequestMapping(value="/board/created", method=RequestMethod.GET)
	public String createdForm(HttpSession session, Model model) throws Exception{
		model.addAttribute("mode", "created");
		return ".board.created";
	}
	
	@RequestMapping(value="/board/created", method=RequestMethod.POST)
	public String createdSubmit(Board dto, HttpSession session) throws Exception{
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		try {
			dto.setUserId(info.getUserId());
			service.insertBoard(dto, "created");
		} catch (Exception e) {
		}
		
		return "redirect:/board/list";
	}
	
	@RequestMapping(value="/board/article")
	public String article(
			@RequestParam int boardNum,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam int rows,
			Model model
			) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page+"&rows="+rows;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		service.updateHitCount(boardNum);
		Board dto=service.readBoard(boardNum);
		
		if(dto==null) {
			return "redirect:/board/list?"+query;
		}
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));

		// 이전/다음글
		Map<String, Object> map=new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("groupNum", dto.getGroupNum());
		map.put("orderNo", dto.getOrderNo());
		Board preReadDto = service.preReadBoard(map);
		Board nextReadDto = service.nextReadBoard(map);
		
		// 관련글
		List<Board> listArticle = service.listArticleBoard(dto.getGroupNum());
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("query", query);
		model.addAttribute("rows", rows);
		model.addAttribute("page", page);
		model.addAttribute("listArticle", listArticle);
		
		return ".board.article";
	}
	
	@RequestMapping(value="/board/reply", method=RequestMethod.GET)
	public String replyForm(
			@RequestParam int boardNum,
			@RequestParam String page,
			@RequestParam int rows,
			Model model
			) throws Exception {
		
		Board dto=service.readBoard(boardNum);
		if(dto==null) {
			return "redirect:/board/list?page="+page+"&rows="+rows;
		}
		
		dto.setContent("["+dto.getSubject()+"] 에 대한 답변입니다.\n");
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("rows", rows);
		model.addAttribute("mode", "reply");
		
		return ".board.created";
	}

	@RequestMapping(value="/board/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int boardNum,
			@RequestParam String page,
			@RequestParam int rows,
			HttpSession session,
			Model model
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Board dto=service.readBoard(boardNum);
		if(dto==null || ! dto.getUserId().equals(info.getUserId())) {
			return "redirect:/board/list?page="+page+"&rows="+rows;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("rows", rows);
		model.addAttribute("mode", "update");
		
		return ".board.created";
	}
	
	@RequestMapping(value="/board/update", method=RequestMethod.POST)
	public String updateSubmit(
			Board dto,
			@RequestParam int rows,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			service.updateBoard(dto);
		} catch (Exception e) {
		}
		
		return "redirect:/board/list?page="+page+"&rows="+rows;
	}
	
	@RequestMapping(value="/board/reply", method=RequestMethod.POST)
	public String replySubmit(
			Board dto,
			@RequestParam int rows,
			@RequestParam String page,
			HttpSession session
			) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			service.insertBoard(dto, "reply");
		} catch (Exception e) {
		}
		
		return "redirect:/board/list?page="+page+"&rows="+rows;
	}
	
	@RequestMapping(value="/board/delete")
	public String delete(
			@RequestParam int boardNum,
			@RequestParam String page,
			@RequestParam int rows,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session
			) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		String query="page="+page+"&rows="+rows;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		try {
			service.deleteBoard(boardNum, info.getUserId());
		} catch (Exception e) {
		}
		
		return "redirect:/board/list?page="+query;
	}
}
