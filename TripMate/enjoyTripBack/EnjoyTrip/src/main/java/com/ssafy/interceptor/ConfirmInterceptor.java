package com.ssafy.interceptor;

import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@Component
public class ConfirmInterceptor implements HandlerInterceptor { 

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
			throws Exception {
//		HttpSession session = request.getSession();
//		MemberDto memberDto = (MemberDto) session.getAttribute("userinfo");
//		if(memberDto == null) {
//			response.sendRedirect(request.getContextPath() + "/user/login");
//			return false;
//		}
		return true;
	}
	
}