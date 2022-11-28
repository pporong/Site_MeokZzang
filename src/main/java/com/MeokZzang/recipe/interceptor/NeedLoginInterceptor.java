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
			rq.printReplaceJs("!! 로그인 후 이용 할 수 있습니다. !!", "../member/login");
			return false;
		}

		return HandlerInterceptor.super.preHandle(req, resp, handler);
	}

}
