package com.sp.owner.review;

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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.MyUtil;
import com.sp.user.member.SessionInfo;

@Controller("owner.review.reviewController")
public class ReviewController {
	
	@Autowired
	private MyUtil myUtil;
	
	@Autowired
	private ReviewService service;
	
	@RequestMapping(value="/owner/review/list")
	public String list(@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all")String condition,
			@RequestParam(defaultValue="") String keyword,
			@RequestParam(defaultValue="") String msg,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception {
		
		int rows = 10;
		int total_page = 0;
		int dataCount = 0;
		
		if(req.getMethod().equalsIgnoreCase("GET")) {
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		Map<String, Object> map = new HashMap<>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		map.put("hotelId", info.getUserId());
		
		
		dataCount = service.dataCount(map);
		if(dataCount != 0) {
			total_page = myUtil.pageCount(rows, dataCount);
		}
		
		if(total_page < current_page) {
			current_page = total_page;
		}
		
		int start = (current_page - 1) * rows + 1;
		int end = current_page * rows;
		map.put("start", start);
		map.put("end", end);
		
		List<Review> list = service.listReview(map);
		for(Review r : list) {
			r.setReviewContent(r.getReviewContent().replaceAll("\n", "<br>"));
		}
		
		String cp = req.getContextPath();
		String query = "";
		String listUrl = cp+"/owner/review/list";
		
		if(keyword.length()!=0) {
			query = "condition="+condition+
					"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		if(query.length()!=0) {
			listUrl = cp+"/owner/review/list?"+query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("msg", msg);
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".owner.review.list";
	}
	
	@RequestMapping(value="/owner/review/report")
	public String report(int reviewNum, String reportContent, int page, String condition, String keyword, HttpSession session) throws Exception {
		keyword = URLDecoder.decode(keyword,"utf-8");
		Map<String, Object> map = new HashMap<>();
		String query = "page="+page;
		if(keyword.length()!=0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		map.put("hotelId", info.getUserId());
		map.put("reviewNum", reviewNum);
		map.put("reportContent", reportContent);
		String msg = "신고가 완료되었습니다.";
		try {
			service.insertReport(map);
		} catch (Exception e) {
			msg = "신고가 실패하였습니다.";
		}
		query+="&msg="+URLEncoder.encode(msg, "utf-8");
		return "redirect:/owner/review/list?"+query;
	}
	
	@RequestMapping(value="owner/review/article")
	public String articleForm(int reviewNum, int page, String condition, String keyword, HttpSession session, Model model) throws Exception{
		
		Review dto = service.reviewOne(reviewNum);
		List<Reply> list = service.replyList(reviewNum);
		
		for(Reply r : list) {
			r.setReplyContent(r.getReplyContent().replaceAll("\n", "<br>"));
		}
		
		dto.setReviewContent(dto.getReviewContent().replaceAll("\n", "<br>"));
		
		model.addAttribute("condition",condition);
		model.addAttribute("keyword",keyword);
		model.addAttribute("page",page);
		model.addAttribute("dto",dto);
		model.addAttribute("list",list);
		
		return ".owner.review.article";
	}
	
	
	@RequestMapping(value="owner/review/insert")
	public String insert(int reviewNum, String replyContent, int page, String condition, String keyword, HttpSession session) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Reply dto = new Reply();
		dto.setUserId(info.getUserId());
		dto.setReviewNum(reviewNum);
		dto.setReplyContent(replyContent);
		
		String query = "page="+page+"&reviewNum="+reviewNum;
		if(keyword.length()!=0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}

		try {
			service.insertReply(dto);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/owner/review/article?"+query;
	}
	
	@RequestMapping(value="owner/review/delete")
	public String delete(int replyNum, int reviewNum, int page, String condition, String keyword, HttpSession session) throws Exception{

		
		String query = "page="+page+"&reviewNum="+reviewNum;
		if(keyword.length()!=0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}

		try {
			service.deleteReply(replyNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/owner/review/article?"+query;
	}
	
	@RequestMapping(value="owner/review/update")
	public String delete(int replyNum, String replyContent, int reviewNum, int page, String condition, String keyword, HttpSession session) throws Exception{

		Map<String, Object> map = new HashMap<>();
		map.put("replyNum", replyNum);
		map.put("replyContent", replyContent);
		
		String query = "page="+page+"&reviewNum="+reviewNum;
		if(keyword.length()!=0) {
			query += "&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}

		try {
			service.updateReply(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/owner/review/article?"+query;
	}
}
