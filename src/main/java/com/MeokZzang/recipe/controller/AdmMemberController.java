package com.MeokZzang.recipe.controller;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.MeokZzang.recipe.service.MemberService;
import com.MeokZzang.recipe.vo.Member;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class AdmMemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private Rq rq;
	
	// list
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

		return "adm/member/list";
	}
	
	// 관리자 회원 삭제 기능
	@RequestMapping("/adm/member/doDeleteMembers")
	@ResponseBody
	public String doDelete(@RequestParam(defaultValue = "") String ids, @RequestParam(defaultValue = "/adm/member/list") String replaceUri) {
		
		List<Integer> memberIds = new ArrayList<>();

		for ( String idStr : ids.split(",")) {
			memberIds.add(Integer.parseInt(idStr));
		}

		memberService.deleteMembers(memberIds);

		return rq.jsReplace("선택 회원이 삭제되었습니다.", replaceUri);
	}
}