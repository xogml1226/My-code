package com.sp.owner.jungsanD;

import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
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
import org.springframework.web.servlet.View;

import com.sp.user.member.SessionInfo;


@Controller("owner.jungsanD.jungsanDController")
public class JungsanDController {
	
	@Autowired
	private JungsanDService service;
	
	@Autowired
	private View excelView;
	
	@RequestMapping("/owner/jungsanD/list")
	public String list(@RequestParam(defaultValue="")String day
						,@RequestParam(defaultValue="")String msg
						,HttpSession session
						,Model model) {
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<>();
		map.put("hotelId", info.getUserId());
		
		
		
		if(day.equals("") || day==null) {
			SimpleDateFormat format1 = new SimpleDateFormat ( "yyyy-MM-dd");		
			Date time = new Date();		
			String time1 = format1.format(time);
			day = time1;
		}
		map.put("day", day);
		
		List<JungsanD> list = service.select(map);
		
		int sum = 0;
		int num = 0;
		for(JungsanD j : list) {
			sum += j.getPrice();
			j.setNum(++num);
		}
		
		model.addAttribute("list", list);
		model.addAttribute("sum", sum);
		model.addAttribute("day", day);
		model.addAttribute("msg",msg);
		
		return ".owner.jungsanD.list";
	}
	
	@RequestMapping("/owner/jungsanD/insert")
	public String insert(String day, HttpSession session, Model model) throws Exception {
	
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		String msg = "";
		
		Map<String, Object> map = new HashMap<>();
		map.put("hotelId", info.getUserId());
		map.put("day", day);
		
		try {
			service.insert(map);	
			msg = "정산이 완료되었습니다.";
		} catch (Exception e) {
			msg = "정산이 실패하였습니다.";
		}
		
		String query = "day="+day+"&msg="+URLEncoder.encode(msg, "utf-8");

		return "redirect:/owner/jungsanD/list?"+query;
	}
	
	@RequestMapping("/owner/jungsanD/bar")
	@ResponseBody
	public Map<String, Object> bar(String day, HttpSession session) throws Exception{
		Map<String, Object> model = new HashMap<>();
		List<Map<String, Object>> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> data = new HashMap<>();
		data.put("day", day);
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		data.put("hotelId", info.getUserId());
		
		List<JungsanD> datas = service.selectDay(data);
		
		String days[] = new String[datas.size()];
		int pays[] = new int[datas.size()];
		int index = 0;
		
		for(JungsanD j : datas) {
			days[index] = j.getPayDate()+"일";
			pays[index++] = j.getPrice();
		}
		
		String month = day.substring(0,7);
		
		map.put("name", month);
		map.put("data", pays);
		list.add(map);
		
		model.put("list", days);
		model.put("series", list);
		return model;
	}
	
	@RequestMapping("/owner/jungsanD/bar2")
	@ResponseBody
	public Map<String, Object> bar2(String day, HttpSession session) throws Exception{
		Map<String, Object> model = new HashMap<>();
		List<Map<String, Object>> list = new ArrayList<>();
		Map<String, Object> map = new HashMap<>();
		
		Map<String, Object> data = new HashMap<>();
		data.put("day", day);
		
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		data.put("hotelId", info.getUserId());
		
		List<JungsanD> datas = service.selectDay(data);
		
		String days[] = new String[datas.size()];
		int people[] = new int[datas.size()];
		int index = 0;
		
		for(JungsanD j : datas) {
			days[index] = j.getPayDate()+"일";
			people[index++] = j.getPeopleCount();
		}
		
		String month = day.substring(0,7);
		
		map.put("name", month);
		map.put("data", people);
		list.add(map);
		
		model.put("list", days);
		model.put("series", list);
		return model;
	}
	
	@RequestMapping("/owner/jungsanD/excel")
	public View excel(String day, Map<String, Object> model, HttpSession session) throws Exception{
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		Map<String, Object> map = new HashMap<>();
		map.put("hotelId", info.getUserId());
		map.put("day", day);
		
		List<JungsanD> list = service.select(map);
		String sheetName = day+"정산";
		List<String> labels = new ArrayList<>();

		labels.add("결제일");
		labels.add("방이름");
		labels.add("결제종류");
		labels.add("인원수");
		labels.add("체크인");
		labels.add("체크아웃");
		labels.add("금액");
		
		List<Object[]> values = new ArrayList<>();
		
		for(JungsanD dto:list) {
			values.add(new Object[] {dto.getPayDate(), dto.getRoomName(), dto.getPayType()
			,dto.getPeopleCount(), dto.getCheckinDay(), dto.getCheckoutDay(), dto.getPrice()});
		}
		
		model.put("filename", day+".xlsx");
		model.put("sheetName", sheetName);
		model.put("labels",labels);
		model.put("values", values);
		
		return excelView;
	}
}
