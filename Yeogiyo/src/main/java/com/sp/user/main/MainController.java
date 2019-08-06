package com.sp.user.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("user.mainController")
public class MainController {
	
	@RequestMapping(value="/user/main")
	public String test() {
		return ".userLayout";
	}
}
