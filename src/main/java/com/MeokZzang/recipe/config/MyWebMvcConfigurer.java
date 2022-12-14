package com.MeokZzang.recipe.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import com.MeokZzang.recipe.interceptor.BeforeActionInterceptor;
import com.MeokZzang.recipe.interceptor.NeedAdminInterceptor;
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
	// NeedAdminInterceptor 불러오기
	@Autowired
	NeedAdminInterceptor needAdminInterceptor;

	@Value("${custom.genFileDirPath}")
	private String genFileDirPath;

	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("/gen/**").addResourceLocations("file:///" + genFileDirPath + "/")
				.setCachePeriod(20);
	}
	
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
		ir.addPathPatterns("/usr/member/doCheckPw");
		ir.addPathPatterns("/usr/member/modifyMyInfo");
		ir.addPathPatterns("/usr/member/doModifyMyInfo");
		ir.addPathPatterns("/usr/member/doLogout");
		ir.addPathPatterns("/usr/member/deleteMyInfo");
		ir.addPathPatterns("/usr/member/doDeleteMyInfo");

		ir.addPathPatterns("/usr/article/write");
		ir.addPathPatterns("/usr/article/doWrite");
		ir.addPathPatterns("/usr/article/modify");
		ir.addPathPatterns("/usr/article/doModify");
		ir.addPathPatterns("/usr/article/doDelete");
		
		ir.addPathPatterns("/usr/recipe/writeRecipe");
		ir.addPathPatterns("/usr/recipe/doWriteRecipe");
		ir.addPathPatterns("/usr/recipe/modifyRecipe");
		ir.addPathPatterns("/usr/recipe/doModifyRecipe");
		ir.addPathPatterns("/usr/recipe/doDeleteRecipe");

		ir.addPathPatterns("/usr/reactionPoint/doGoodReaction");
		ir.addPathPatterns("/usr/reactionPoint/doBadReaction");
		ir.addPathPatterns("/usr/reactionPoint/doDeleteGoodReaction");
		ir.addPathPatterns("/usr/reactionPoint/doDeleteBadReaction");

		ir.addPathPatterns("/usr/scrapPoint/doScrap");
		ir.addPathPatterns("/usr/scrapPoint/doDeleteScrap");
		
		ir.addPathPatterns("/usr/reactionPoint/doGoodReactionReply");
		ir.addPathPatterns("/usr/reactionPoint/doDeleteGoodReactionReply");
		ir.addPathPatterns("/usr/reactionPoint/doBadReactionReply");
		ir.addPathPatterns("/usr/reactionPoint/doDeleteBadReactionReply");

		ir.addPathPatterns("/usr/reply/doWrite");
		ir.addPathPatterns("/usr/reply/doDelete");
		ir.addPathPatterns("/usr/reply/modify");
		ir.addPathPatterns("/usr/reply/doModify");

		ir.addPathPatterns("/adm/**");
		ir.addPathPatterns("/adm/member/login");
		ir.addPathPatterns("/adm/member/doLogin");
		ir.addPathPatterns("/adm/member/findLoginId");
		ir.addPathPatterns("/adm/member/doFindLoginId");
		ir.addPathPatterns("/adm/member/findLoginPw");
		ir.addPathPatterns("/adm/member/doFindLoginPw");
		ir.addPathPatterns("/adm/member/list");
		ir.addPathPatterns("/adm/member/detail");

		// logout 필요
		ir = registry.addInterceptor(NeedLogoutInterceptor);
		ir.addPathPatterns("/usr/member/login");
		ir.addPathPatterns("/usr/member/doLogin");
		ir.addPathPatterns("/usr/member/getLoginIdDup");
		ir.addPathPatterns("/usr/member/doCheckLoginId");
		ir.addPathPatterns("/usr/member/join");
		ir.addPathPatterns("/usr/member/doJoin");
		ir.addPathPatterns("/usr/member/findLoginId");
		ir.addPathPatterns("/usr/member/goFindLoginId");
		ir.addPathPatterns("/usr/member/findLoginPw");
		ir.addPathPatterns("/usr/member/goFindLoginPw");

		ir.addPathPatterns("/usr/member/getNicknameDup");
		ir.addPathPatterns("/usr/member/doCheckNickname");

		// adm
		ir = registry.addInterceptor(needAdminInterceptor);
		ir.addPathPatterns("/adm/**");
		ir.addPathPatterns("/adm/member/login");
		ir.addPathPatterns("/adm/member/doLogin");
		ir.addPathPatterns("/adm/member/findLoginId");
		ir.addPathPatterns("/adm/member/doFindLoginId");
		ir.addPathPatterns("/adm/member/findLoginPw");
		ir.addPathPatterns("/adm/member/doFindLoginPw");
		ir.addPathPatterns("/adm/member/list");
		ir.addPathPatterns("/adm/member/detail");
	}
}
