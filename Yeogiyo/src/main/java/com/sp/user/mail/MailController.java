package com.sp.user.mail;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

@Controller("user.mail.mailController")
public class MailController {

	@Autowired
	private MailSender mailSender;
	
	@Autowired
	private BCryptPasswordEncoder bcrypt;
	
	@RequestMapping(value="/user/mail/findId", method=RequestMethod.GET)
	public String findId(Model model, String message) throws Exception {
		model.addAttribute("title", "아이디 찾기");
		model.addAttribute("mode", "findId");
		model.addAttribute("message", message);
		return ".user.mail.find";
	}
	
	@RequestMapping(value="/user/mail/findPwd", method=RequestMethod.GET)
	public String findPwd(Model model, String message) throws Exception {
		model.addAttribute("title", "비밀번호 찾기");
		model.addAttribute("mode", "findPwd");
		model.addAttribute("message", message);
		return ".user.mail.find";
	}
	
	@RequestMapping(value="/user/mail/send", method=RequestMethod.POST)
	public String sendSubmit(Mail dto, Model model) throws Exception {

		if(dto.getUserId()==null) {
			
			String userId=mailSender.readId(dto);
			if(userId==null) {
				model.addAttribute("message", "이름 또는 이메일 또는 핸드폰번호가 틀립니다.");
				return "redirect:/user/mail/findId";
			}
			
			dto.setUserId(userId);
			dto.setSubject("여기요 아이디 찾기");
			
			String content="당신의 회원 아이디는 <b>"+userId+"</b>입니다";
			dto.setContent(content);
			
			model.addAttribute("title", "아이디찾기");
			
		} else {
			String userPwd=mailSender.readPwd(dto);
			if(userPwd==null) {
				model.addAttribute("message", "아이디 또는 이름 또는 이메일 또는 핸드폰번호가 틀립니다.");
				return "redirect:/user/mail/findPwd";
			}
			
			String randomPwd=mailSender.getRandomPwd();
			
			try {
				String pwd=bcrypt.encode(randomPwd);
				Map<String, Object> map=new HashMap<>();
				map.put("userPwd", pwd);
				map.put("userId", dto.getUserId());
				mailSender.updatePwd(map);
			} catch (Exception e) {
			}
			
			dto.setSubject("여기요 비밀번호 찾기");
			
			String content="당신의 임시 비밀번호는 <b>"+randomPwd+"</b>입니다";
			dto.setContent(content);
			
			model.addAttribute("title", "비밀번호찾기");
		}
		
		dto.setSenderEmail("xogml1226@naver.com");
		dto.setSenderName("이태희");
		
		boolean b=mailSender.mailSend(dto);
		
		String msg="<span style='color:blue;'>"+dto.getUserEmail()+"</span> 님에게<br>";
		if(b) {
			msg+="메일을 성공적으로 전송 했습니다.";
		} else {
			msg+="메일을 전송하는데 실패했습니다.";
		}
		
		model.addAttribute("message", msg);
		
		return ".user.mail.complete";
	}
	
}
