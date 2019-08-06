package com.sp.owner.main;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("owner.mainController")
public class MainController {
	
	@RequestMapping(value="/owner/main")
	public String test() {
		return ".ownerLayout"; 
	}
}
