package com.MeokZzang.recipe.vo;

import java.io.IOException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import com.MeokZzang.recipe.service.MemberService;
import com.MeokZzang.recipe.util.Ut;

import lombok.Getter;

@Component
@Scope(value = "request", proxyMode = ScopedProxyMode.TARGET_CLASS)
public class Rq {
	@Getter
	private boolean isAjax;
	@Getter
	private boolean isLogined;
	@Getter
	private int loginedMemberId;
	@Getter
	private Member loginedMember;

	private HttpServletRequest req;
	private HttpServletResponse resp;
	private HttpSession session;
	private Map<String, String> paramMap;

	public Rq(HttpServletRequest req, HttpServletResponse resp, MemberService memberService,
			HttpServletRequest request) {

		this.req = req;
		this.resp = resp;

		paramMap = Ut.getParamMap(req);

		this.session = req.getSession();

		boolean isLogined = false;
		int loginedMemberId = 0;
		Member loginedMember = null;

		if (session.getAttribute("loginedMemberId") != null) {
			isLogined = true;
			loginedMemberId = (int) session.getAttribute("loginedMemberId");
			loginedMember = memberService.getMemberById(loginedMemberId);
		}

		this.isLogined = isLogined;
		this.loginedMemberId = loginedMemberId;
		this.loginedMember = loginedMember;

		String requestUri = req.getRequestURI();

		boolean isAjax = requestUri.endsWith("Ajax");
		if (isAjax == false) {
			if (paramMap.containsKey("ajax") && paramMap.get("ajax").equals("Y")) {
				isAjax = true;
			} else if (paramMap.containsKey("isAjax") && paramMap.get("isAjax").equals("Y")) {
				isAjax = true;
			}
		}
		if (isAjax == false) {
			if (requestUri.contains("/get")) {
				isAjax = true;
			}
		}
		this.isAjax = isAjax;
	}

	public void printHistoryBackJs(String msg) {
		resp.setContentType("text/html; charset=UTF-8");

		print(Ut.jsHistoryBack(msg));
	}

	public String jsHistoryBackOnView(String msg) {
		req.setAttribute("msg", msg);
		req.setAttribute("historyBack", true);
		return "usr/common/js";
	}

	public String jsHistoryBackOnView(String resultCode, String msg) {
		req.setAttribute("msg", String.format("[%s] %s", resultCode, msg));
		req.setAttribute("historyBack", true);
		return "usr/common/js";
	}

	public String jsHistoryBack(String resultCode, String msg) {
		msg = String.format("[%s] %s", resultCode, msg);
		return Ut.jsHistoryBack(msg);
	}

	public String jsHistoryBack(String msg) {
		return Ut.jsHistoryBack(msg);
	}

	public String jsReplace(String msg, String uri) {
		return Ut.jsReplace(msg, uri);
	}

	public void print(String str) {
		try {
			resp.getWriter().append(str);
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public void println(String str) {
		print(str + "\n");
	}

	public void login(Member member) {
		session.setAttribute("loginedMemberId", member.getId());
	}

	public boolean isNotLogined() {
		return !isLogined;
	}

	public void logout() {
		session.removeAttribute("loginedMemberId");
	}

	public String getCurrentUri() {
		String currentUri = req.getRequestURI();
		String queryString = req.getQueryString();

		if (queryString != null && queryString.length() > 0) {
			currentUri += "?" + queryString;
		}

		return currentUri;
	}

	public String getEncodedCurrentUri() {

		return Ut.getUriEncoded(getCurrentUri());
	}

	public void printReplaceJs(String msg, String url) {
		resp.setContentType("text/html; charset=UTF-8");
		print(Ut.jsReplace(msg, url));
	}

	public String getLoginUri() {
		return "/usr/member/login?afterLoginUri=" + getAfterLoginUri();
	}

	public String getFindLoginIdUri() {
		return "/usr/member/findLoginId?afterFindLoginIdUri=" + getAfterFindLoginIdUri();
	}

	public String getFindLoginPwUri() {
		return "/usr/member/findLoginPw?afterFindLoginPwUri=" + getAfterFindLoginPwUri();
	}

	public String getAfterFindLoginIdUri() {
		return getEncodedCurrentUri();
	}

	public String getAfterFindLoginPwUri() {
		return getEncodedCurrentUri();
	}

	public String getAfterLoginUri() {

		String requestUri = req.getRequestURI();

		// 로그인 후 다시 돌아가면 안되는 URL
		switch (requestUri) {
		case "/usr/member/login":
		case "/usr/member/join":
		case "/usr/member/findLoginId":
		case "/usr/member/findLoginPw":
			return Ut.getUriEncoded(Ut.getStrAttr(paramMap, "afterLoginUri", ""));
		}
		return getEncodedCurrentUri();
	}

	public String getJoinUri() {
		return "/usr/member/join?afterLoginUri=" + getAfterLoginUri();
	}

	public String getLogoutUri() {

		String requestUri = req.getRequestURI();

		return "/usr/member/doLogout?afterLogoutUri=" + getAfterLogoutUri();
	}

	public String getAfterLogoutUri() {
		String requestUri = req.getRequestURI();
		// 로그아웃 후 다시 돌아가면 안되는 URL
		switch (requestUri) {
		case "/adm/member/list":
			return Ut.getUriEncoded(Ut.getStrAttr(paramMap, "afterLoginUri", ""));
		}
		return getEncodedCurrentUri();
	}

	public String getArticleDetailUriFromArticleList(Article article) {

		return "../article/detail?id=" + article.getId() + "&listUri=" + getEncodedCurrentUri();
	}

	// 관리자 전용
	public boolean isAdmin() {
		if (isLogined == false) {
			return false;
		}

		return loginedMember.isAdmin();
	}

	// 프로필 이미지 가져오기
	public String getProfileImgUri(int membeId) {

		return "/common/genFile/file/member/" + membeId + "/extra/profileImg/1";
	}

	// 이미지 없을 시 리턴값
	public String getProfileFallbackImgUri() {

		return "https://raw.githubusercontent.com/pporong/Site_MeokZzang/8a022c533f3e6e2214285320fa4d03ca3789bc55/MeokZzang_ImgFile/member/2022_12/1.png";
	}

	public String getProfileFallbackImgOnErrorHtml() {

		return "this.src = '" + getProfileFallbackImgUri() + "'";
	}

	public String getRemoveProfileImgIfNotExitOnErrorHtmlAttr() {
		return "$(this).remove()";
	}

	// 레시피 대표이미지 가져오기 -> 얘는 삭제 안 되고 수정만 가능
	public String getMainRecipeImgUri(int recipeId) {
		return "/common/genFile/file/recipe/" + recipeId + "/extra/mainRecipeImg/1";
	}

	public String getMainRecipeFallbackImgUri() {
		return "https://raw.githubusercontent.com/pporong/Site_MeokZzang/8a022c533f3e6e2214285320fa4d03ca3789bc55/MeokZzang_ImgFile/member/2022_12/1.png";
	}

	public String getMainRecipeFallbackImgOnErrorHtml() {
		return "this.src = '" + getMainRecipeFallbackImgUri() + "'";
	}

	// 레시피 조리순서이미지 가져오기
	public String getRecipeOrderImgUri(int recipeId, int fileNoCount) {
		return "/common/genFile/file/order/" + recipeId + "/extra/recipeOrderImg/" + fileNoCount;
	}

	public String getOrderFallbackImgUri() {
		return "https://via.placeholder.com/300/?text=...";
	}

	public String getOrderFallbackImgOnErrorHtml() {
		return "this.src = '" + getOrderFallbackImgUri() + "'";
	}

}