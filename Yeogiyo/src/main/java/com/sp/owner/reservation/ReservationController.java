package com.sp.owner.reservation;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.user.member.SessionInfo;

@Controller("owner.reservation.reservationController")
public class ReservationController {
	
	@Autowired
	private ReservationService service;
	
	@RequestMapping(value="/owner/reservation/list")
	public String test(@RequestParam(defaultValue="")String day, Model model) {
		
		if(day.equals("") || day==null) {
			SimpleDateFormat format1 = new SimpleDateFormat ("yyyy-MM");		
			Date time = new Date();		
			String time1 = format1.format(time);
			day = time1;
		}

		model.addAttribute("day", day);
		
		return ".owner.reservation.list"; 
	}
	
	@RequestMapping(value="/owner/reservation/modal")
	@ResponseBody
	public Map<String, List<Reservation>> modal(@RequestParam(defaultValue="")String day, HttpSession session){
		Map<String, List<Reservation>> model = new HashMap<>();
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		Map<String, Object> map = new HashMap<>();
		map.put("hotelId", info.getUserId());
		day = day.replaceAll("-", "");
		map.put("day", day);
		
		try {
			List<Reservation> list = service.select(map);
			model.put("list", list);
		} catch (Exception e) {

		}
		return model;
	}
}
