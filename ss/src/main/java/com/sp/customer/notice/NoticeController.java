package com.sp.customer.notice;

import java.io.File;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.common.FileManager;
import com.sp.common.MyUtil;
import com.sp.member.SessionInfo;

// 공지사항(notice)
@Controller("customer.noticeController")
public class NoticeController {
	@Autowired
	private NoticeService service;
	@Autowired
	private MyUtil myUtil;
	@Autowired
	private FileManager fileManager;
	
	@RequestMapping(value="/customer/notice/list")
	public String list(
			@RequestParam(value="pageNo", defaultValue="1") int current_page,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {
		
		int rows = 10; // 한 화면에 보여주는 게시물 수
		int total_page = 0;
		int dataCount = 0;
   	    
		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
        // 전체 페이지 수
        Map<String, Object> map = new HashMap<String, Object>();
        map.put("condition", condition);
        map.put("keyword", keyword);

        dataCount = service.dataCount(map);
        if(dataCount != 0)
            total_page = myUtil.pageCount(rows,  dataCount) ;

        // 다른 사람이 자료를 삭제하여 전체 페이지수가 변화 된 경우
        if(total_page < current_page) 
            current_page = total_page;

        // 1페이지인 경우 공지리스트 가져오기
        List<Notice> noticeList = null;
        if(current_page==1) {
          noticeList=service.listNoticeTop();
        }
        
        // 리스트에 출력할 데이터를 가져오기
        int start = (current_page - 1) * rows + 1;
        int end = current_page * rows;
        map.put("start", start);
        map.put("end", end);

        // 글 리스트
        List<Notice> list = service.listNotice(map);

        // 리스트의 번호
        Date endDate = new Date();
        long gap;
        int listNum, n = 0;
        for(Notice dto : list) {
            listNum = dataCount - (start + n - 1);
            dto.setListNum(listNum);
            
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            Date beginDate = formatter.parse(dto.getCreated());
/*            
            // 날짜차이(일)
            gap=(endDate.getTime() - beginDate.getTime()) / (24 * 60 * 60* 1000);
            dto.setGap(gap);
*/
         // 날짜차이(시간)
            gap=(endDate.getTime() - beginDate.getTime()) / (60*60* 1000);
            dto.setGap(gap);
            
            dto.setCreated(dto.getCreated().substring(0, 10));
            
            n++;
        }
        
        // ajax 페이징처리
        String paging = myUtil.pagingMethod(current_page, total_page, "listPage");
		
		model.addAttribute("noticeList", noticeList);
		model.addAttribute("list", list);
		model.addAttribute("pageNo", current_page);
		model.addAttribute("dataCount", dataCount);
		model.addAttribute("total_page", total_page);
		model.addAttribute("paging", paging);		
		
		model.addAttribute("condition", condition);
		model.addAttribute("keyword", keyword);
		
		return "customer/notice/list";
	}

	@RequestMapping(value="/customer/notice/created", method=RequestMethod.GET)
	public String createdForm(
			Model model
			) throws Exception {

		model.addAttribute("pageNo", "1");
		model.addAttribute("mode", "created");
		return "customer/notice/created";
	}

	@RequestMapping(value="/customer/notice/created", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> createdSubmit(
			Notice dto,
			HttpSession session) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="false";
		
		if(info.getUserId().equals("admin")) {
			try {
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + "uploads" + File.separator + "notice";		
				
				dto.setUserId(info.getUserId());
				service.insertNotice(dto, pathname);
				state="true";
			} catch (Exception e) {
			}
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	@RequestMapping(value="/customer/notice/article")
	public String article(
			@RequestParam int num,
			@RequestParam String pageNo,
			@RequestParam(defaultValue="all") String condition,
			@RequestParam(defaultValue="") String keyword,
			HttpServletRequest req,
			Model model) throws Exception {

		if(req.getMethod().equalsIgnoreCase("GET")) { // GET 방식인 경우
			keyword = URLDecoder.decode(keyword, "utf-8");
		}
		
		service.updateHitCount(num);

		Notice dto = service.readNotice(num);
		if(dto==null) {
			return "customer/error";
		}
		
        dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
         
		// 이전 글, 다음 글
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("condition", condition);
		map.put("keyword", keyword);
		map.put("num", num);

		Notice preReadDto = service.preReadNotice(map);
		Notice nextReadDto = service.nextReadNotice(map);
        
		// 파일
		List<Notice> listFile=service.listFile(num);
				
		model.addAttribute("dto", dto);
		model.addAttribute("preReadDto", preReadDto);
		model.addAttribute("nextReadDto", nextReadDto);
		model.addAttribute("listFile", listFile);
		model.addAttribute("pageNo", pageNo);
		
		return "customer/notice/article";
	}

	@RequestMapping(value="/customer/notice/update", method=RequestMethod.GET)
	public String updateForm(
			@RequestParam int num,
			@RequestParam String pageNo,
			HttpSession session,			
			Model model	) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");

		Notice dto = service.readNotice(num);
		if(dto==null) {
			return "customer/error";
		}

		if(! info.getUserId().equals(dto.getUserId())) {
			return "customer/error";
		}
		
		List<Notice> listFile=service.listFile(num);
			
		model.addAttribute("mode", "update");
		model.addAttribute("pageNo", pageNo);
		model.addAttribute("dto", dto);
		model.addAttribute("listFile", listFile);
		
		return "customer/notice/created";
	}

	@RequestMapping(value="/customer/notice/update", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> updateSubmit(
			Notice dto,
			HttpSession session) throws Exception {

		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="false";
		
		if(info.getUserId().equals("admin")) {
			try {
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + "uploads" + File.separator + "notice";		
				
				dto.setUserId(info.getUserId());
				service.updateNotice(dto, pathname);
				state="true";
			} catch (Exception e) {
			}
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	@RequestMapping(value="/customer/notice/delete", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> delete(
			@RequestParam int num,
			HttpSession session) throws Exception {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		String state="false";
		
		if(info.getUserId().equals("admin")) {
			try {
				String root = session.getServletContext().getRealPath("/");
				String pathname = root + "uploads" + File.separator + "notice";
				service.deleteNotice(num, pathname);
				state="true";
			} catch (Exception e) {
			}
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	@RequestMapping(value="/customer/notice/download")
	public void download(
			@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";

		boolean b = false;
		
		Notice dto = service.readFile(fileNum);
		if(dto!=null) {
			String saveFilename = dto.getSaveFilename();
			String originalFilename = dto.getOriginalFilename();
			
			b = fileManager.doFileDownload(saveFilename, originalFilename, pathname, resp);
		}
		
		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}

	@RequestMapping(value="/customer/notice/zipdownload")
	public void zipdownload(
			@RequestParam int num,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";

		boolean b = false;
		
		List<Notice> listFile = service.listFile(num);
		if(listFile.size()>0) {
			String []sources = new String[listFile.size()];
			String []originals = new String[listFile.size()];
			String zipFilename = num+".zip";
			
			for(int idx = 0; idx<listFile.size(); idx++) {
				sources[idx] = pathname+File.separator+listFile.get(idx).getSaveFilename();
				originals[idx] = File.separator+listFile.get(idx).getOriginalFilename();
			}
			
			b = fileManager.doZipFileDownload(sources, originals, zipFilename, resp);
		}
		
		if (!b) {
			try {
				resp.setContentType("text/html; charset=utf-8");
				PrintWriter out = resp.getWriter();
				out.println("<script>alert('파일 다운로드가 불가능 합니다 !!!');history.back();</script>");
			} catch (Exception e) {
			}
		}
	}
	
	@RequestMapping(value="/customer/notice/deleteFile", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> deleteFile(
			@RequestParam int fileNum,
			HttpServletResponse resp,
			HttpSession session) throws Exception {
		String root = session.getServletContext().getRealPath("/");
		String pathname = root + "uploads" + File.separator + "notice";
		
		Notice dto=service.readFile(fileNum);
		if(dto!=null) {
			fileManager.doFileDelete(dto.getSaveFilename(), pathname);
		}
		
		Map<String, Object> model = new HashMap<>(); 
		try {
			Map<String, Object> map=new HashMap<String, Object>();
			map.put("field", "fileNum");
			map.put("num", fileNum);
			service.deleteFile(map);
			model.put("state", "true");
		} catch (Exception e) {
			model.put("state", "false");
		}
		
		return model;
	}
}
