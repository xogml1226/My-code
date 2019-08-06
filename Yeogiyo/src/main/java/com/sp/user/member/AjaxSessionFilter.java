package com.sp.user.member;

import java.io.IOException;
import java.nio.file.AccessDeniedException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.AuthenticationException;

public class AjaxSessionFilter implements Filter {
	private String ajaxHeader;

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
			throws IOException, ServletException {
		HttpServletRequest req=(HttpServletRequest)request;
		HttpServletResponse resp=(HttpServletResponse)response;
		
		if(isAjaxRequest(req)) {
			try {
				chain.doFilter(req, resp);
			} catch (AccessDeniedException e) {
				// 권한이 없거나 로그인이 되지 않은 경우
				resp.sendError(403);
			} catch (AuthenticationException e) {
				resp.sendError(401);
			}
		} else {
			chain.doFilter(req, resp);
		}
		
	}

	public void setAjaxHeader(String ajaxHeader) {
		this.ajaxHeader = ajaxHeader;
	}
	
	private boolean isAjaxRequest(HttpServletRequest req) {
		return req.getHeader(ajaxHeader)!=null &&
				req.getHeader(ajaxHeader).equals(Boolean.TRUE.toString());
	}
	
	@Override
	public void destroy() {
		// TODO Auto-generated method stub
		
	}

}
