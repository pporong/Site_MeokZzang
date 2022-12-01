package com.MeokZzang.recipe.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import com.MeokZzang.recipe.vo.Rq;

@Component
public class NeedLoginInterceptor implements HandlerInterceptor {

	@Autowired
	private Rq rq;
	
	@Override
	public boolean preHandle(HttpServletRequest req, HttpServletResponse resp, Object handler) throws Exception {
		
		if (!rq.isLogined()) {
			if (rq.isAjax()) {
				resp.setContentType("application/json; charset=UTF-8");
				resp.getWriter().append("{\"resultCode\":\"F-A\",\"msg\":\"!! 로그인 후 이용해주세요 !!\"}");
			} else {
				String afterLoginUri = rq.getAfterLoginUri();
				rq.printReplaceJs("!! 로그인 후 이용해주세요 !!", "usr/member/login?afterLoginUri=" + afterLoginUri);
			}
			return false;
		}

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}

}
