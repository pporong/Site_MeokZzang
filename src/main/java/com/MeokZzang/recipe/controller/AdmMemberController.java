package com.MeokZzang.recipe.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.MeokZzang.recipe.service.ArticleService;
import com.MeokZzang.recipe.service.MemberService;
import com.MeokZzang.recipe.util.Ut;
import com.MeokZzang.recipe.vo.Article;
import com.MeokZzang.recipe.vo.Member;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class AdmMemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private Rq rq;

	// 회원 목록
	@RequestMapping("/adm/member/list")
	public String showList(Model model, @RequestParam(defaultValue = "0") int authLevel,
			@RequestParam(defaultValue = "loginId,name,nickname") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword, @RequestParam(defaultValue = "1") int page) {

		int membersCount = memberService.getMembersCount(authLevel, searchKeywordTypeCode, searchKeyword);

		int itemsInAPage = 10;

		// 한 페이지당 글 intemInAPage 갯수
		int pagesCount = (int) Math.ceil((double) membersCount / itemsInAPage);

		List<Member> members = memberService.getForPrintMembers(authLevel, searchKeywordTypeCode, searchKeyword,
				itemsInAPage, page);

		model.addAttribute("authLevel", authLevel);
		model.addAttribute("searchKeywordTypeCode", searchKeywordTypeCode);
		model.addAttribute("searchKeyword", searchKeyword);

		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("page", page);

		model.addAttribute("membersCount", membersCount);
		model.addAttribute("members", members);

		return "adm/member/memberList";
	}

	// 관리자 회원 삭제 기능
	@RequestMapping("/adm/member/doDeleteMembers")
	@ResponseBody
	public String doDelete(@RequestParam(defaultValue = "") String ids) {

		List<Integer> memberIds = new ArrayList<>();

		for (String idStr : ids.split(",")) {
			memberIds.add(Integer.parseInt(idStr));
		}

		memberService.deleteMembers(memberIds);

		return rq.jsReplace("선택 회원이 삭제되었습니다.", "/adm/member/list");
	}
	
	// 회원 글 목록
	@RequestMapping("/adm/member/detail")
	public String viewDetail(Model model, int id, @RequestParam(defaultValue = "1") int page) {

		int articlesCount = memberService.getArticlesCount(rq.getLoginedMemberId());
				
		int itemsInAPage = 15;
		int pagesCount = (int) Math.ceil((double) articlesCount / itemsInAPage);
		
		List<Article> articles = memberService.getArticlesByMemberId(rq.getLoginedMemberId(), itemsInAPage, page);
		
		model.addAttribute("articles", articles);
		model.addAttribute("articlesCount", articlesCount);
		model.addAttribute("pagesCount", pagesCount);
		model.addAttribute("page", page);
		
		return "adm/member/memberDetail";
	}
}