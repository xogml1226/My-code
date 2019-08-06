package com.sp.chat;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("chat.chattingController")
public class ChattingController {
	@RequestMapping(value="/chat/main")
	public String main(
			Model model) throws Exception {
		return ".chat.chat";
	}
}
