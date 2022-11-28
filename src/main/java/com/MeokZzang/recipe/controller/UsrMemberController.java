package com.MeokZzang.recipe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.MeokZzang.recipe.service.MemberService;
import com.MeokZzang.recipe.util.Ut;
import com.MeokZzang.recipe.vo.Member;
import com.MeokZzang.recipe.vo.ResultData;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class UsrMemberController {

	@Autowired
	private MemberService memberService;
	@Autowired
	private Rq rq;

	// join
	@RequestMapping("/usr/member/join")
	public String viewJoin() {
		return "usr/member/join";
	}

	@RequestMapping("usr/member/doJoin")
	@ResponseBody
	public ResultData<Member> doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email) {

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
	@RequestMapping("usr/member/login")
	public String viewLogin() {
		return "usr/member/login";
	}

	@RequestMapping("usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw) {

		if (Ut.empty(loginId)) {
			return Ut.jsHistoryBack("아이디를 입력해주세요");
		}

		if (Ut.empty(loginPw)) {
			return Ut.jsHistoryBack("비밀번호를 입력해주세요");
		}

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsHistoryBack("일치하는 정보가 없습니다. 확인 후 다시 시도 해 주세요.");
		}

		if (member.getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("비밀번호가 일치하지 않습니다");
		}

		rq.login(member);

		return Ut.jsReplace(Ut.f("%s님 환영합니다", member.getNickname()), "/");
	}

	// logout
	@RequestMapping("usr/member/doLogout")
	@ResponseBody
	public String doLogout() {

		rq.logout();

		return Ut.jsReplace("로그아웃 되었습니다 ~", "/");
	}

	// myPage
	@RequestMapping("usr/member/myPage")
	public String showMyPage() {

		return "usr/member/myPage";
	}

	// 비밀번호 확인
	@RequestMapping("usr/member/checkPassword")
	public String shoWCheckPassword() {

		return "usr/member/checkPassword";
	}

	@RequestMapping("usr/member/doCheckPw")
	@ResponseBody
	public String doCheckPw(String loginPw, String replaceUri) {
		
		if (Ut.empty(loginPw)) {
			System.out.println(loginPw + "    ??");
			return rq.jsHistoryBack("!! 비밀번호를 입력 해 주세요. !!");
		}
		
		if (rq.getLoginedMember().getLoginPw().equals(loginPw) == false) {
			System.out.println(loginPw + "   일치X");
			return Ut.jsHistoryBack("!! 비밀번호가 일치하지 않습니다. !!");
		}
		
		// memberModifyAuthKey
		if (replaceUri.equals("../member/modifyMyInfo")) {
			String memberModifyAuthKey = memberService.genMemberModifyAuthKey(rq.getLoginedMemberId());
			replaceUri += "?memberModifyAuthKey=" + memberModifyAuthKey;
		}
		
		return rq.jsReplace("", replaceUri);
	}

	public String modifyMyInfo(String memberModifyAuthKey) {

		if (Ut.empty(memberModifyAuthKey)) {
			return rq.jsHistoryBackOnView("!! 회원 수정 인증코드가 필요합니다. !!");
		}

		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(), memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.jsHistoryBackOnView(checkMemberModifyAuthKeyRd.getMsg());
		}

		return "usr/member/modifyMyInfo";
	}

	// 개인정보수정
	@RequestMapping("usr/member/doModifyMyInfo")
	@ResponseBody
	public String doModifyMyInfo(String memberModifyAuthKey, String loginPw, String nickname, String cellphoneNum, String email) {

		if (Ut.empty(memberModifyAuthKey)) {
			return rq.jsHistoryBack("!! 회원 수정 인증코드가 필요합니다. !!");
		}

		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(), memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.jsHistoryBack(checkMemberModifyAuthKeyRd.getMsg());
		}

		if(Ut.empty(loginPw)) {
			loginPw = null;
			return rq.jsHistoryBack("비밀번호를 입력해주세요");
		}
		if (Ut.empty(nickname)) {
			return rq.jsHistoryBack("닉네임을 입력해주세요");
		}
		if (Ut.empty(cellphoneNum)) {
			return rq.jsHistoryBack("전화번호를 입력해주세요");
		}
		if (Ut.empty(email)) {
			return rq.jsHistoryBack("이메일을 입력해주세요");
		}
		
		ResultData modifyMyInfoRd = memberService.modifyMyInfo(rq.getLoginedMemberId(), loginPw, nickname, cellphoneNum, email);
		
		return Ut.jsReplace(modifyMyInfoRd.getMsg(), "/");

	}
}
