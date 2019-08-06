package com.sp.owner.hotplace;

import java.io.File;
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

import com.sp.common.MyUtil;
import com.sp.user.member.SessionInfo;

@Controller("owner.hotplaceController")
public class HotplaceController {
	
	@Autowired
	private HotplaceService service;
	@Autowired
	private MyUtil myUtil;
	
	@RequestMapping(value="/owner/hotplace/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="placeName")String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			HttpSession session,
			Model model) throws Exception{
		
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
		

		
		List<Hotplace> list = service.listHotplace(map);
		
		String cp = req.getContextPath();
		String query = "";
		String listUrl = cp+"/owner/hotplace/list";

		if(keyword.length()!=0) {
			query = "condition="+condition+
					"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		if(query.length()!=0) {
			listUrl = cp+"/owner/hotplace/list?"+query;
		}
		
		String paging = myUtil.paging(current_page, total_page, listUrl);
		
		model.addAttribute("list", list);
		model.addAttribute("page", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);

		return ".owner.hotplace.list";
	}
	
	@RequestMapping(value="/owner/hotplace/created", method=RequestMethod.GET)
	public String createForm(Model model) throws Exception {
		model.addAttribute("mode","created");
		model.addAttribute("subject","명소추가");
		return ".owner.hotplace.created";
	}
	
	@RequestMapping(value="/owner/hotplace/created", method=RequestMethod.POST)
	public String createSubmit(Hotplace dto, HttpSession session) throws Exception{

		SessionInfo info = (SessionInfo)session.getAttribute("member");
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathName = root + "uploads"+ File.separator + "hotplace";

			dto.setHotelId(info.getUserId());
			service.insertHotplace(dto, pathName);
			
		} catch (Exception e) {
		}
		
		return "redirect:/owner/hotplace/list";
	}
	
	@RequestMapping(value="owner/hotplace/delete")
	public String delete(int placeNum, String placePhoto,int page, String condition, String keyword, HttpSession session) throws Exception{
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page="+page;
		if(keyword.length()!=0) {
			query += "&condition"+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathName = root + "uploads" + File.separator + "hotplace";
			service.deleteHotplace(placeNum, placePhoto, pathName);
		} catch (Exception e) {
		}
		return "redirect:/owner/hotplace/list?"+query;
	}
	
	@RequestMapping(value="owner/hotplace/update", method=RequestMethod.GET)
	public String updateForm(int placeNum, int page, String condition, String keyword, HttpSession session, Model model) throws Exception{
		
		Hotplace dto = service.readHotplace(placeNum);
		
		model.addAttribute("mode","update");
		model.addAttribute("subject","명소수정");
		model.addAttribute("condition",condition);
		model.addAttribute("keyword",keyword);
		model.addAttribute("page",page);
		model.addAttribute("dto",dto);
		
		return ".owner.hotplace.created";
	}
	
	@RequestMapping(value="owner/hotplace/update", method=RequestMethod.POST)
	public String updateSubmit(Hotplace dto, int page, String condition, String keyword, HttpSession session, Model model) throws Exception{
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query = "page="+page;
		if(keyword.length()!=0) {
			query += "&condition"+condition+"&keyword="+URLEncoder.encode(keyword, "utf-8");
		}
		SessionInfo info = (SessionInfo)session.getAttribute("member");
		try {
			String root = session.getServletContext().getRealPath("/");
			String pathName = root + "uploads"+ File.separator + "hotplace";

			//세션처리 해야됨
			dto.setHotelId(info.getUserId());
			
			service.updateHotplace(dto, pathName);
		} catch (Exception e) {
		}
		return "redirect:/owner/hotplace/list?"+query;
	}
}
