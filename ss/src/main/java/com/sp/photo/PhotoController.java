package com.sp.photo;

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
import com.sp.member.SessionInfo;

@Controller("photo.photoController")
public class PhotoController {
	@Autowired
	private PhotoService service;
	@Autowired
	private MyUtil myUtil;

	@RequestMapping(value="/photo/list")
	public String list(
			@RequestParam(value="page", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {

		String cp = req.getContextPath();

		int rows = 6;
		int total_page;
		int dataCount;

		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
        // 전체 페이지 수
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

		List<Photo> list = service.listPhoto(map);

		// 글번호 만들기
		int listNum, n = 0;
		for(Photo dto : list) {
			listNum = dataCount - (start + n - 1);
			dto.setListNum(listNum);
			n++;
		}

        String query = "";
        String listUrl = cp+"/photo/list";
        String articleUrl = cp+"/photo/article?page=" + current_page;
        if(keyword.length()!=0) {
        	query = "condition=" +condition + 
        	           "&keyword=" + URLEncoder.encode(keyword, "utf-8");	
        }
        
        if(query.length()!=0) {
        	listUrl = cp+"/photo/list?" + query;
        	articleUrl = cp+"/photo/article?page=" + current_page + "&"+ query;
        }
		
        String paging = myUtil.paging(current_page, total_page, listUrl);
        		
		model.addAttribute("list", list);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("articleUrl", articleUrl);
		model.addAttribute("page", current_page);
		model.addAttribute("paging", paging);
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return ".photo.list";
	}

	@RequestMapping(value="/photo/created", method=RequestMethod.GET)
	public String createdForm(Model model) throws Exception {
		
		model.addAttribute("mode", "created");
		return ".photo.created";
	}
	
	@RequestMapping(value="/photo/created", method=RequestMethod.POST)
	public String createdSubmit(
			Photo dto,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String path=root+"uploads"+File.separator+"photo";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			dto.setUserId(info.getUserId());
			service.insertPhoto(dto, path);
		} catch (Exception e) {
		}
		
		return "redirect:/photo/list";
	}
	
	@RequestMapping(value="/photo/article", method=RequestMethod.GET)
	public String article(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			Model model) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}

		Photo dto = service.readPhoto(num);
		if (dto == null)
			return "redirect:/photo/list?"+query;
		
		dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
		
		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);

		Photo preReadDto = service.preReadPhoto(map);
		Photo nextReadDto = service.nextReadPhoto(map);
		
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		
		model.addAttribute("page", page);
		model.addAttribute("query", query);
		
		return ".photo.article";
	}
	
	@RequestMapping(value="/photo/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String page,
			HttpSession session,
			Model model) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Photo dto = service.readPhoto(num);
		if (dto == null)
			return "redirect:/photo/list?page="+page;

		// 글을 등록한 사람만 수정 가능
		if(! dto.getUserId().equals(info.getUserId())) {
			return "redirect:/photo/list?page="+page;
		}
		
		model.addAttribute("dto", dto);
		model.addAttribute("page", page);
		model.addAttribute("mode", "update");
		
		return ".photo.created";
	}
	
	@RequestMapping(value="/photo/update", method=RequestMethod.POST)
	public String updateSubmit(
			Photo dto,
			@RequestParam String page,
			HttpSession session) throws Exception {
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"photo";
		
		try {
			service.updatePhoto(dto, pathname);
		} catch (Exception e) {
		}
		
		return "redirect:/photo/article?num="+dto.getNum()+"&page="+page;
	}
	
	@RequestMapping(value="/photo/delete", method=RequestMethod.GET)
	public String delete(
			@RequestParam int num,
			@RequestParam String page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpSession session) throws Exception {
		
		keyword = URLDecoder.decode(keyword, "utf-8");
		String query="page="+page;
		if(keyword.length()!=0) {
			query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword, "UTF-8");
		}
		
		String root=session.getServletContext().getRealPath("/");
		String pathname=root+"uploads"+File.separator+"photo";
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		try {
			service.deletePhoto(num, pathname, info.getUserId());
		} catch (Exception e) {
		}
		
		return "redirect:/photo/list?"+query;
	}
}
