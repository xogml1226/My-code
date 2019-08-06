package com.sp.user.reservation;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.sp.user.member.SessionInfo;

@Controller("reservation.reservationController")
public class ReservationController {
		
	@Autowired
	private ReservationService service;
	
	@RequestMapping(value="/user/reservation/reservation", method=RequestMethod.POST)
	public String reservate(@RequestParam String hotelId, @RequestParam String roomtype, @RequestParam int roomprice,
			@RequestParam int maxpeople, @RequestParam String roomdetails,@RequestParam String checkinday, @RequestParam String checkoutday
			, @RequestParam int peoplecount, String[] optNum, String[] optCount, String[] optPrice, String[] optName, Model model) {
		
		Map<String, Object> map = new HashMap<>();
		int roomnum=0;
	
		Reservation resdetail = null;
		
		
		map.put("hotelId", hotelId);
		map.put("roomtype", roomtype);
		map.put("roomprice", roomprice);
		map.put("roomdetails", roomdetails);
		map.put("maxpeople", maxpeople);
		map.put("roomstatus", "예약가능");
		map.put("checkinday", checkinday);
		map.put("checkoutday", checkoutday);
		
		try {
			roomnum = service.roomnum(map);
			resdetail=service.reservationdetail(roomnum);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		List<Map<String, Object>> plist=new ArrayList<>();
		int total=0;
		if(optCount!=null) {
			int c, p, t;
			for(int i=0; i<optCount.length; i++) {
				c=Integer.parseInt(optCount[i]);
				p=Integer.parseInt(optPrice[i]);
				t=c*p;
				total+=t;
				Map<String, Object> map2=new HashMap<>();
				map2.put("optNum", optNum[i]);
				map2.put("optName", optName[i]);
				map2.put("total", t);
				map2.put("optCount", c);
				map2.put("optPrice", p);
				
				plist.add(map2);
			}
		}
		
		model.addAttribute("plist",plist);
		model.addAttribute("total",total);
		model.addAttribute("hotelId",hotelId);
		model.addAttribute("resdetail",resdetail);
		model.addAttribute("checkinday",checkinday);
		model.addAttribute("checkoutday",checkoutday);	
		model.addAttribute("peoplecount", peoplecount);
		model.addAttribute("roomnum", roomnum);

		
		return ".user.reservation.reservation";
	}
	
	@RequestMapping(value="/user/reservation/complete")
	public String complete(@RequestParam Map<String, Object> map, HttpSession session, String[] optNum, String[] optCount,
			String[] optPrice, String[] optName, Model model) {
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		String hotelName = service.gethotelname(map);
		int reservationNum=service.getreserNum();
		
		map.put("reservationNum", reservationNum);
		
		List<Map<String, Object>> plist=new ArrayList<>();
		
		int total=0;
		
		if(optCount!=null) {
			int c, p, t, n;
			for(int i=0; i<optCount.length; i++) {
				n=Integer.parseInt(optNum[i]);
				c=Integer.parseInt(optCount[i]);
				p=Integer.parseInt(optPrice[i]);
				t=c*p;
				total+=t;
				Map<String, Object> map2=new HashMap<>();
				
				map2.put("optName", optName[i]);
				map2.put("optNum", n);
				map2.put("total", t);
				map2.put("optCount", c);
				map2.put("optPrice", p);
				map2.put("reservationNum", reservationNum);
				
				plist.add(map2);
			}
		}
		
		try {
			if(optNum!=null) {
				if(info !=null) {
					String userId = info.getUserId();
					map.put("userId", userId);
					service.insertReservation(map);
				} else { 
					service.nomeminsertReservation(map);
				}
				service.optadd(plist);
				
			} else {
				if(info !=null) {
					String userId = info.getUserId();
					map.put("userId", userId);
					service.insertReservation(map);
				} else { 
					service.nomeminsertReservation(map);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		model.addAttribute("total",total);
		model.addAttribute("plist",plist);
		model.addAttribute("map",map);
		model.addAttribute("hotelName",hotelName);		
		return ".user.reservation.reserveComplete";
	}
}
