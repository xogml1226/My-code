package com.sp.customer;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller("customer.customerController")
public class CustomerController {
	
	@RequestMapping("/customer/main")
	public String main() throws Exception {
		return ".customer.main";
	}
}
