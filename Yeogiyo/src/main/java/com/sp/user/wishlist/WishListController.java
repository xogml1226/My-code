package com.sp.user.wishlist;

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
import com.sp.user.hotel.Hotel;
import com.sp.user.hotel.HotelService;
import com.sp.user.member.SessionInfo;

@Controller("user.wish.wishController")
public class WishListController {
	@Autowired
	private WishListService service;
	
	@Autowired
	private HotelService hotelservice;
	
	@Autowired
	private MyUtil util;
	
	@RequestMapping(value="/user/wishlist/list")
	public String showWishlist (@RequestParam(value="page", defaultValue="1") int current_page,
			HttpServletRequest req, HttpSession session, Model model) {
		String cp = req.getContextPath();
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String userId = info.getUserId();
		int rows=10;
		int total_page=0;
		
		Map<String, Object> map=new HashMap<>();
		map.put("userId",userId);
		
		int wishlistCount = service.wishlistCount(map);
		
		if(wishlistCount!=0)
			total_page=util.pageCount(rows, wishlistCount);
			
		int start=(current_page-1)*rows+1;
		int end=current_page*rows;
		
		map.put("start", start);
		map.put("end", end);
		List<WishList> list = service.list(map);
		int listNum, n=0;
		for (WishList dto:list){
			listNum=wishlistCount-(start+n-1);
			dto.setListNum(listNum);
			n++;
		}

		String listUrl= cp+"/user/wishlist/list";
		String articleUrl = cp+"/user/wishlist/article?page=" + current_page;
		
		String paging = util.paging(current_page, total_page,listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("wishlistCount", wishlistCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("current_page", current_page);
		
		return ".user.wishlist.list";
	}
	
	@RequestMapping(value="/user/wishlist/add", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> changewishlist(@RequestParam Map<String, Object> map) throws Exception {
		List<Hotel> list = null;
		
		int result=0;
		try {
			result=service.insertwishlist(map);

		} catch (Exception e) {
						
		}
		list = hotelservice.listHotel(map);
		
		Map<String, Object> model = new HashMap<>();
		
		model.put("result", result);
		model.put("list", list);
		
		return model;
	}
	
	@RequestMapping(value="/user/wishlist/delete")
	public String deletewish(@RequestParam Map<String, Object> map) throws Exception {
		
		try {
			service.deletewishlist(map);

		} catch (Exception e) {
			e.printStackTrace();
			throw e;
		}
		return "redirect:/user/wishlist/list";
	}
}
