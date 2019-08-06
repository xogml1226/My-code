package com.sp.user.member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.web.authentication.SavedRequestAwareAuthenticationSuccessHandler;

// 로그인 성공후 세션 및 쿠키등의 처리
public class MyAuthenticationSuccessHandler extends SavedRequestAwareAuthenticationSuccessHandler {

	@Autowired
	private MemberService service;
	@Override
	public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
			Authentication authentication) throws ServletException, IOException {
		
		HttpSession session=request.getSession();
		
		try {
			
			// 로그인 정보 변경
			Member dto=service.readMember(authentication.getName());
			SessionInfo info=new SessionInfo();
			info.setUserId(dto.getUserId());
			info.setUserName(dto.getUserName());
			info.setEnabled(dto.getEnabled());
			
			session.setAttribute("member", info);
		} catch (Exception e) {
		}
		
		super.onAuthenticationSuccess(request, response, authentication);
	}

	
}
