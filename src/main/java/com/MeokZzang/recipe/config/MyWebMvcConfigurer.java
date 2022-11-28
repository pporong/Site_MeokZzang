package com.MeokZzang.recipe.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.MeokZzang.recipe.interceptor.BeforeActionInterceptor;
import com.MeokZzang.recipe.interceptor.NeedLoginInterceptor;
import com.MeokZzang.recipe.interceptor.NeedLogoutInterceptor;

@Configuration
public class MyWebMvcConfigurer implements WebMvcConfigurer {
	// BeforeActionInterceptor 불러오기
	@Autowired
	BeforeActionInterceptor beforeActionInterceptor;
	// NeedLoginInterceptor 불러오기
	@Autowired
	NeedLoginInterceptor needLoginInterceptor;
	// NeedLogoutInterceptor 불러오기
	@Autowired
	NeedLogoutInterceptor NeedLogoutInterceptor;
	
	// 인터셉터 적용
	public void addInterceptors(InterceptorRegistry registry) {
		
		InterceptorRegistration ir;

		// 실행되자마자
		ir = registry.addInterceptor(beforeActionInterceptor);
		ir.addPathPatterns("/**");
		ir.addPathPatterns("/favicon.ico");
		ir.excludePathPatterns("/resource/**");
		ir.excludePathPatterns("/error");
		
		// login필요
				ir = registry.addInterceptor(needLoginInterceptor);
				ir.addPathPatterns("/usr/member/myPage");
				ir.addPathPatterns("/usr/member/checkPassword");
				ir.addPathPatterns("/usr/member/doCheckPassword");
				ir.addPathPatterns("/usr/member/modifyMyInfo");
				ir.addPathPatterns("/usr/member/doModifyMyInfo");
				ir.addPathPatterns("/usr/member/doLogout");

				ir.addPathPatterns("/usr/article/write");
				ir.addPathPatterns("/usr/article/doWrite");
				ir.addPathPatterns("/usr/article/modify");
				ir.addPathPatterns("/usr/article/doModify");
				ir.addPathPatterns("/usr/article/doDelete");

				ir.addPathPatterns("/usr/reactionPoint/doGoodReaction");
				ir.addPathPatterns("/usr/reactionPoint/doBadReaction");
				ir.addPathPatterns("/usr/reactionPoint/doDeleteGoodReaction");
				ir.addPathPatterns("/usr/reactionPoint/doDeleteBadReaction");
				ir.addPathPatterns("/usr/reactionPoint/doGoodReactionReply");
				ir.addPathPatterns("/usr/reactionPoint/doDeleteGoodReactionReply");
				ir.addPathPatterns("/usr/reactionPoint/doBadReactionReply");
				ir.addPathPatterns("/usr/reactionPoint/doDeleteBadReactionReply");

				ir.addPathPatterns("/usr/reply/doWrite");
				ir.addPathPatterns("/usr/reply/doDelete");
				ir.addPathPatterns("/usr/reply/modify");
				ir.addPathPatterns("/usr/reply/doModify");

				// logout 필요
				ir = registry.addInterceptor(NeedLogoutInterceptor);
				ir.addPathPatterns("/usr/member/login");
				ir.addPathPatterns("/usr/member/doLogin");
				ir.addPathPatterns("/usr/member/join");
				ir.addPathPatterns("/usr/member/doJoin");
				ir.addPathPatterns("/usr/member/findLoginId");
				ir.addPathPatterns("/usr/member/doFindLoginId");
				ir.addPathPatterns("/usr/member/findLoginPw");
				ir.addPathPatterns("/usr/member/doFindLoginPw");
	}
}
