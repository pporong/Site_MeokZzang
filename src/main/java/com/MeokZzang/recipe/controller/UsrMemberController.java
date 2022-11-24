package com.MeokZzang.recipe.controller;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.MeokZzang.recipe.service.MemberService;
import com.MeokZzang.recipe.util.Ut;
import com.MeokZzang.recipe.vo.Member;
import com.MeokZzang.recipe.vo.ResultData;

@Controller
public class UsrMemberController {

	@Autowired
	private MemberService memberService;

	// join
	@RequestMapping("/usr/member/join")
	public String viewJoin() {
		return "usr/member/join";
	}
	
	@RequestMapping("usr/member/doJoin")
	@ResponseBody
	public ResultData<Member> doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email) {

		if (Ut.empty(loginId)) {
			return ResultData.from("F-1", "!! 아이디를 입력 해 주세요 !!");
		}
		if (Ut.empty(loginPw)) {
			return ResultData.from("F-2", "!! 비밀번호를 입력 해 주세요 !!");
		}
		if (Ut.empty(name)) {
			return ResultData.from("F-3", "!! 이름을 입력해주세요 !!");
		}
		if (Ut.empty(nickname)) {
			return ResultData.from("F-4", "!! 닉네임을 입력해주세요 !!");
		}
		if (Ut.empty(cellphoneNum)) {
			return ResultData.from("F-5", "!! 전화번호를 입력해주세요 !!");
		}
		if (Ut.empty(email)) {
			return ResultData.from("F-6", "!! 이메일을 입력해주세요 !!");
		}
		
		ResultData<Integer> joinRd = memberService.join(loginId, loginPw, name, nickname, cellphoneNum, email);
		
		if (joinRd.isFail()) {
			return (ResultData) joinRd;
		}
	
		Member member = memberService.getMemberById(joinRd.getData1());

		return ResultData.newData(joinRd, "member", member);
	}
	
	// login
	@RequestMapping("usr/member/doLogin")
	@ResponseBody
	public ResultData doLogin(HttpSession httpSession, String loginId, String loginPw) {
		boolean isLogined = false;

		if (httpSession.getAttribute("loginedMemberId") != null) {
			isLogined = true;
		}

		if (isLogined) {
			return ResultData.from("F-5", "!! 이미 로그인 상태입니다. !!");
		}

		if (Ut.empty(loginId)) {
			return ResultData.from("F-1", "아이디를 입력해주세요");
		}

		if (Ut.empty(loginPw)) {
			return ResultData.from("F-2", "비밀번호를 입력해주세요");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return ResultData.from("F-3", "아이디를 잘못 입력했습니다");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return ResultData.from("F-4", "!! 비밀번호가 일치하지 않습니다 !!");
		}

		httpSession.setAttribute("loginedMemberId", member.getId());

		return ResultData.from("S-1", Ut.f(Ut.f("!! 반갑습니다. %s님 ! :)", member.getNickname())));
	}
	
	// logout
	@RequestMapping("usr/member/doLogout")
	@ResponseBody
	public ResultData doLogout(HttpSession httpSession) {
		boolean isLogined = false;

		if (httpSession.getAttribute("loginedMemberId") == null) {
			isLogined = true;
		}

		if (isLogined) {
			return ResultData.from("F-1", "로그아웃 상태입니다");
		}

		httpSession.removeAttribute("loginedMemberId");

		return ResultData.from("S-1", "로그아웃 되었습니다 ~");
	}

}
