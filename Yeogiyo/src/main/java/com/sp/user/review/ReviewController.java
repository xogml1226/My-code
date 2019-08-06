package com.sp.user.review;

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

@Controller("user.review.reviewController")
public class ReviewController {
	
	@Autowired
	private ReviewService service;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/user/review/list")
	public String reviewList(@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req, HttpSession session, Model model) throws Exception {
		String cp = req.getContextPath();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		int rows=10;
		int total_page=0;
		int reviewCount=service.reviewCount(userId);
		
		if(reviewCount!=0)
			total_page=util.pageCount(rows, reviewCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		Map<String, Object> map=new HashMap<>();
		map.put("start", start);
		map.put("end", end);		
		map.put("userId", userId);
		List<Review> reviewlist=null;
		
		
		reviewlist=service.reviewList(map);
		
		int listNum, n=0;
		for(Review dto:reviewlist) {
			listNum=reviewCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}
		
		String listUrl= cp+"/user/review/list";
		String articleUrl = cp+"/user/review/article?page=" + current_page;
		
		String paging = util.paging(current_page, total_page,listUrl);
		
		
		model.addAttribute("reviewlist", reviewlist);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("reviewCount", reviewCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		
		return ".user.review.list";
	}
	
	@RequestMapping(value="/user/review/article")
	public String reviewArticle(@RequestParam int reviewNum, Model model) {
		Review article = null;
		List<Review> replylist = null;
		
		article=service.reviewArticle(reviewNum);
		replylist=service.ListReply(reviewNum);
		
		model.addAttribute("article", article);
		model.addAttribute("replylist", replylist);
		return ".user.review.article";
	}
	
	@RequestMapping(value="/user/review/create")
	public String reviewCreate(@RequestParam int reservationNum, HttpSession session, Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		
		Map<String, Object> map = new HashMap<>();
		Review review = service.beforeCreate(reservationNum);
		String hotelId = review.getHotelId();
		
		map.put("hotelId", hotelId);
		map.put("userId", userId);
		map.put("reservationNum", reservationNum);
		int check =0;
		check=service.check(map);
		model.addAttribute("reservationNum",reservationNum);
		
		if(check !=0) {
			return "redirect:/user/review/list";
		}
		
		
		model.addAttribute("review",review);
		return ".user.review.create";
	}
	
	@RequestMapping(value="/user/review/complete")
	public String reviewCreateComplete(@RequestParam Map<String, Object> map, HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String userId = info.getUserId();
		map.put("userId", userId);
		try {
			service.createReview(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "redirect:/user/review/list";
	}
	
	@RequestMapping(value="/user/review/delete")
	public String reviewDelete(@RequestParam int reviewNum) {
		try {
			service.deleteReportReview(reviewNum);
			service.deleteAllReply(reviewNum);
			service.deleteReview(reviewNum);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/user/review/list";
	}
	
	@RequestMapping(value="/user/review/report")
	public String reviewReport(@RequestParam String hotelId, @RequestParam int reviewNum, Model model){
		model.addAttribute("hotelId",hotelId);
		model.addAttribute("reviewNum",reviewNum);
		
		return ".user.review.reportCreate";
	}
	
	@RequestMapping(value="/user/review/reportComplete")
	public String ReportForm(@RequestParam Map<String, Object> map) throws Exception{
		try {
			service.report(map);
		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "redirect:/user/review/list";
	}
	//----------------------------------------------------------------댓글
	
	@RequestMapping(value="/user/review/replycreate", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> replyCreate(@RequestParam Map<String, Object> paramap, Review dto,HttpSession session) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");	
		String state="true";
		try {
			dto.setUserId(info.getUserId());
			service.insertReply(paramap);
		} catch (Exception e) {
			state="false";
		}
		Map<String, Object> map = new HashMap<>();	
		map.put("state",state);
		return map;
	}	
	
	@RequestMapping(value="/user/review/replydelete")
	@ResponseBody
	public Map<String, Object> replyDelete(@RequestParam int reviewNum,@RequestParam int replyNum) {
		Map<String, Object> map = new HashMap<>();	
		String state="true";
		try {
			service.deleteReply(replyNum);
		} catch (Exception e) {
			state="false";
		}
		map.put("reviewNum",reviewNum);
		map.put("replyNum",replyNum);
		map.put("state",state);
		return map;
	}
}
