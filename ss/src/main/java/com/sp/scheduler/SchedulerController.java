package com.sp.scheduler;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sp.member.SessionInfo;

@Controller("scheduler.schedulerController")
public class SchedulerController {
	@Autowired
	private ResourceService service;
	
	@RequestMapping(value="/scheduler/main")
	public String main() throws Exception {
		return ".scheduler.main";
	}
	
	@RequestMapping(value="/scheduler/resources")
	@ResponseBody
	public List<ResourceJSON> resources(HttpServletResponse resp) throws Exception {
		List<ResourceJSON> list=service.listResourceList();
		return list;
	}
	
/*
	@RequestMapping(value="/scheduler/resources")
	public void resources(HttpServletResponse resp) throws Exception {
		List<ResourceJSON> list=service.listResourceList();
		
		JSONObject job=new JSONObject();
		job.put("list", list);

		resp.setContentType("application/json");
		resp.setCharacterEncoding("utf-8");

		PrintWriter out = resp.getWriter();
		out.print(job.get("list"));
		out.flush();
		out.close();
	}
*/
	
	@RequestMapping(value="/scheduler/events")
	@ResponseBody
	public List<ResourceJSON> events(
			@RequestParam String start,
			@RequestParam String end
			) throws Exception {
		Map<String, Object> map=new HashMap<>();
		map.put("start", start);
		map.put("end", end);
		
		List<ResourceJSON> list=service.listResourceScheduler(map);
		return list;
	}

	@RequestMapping(value="/scheduler/inputForm")
	public String inputForm(Model model) throws Exception {
		List<Resource> groupList=service.listResourceGroup();
		
		model.addAttribute("groupList", groupList);
		return "scheduler/inputForm";
	}

	@RequestMapping(value="/scheduler/readResourceList")
	@ResponseBody
	public Map<String, Object> readResourceList(int resourceNum) throws Exception {
		Resource dto=service.readResourceList(resourceNum);
		
		Map<String, Object> model=new HashMap<>();
		String state="true";
		if(dto==null) {
			state="false";
		} else {
			model.put("dto", dto);
		}
		
		model.put("state", state);
		return model;
	}

	@RequestMapping(value="/scheduler/listResourceList")
	@ResponseBody
	public Map<String, Object> listResourceList(int groupNum) throws Exception {
		List<Resource> list=service.listResourceList(groupNum);
		Map<String, Object> model=new HashMap<>();
		model.put("list", list);
		return model;
	}
	
	@RequestMapping(value="/scheduler/schedulerInsert")
	@ResponseBody
	public Map<String, Object> schedulerInsert(Resource dto,
			HttpSession session
			) throws Exception {
		
		String state="true";
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			dto.setUserId(info.getUserId());
			service.insertResourceScheduler(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	
	@RequestMapping(value="/scheduler/articleForm")
	public String articleForm(Model model) throws Exception {
		return "scheduler/articleForm";
	}
	
	@RequestMapping(value="/scheduler/schedulerUpdate")
	@ResponseBody
	public Map<String, Object> schedulerUpdate(Resource dto,
			HttpSession session
			) throws Exception {
		
		String state="true";
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			dto.setUserId(info.getUserId());
			service.updateResourceScheduler(dto);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}

	@RequestMapping(value="/scheduler/schedulerDelete")
	@ResponseBody
	public Map<String, Object> schedulerDelete(int num,
			HttpSession session
			) throws Exception {
		
		String state="true";
		try {
			SessionInfo info=(SessionInfo)session.getAttribute("member");
			Map<String, Object> map=new HashMap<>();
			map.put("userId", info.getUserId());
			map.put("num", num);
			
			service.deleteResourceScheduler(map);
		} catch (Exception e) {
			state="false";
		}
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
}
