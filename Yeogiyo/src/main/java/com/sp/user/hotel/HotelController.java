package com.sp.user.hotel;

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
import com.sp.user.wishlist.WishListService;

@Controller("user.hotelController")
public class HotelController {
	
	@Autowired
	private HotelService service;
	
	@Autowired
	private WishListService wishservice;
	
	@Autowired
	private MyUtil util;
	
	// 호텔 리스트
	@RequestMapping(value="/user/hotel/list")
	public String hotelList(@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req, @RequestParam String checkinday,
			@RequestParam String checkoutday, @RequestParam int peoplecount, @RequestParam String place, HttpSession session, Model model) {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String cp = req.getContextPath();
		
		int rows=5;
		int total_page=0;
		Map<String, Object> map = new HashMap<>();
	
		map.put("addr1", place);
		map.put("checkinday",checkinday);
		map.put("checkoutday", checkoutday);
		map.put("peoplecount",peoplecount);
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		int hotelCount = service.HotelCount(map);
		
		if(hotelCount!=0)
			total_page=util.pageCount(rows,hotelCount);
		
		if(current_page>total_page)
			current_page=total_page;
		
		List<Hotel> list = service.listHotel(map);
		List<Hotel> idlist = null;
		
		if(info!=null)
			idlist=wishservice.checkuserIdlist(info.getUserId());
		
		String listUrl= cp+"/user/hotel/list";
		String articleUrl = cp+"/user/hotel/article?page=" + current_page;
		
		String paging = util.paging(current_page, total_page,listUrl);
		
		model.addAttribute("list",list);
		model.addAttribute("idlist",idlist);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("current_page", current_page);
		model.addAttribute("checkinday",checkinday);
		model.addAttribute("checkoutday",checkoutday);	
		model.addAttribute("peoplecount",peoplecount);
		model.addAttribute("hotelCount",hotelCount);
		model.addAttribute("place",place);
		
		return ".user.hotel.list";
	}
	
	
	// 호텔 상세보기
	@RequestMapping(value="/user/hotel/detail")
	public String article(@RequestParam String hotelName, @RequestParam String checkinday,
			 
			@RequestParam String checkoutday, @RequestParam int peoplecount, Model model) {
				
		Map<String, Object> map = new HashMap<>();
				
		String hotelId=null;
		hotelId=service.getHotelId(hotelName);
		
		map.put("hotelName", hotelName);
		map.put("hotelId", hotelId);
		
		
		Hotel detail = service.detailHotel(map);
		List<Hotel> plist = service.listPhoto(map);
		List<Hotel> rlist = service.listHotelRoom(map);
		List<Hotel> reviewlist = service.listReview(map);
		List<Hotel> optlist = service.listaddopt(map);
		List<Hotel> hotlist = service.listHotPlace(map);
		
		model.addAttribute("hotelId",hotelId);
		model.addAttribute("detail", detail);
		model.addAttribute("plist",plist);
		model.addAttribute("rlist", rlist);
		model.addAttribute("hotlist",hotlist);
		model.addAttribute("optlist", optlist);
		model.addAttribute("reviewlist",reviewlist);
		model.addAttribute("peoplecount",peoplecount);
		model.addAttribute("checkinday",checkinday);
		model.addAttribute("checkoutday",checkoutday);
		return ".user.hotel.detail";
	}	
	
	@RequestMapping(value="/user/hotel/hotelqnaCreate")
	public String hotelqnaCreateForm (@RequestParam String hotelName, HttpSession session, Model model) {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String userId=info.getUserId();
		String hotelId=null;
		hotelId=service.getHotelId(hotelName);
		
		Map<String, Object> map = new HashMap<>();
		
		map.put("userId", userId);
		map.put("hotelId", hotelId);
		
		model.addAttribute("map",map);
		
		return ".user.hotel.hotelqnaCreate";
	}
	
	@RequestMapping(value="/user/hotel/hotelqnaCreateComplete")
	public String hotelqnaComplete(@RequestParam Map<String, Object> map) {
		
		try {
			service.insertHotelQnA(map);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "redirect:/user/main";
	}
	
	
}
