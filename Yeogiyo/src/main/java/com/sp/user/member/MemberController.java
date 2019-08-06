package com.sp.user.member;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller("user.member.memberController")
public class MemberController {
	
	@Autowired
	private MemberService service;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@RequestMapping("/user/member/noAuthorized")
	public String noAuthorized(Model model) throws Exception {
		model.addAttribute("title", "경고 !!!");
		model.addAttribute("message", "해당 페이지로 갈수 있는 권한이 없습니다.");
		return ".user.member.caution";
	}
	
	@RequestMapping("/user/member/expired")
	public String expired(Model model) throws Exception {
		model.addAttribute("title", "세션 만료");
		model.addAttribute("message", "로그아웃 되었습니다.");
		return ".user.member.caution";
	}
	
	@RequestMapping(value="/user/member/login", method=RequestMethod.GET)
	public String login(String login_error, Model model) {
		if(login_error!=null) {
			model.addAttribute("message", "아이디 또는 패스워드가 일치하지 않습니다.");
		}
		return ".user.member.login";
	}

	@RequestMapping(value="/user/member/join", method=RequestMethod.GET)
	public String memberForm(Model model) {
		model.addAttribute("mode", "join");
		return ".user.member.member";
	}

	@RequestMapping(value="/user/member/join", method=RequestMethod.POST)
	public String memberSubmit(Member dto, Model model) {
		
		try {
			//패스워드 암호화
			String pwd=bcrypt.encode(dto.getUserPwd());
			dto.setUserPwd(pwd);
			
			service.insertMember(dto);
		} catch (Exception e) {
			model.addAttribute("mode", "join");
			model.addAttribute("message", "아이디 중복으로 회원가입이 실패했습니다.");
				
			return ".user.member.member";
		}
		
		StringBuffer sb=new StringBuffer();
		sb.append(dto.getUserId()+ "님의 회원 가입이 정상적으로 처리되었습니다.<br>");
		sb.append("메인화면으로 이동하여 로그인 하시기 바랍니다.<br>");
		
		model.addAttribute("message", sb.toString());
		model.addAttribute("title", "회원 가입");
		
		return ".user.member.complete";
	}
	
	@RequestMapping(value="/user/member/memberInfo", method=RequestMethod.GET)
	public String memberInfo(HttpSession session, Model model) {
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		Member dto=service.readMember(info.getUserId());
		model.addAttribute("dto", dto);
		return ".user.member.memberInfo";
	}
	
	@RequestMapping(value="/user/member/pwd", method=RequestMethod.GET)
	public String pwdForm(@RequestParam String mode, Model model) {
		
		model.addAttribute("mode", mode);

		return ".user.member.pwd";
	}
	
	@RequestMapping(value="/user/member/pwd", method=RequestMethod.POST)
	public String pwdSubmit(
			@RequestParam String userPwd,
			@RequestParam String mode,
			Model model,
			HttpSession session
	     ) throws Exception {
		
		SessionInfo info=(SessionInfo)session.getAttribute("member");
		
		Member dto=service.readMember(info.getUserId());
		if(dto==null) {
			session.invalidate();
			return "redirect:/";
		}
		
		//패스워드 비교
		boolean b=bcrypt.matches(userPwd, dto.getUserPwd());
		
		if(! b) {
			if(mode.equals("update")) {
				model.addAttribute("mode", "update");
			} else {
				model.addAttribute("mode", "delete");
			}
			model.addAttribute("message", "패스워드가 일치하지 않습니다.");
			return ".user.member.pwd";
		}
		
		if(mode.equals("delete")){

			// 세션 정보 삭제
			session.removeAttribute("member");
			session.invalidate();
			
			service.deleteMember(dto.getUserId());

			StringBuffer sb=new StringBuffer();
			sb.append(dto.getUserId()+ "님의 회원 탈퇴 처리가 정상적으로 처리되었습니다.<br>");
			sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
			
			model.addAttribute("title", "회원 탈퇴");
			model.addAttribute("message", sb.toString());
			
			return ".user.member.complete";
		}

		// 회원정보수정폼
		model.addAttribute("dto", dto);
		model.addAttribute("mode", "update");
		return ".user.member.member";
	}
	
	@RequestMapping(value="/user/member/update", method=RequestMethod.POST)
	public String updateSubmit(
			Member dto,
			Model model) throws Exception {
		
		try {
			String pwd=bcrypt.encode(dto.getUserPwd());
			dto.setUserPwd(pwd);
			
			service.updateMember(dto);
		} catch (Exception e) {
		}
		
		StringBuffer sb=new StringBuffer();
		sb.append(dto.getUserName()+ "님의 회원정보가 정상적으로 변경되었습니다.<br>");
		sb.append("메인화면으로 이동 하시기 바랍니다.<br>");
		
		model.addAttribute("title", "회원 정보 수정");
		model.addAttribute("message", sb.toString());
		return ".user.member.complete";
	}

	@RequestMapping(value="/user/member/userIdCheck", method=RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> idCheck(
			@RequestParam String userId
			) throws Exception {
		
		String state="true";
		Member dto=service.readMember(userId);
		if(dto!=null)
			state="false";
		
		Map<String, Object> model=new HashMap<>();
		model.put("state", state);
		return model;
	}
	

}
