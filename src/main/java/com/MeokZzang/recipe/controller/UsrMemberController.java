package com.MeokZzang.recipe.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import com.MeokZzang.recipe.service.GenFileService;
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
	private GenFileService genFileService;
	@Autowired
	private Rq rq;

	// join
	@RequestMapping("/usr/member/join")
	public String viewJoin() {
		return "usr/member/join";
	}

	@RequestMapping("/usr/member/doJoin")
	@ResponseBody
	public String doJoin(String loginId, String loginPw, String name, String nickname, String cellphoneNum,
			String email, @RequestParam(defaultValue = "/") String afterLoginUri, MultipartRequest multipartRequest) {

		ResultData<Integer> joinRd = memberService.join(loginId, loginPw, name, nickname, cellphoneNum, email);

		if (joinRd.isFail()) {
			return rq.jsHistoryBack(joinRd.getResultCode(), joinRd.getMsg());
		}

		int newMemberId = (int) joinRd.getBody().get("id");

		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, newMemberId);
			}
		}

		String afterJoinUri = "../member/login?afterLoginUri=" + Ut.getUriEncoded(afterLoginUri);
		
		return rq.jsReplace("회원가입이 완료되었습니다~ 로그인 후 이용해주세요 :)", afterJoinUri);
	}

	// id 중복검사
	@RequestMapping("usr/member/doCheckLoginId")
	@ResponseBody
	public ResultData doCheckLoginId(String loginId) {

		if (Ut.empty(loginId)) {
			return ResultData.from("F-A1", "아이디를 입력해주세요");
		}

		Member oldMember = memberService.getMemberByLoginId(loginId);

		if (oldMember != null) {
			return ResultData.from("F-A2", "이미 존재하는 아이디 입니다.", "logindId", loginId);
		}

		return ResultData.from("S-A1", "사용 가능한 아이디 입니다.", "logindId", loginId);
	}

	// 닉네임 중복검사
	@RequestMapping("usr/member/doCheckNickname")
	@ResponseBody
	public ResultData doCheckNickname(String nickname) {

		if (Ut.empty(nickname)) {
			return ResultData.from("F-A1", "닉네임을 입력해주세요");
		}

		Member oldMember = memberService.getMemberByNickname(nickname);

		if (oldMember != null) {
			return ResultData.from("F-A2", "이미 존재하는 닉네임 입니다.", "nickname", nickname);
		}

		return ResultData.from("S-A1", "사용 가능한 닉네임 입니다.", "nickname", nickname);
	}

	// login
	@RequestMapping("/usr/member/login")
	public String viewLogin() {
		return "usr/member/login";
	}

	@RequestMapping("/usr/member/doLogin")
	@ResponseBody
	public String doLogin(String loginId, String loginPw, @RequestParam(defaultValue = "/") String afterLoginUri) {

		Member member = memberService.getMemberByLoginId(loginId);
		

		if (member == null) {
			return Ut.jsHistoryBack("일치하는 정보가 없습니다. 확인 후 다시 시도 해 주세요.");
		}
		
		if (member.getLoginPw().equals(loginPw) == false) {
			System.err.println("로그인 loginPw : " + loginPw);
			return Ut.jsHistoryBack("비밀번호가 일치하지 않습니다");
		}

		//
		System.err.println("loginPw : " + loginPw);
		
		rq.login(member);

		String infoMsg = Ut.f("%s님 환영합니다", member.getNickname());

		boolean isUsingTempPw = memberService.isUsingTempPw(member.getId());

		if (isUsingTempPw) {
			infoMsg = "!! 임시 비밀번호는 보안에 취약합니다. 변경 해 주세요 !!";
			afterLoginUri = "/usr/member/myPage";
		}

		return Ut.jsReplace(infoMsg, afterLoginUri);
	}

	// 로그인 아이디 찾기
	@RequestMapping("/usr/member/findLoginId")
	public String viewFindLoginId() {
		return "usr/member/findLoginId";
	}

	@RequestMapping("/usr/member/goFindLoginId")
	@ResponseBody
	public String goFindLoginId(String name, String email,
			@RequestParam(defaultValue = "/") String afterFindLoginIdUri) {

		Member member = memberService.getMemberByNameAndEmail(name, email);

		if (member == null) {
			return Ut.jsHistoryBack("!! 이름과 이메일을 다시 확인 해 주세요. !!");
		}

		return Ut.jsReplace(Ut.f("회원님의 아이디는 [ %s ] 입니다", member.getLoginId()), afterFindLoginIdUri);
	}

	// 로그인 비밀번호 찾기
	@RequestMapping("usr/member/findLoginPw")
	public String showFindLoginPw() {
		return "usr/member/findLoginPw";
	}

	@RequestMapping("usr/member/goFindLoginPw")
	@ResponseBody
	public String goFindLoginPw(String loginId, String email,
			@RequestParam(defaultValue = "/") String afterFindLoginPwUri) {

		Member member = memberService.getMemberByLoginId(loginId);

		if (member == null) {
			return Ut.jsHistoryBack("!! 일치하는 회원이 없습니다. !!");
		}

		if (member.getEmail().equals(email) == false) {
			return Ut.jsHistoryBack("!! 이메일을 다시 확인 해 주세요. !!");
		}

		ResultData notifyTempLoginPwByEmailRd = memberService.notifyTempLoginPwByEmailRd(member);

		return Ut.jsReplace(notifyTempLoginPwByEmailRd.getMsg(), afterFindLoginPwUri);
	}

	// logout
	@RequestMapping("/usr/member/doLogout")
	@ResponseBody
	public String doLogout(@RequestParam(defaultValue = "/") String afterLogoutUri) {
		if (!rq.isLogined()) {
			return Ut.jsHistoryBack("로그아웃 상태입니다");
		}
		rq.logout();

		return Ut.jsReplace("로그아웃 되었습니다 ~", afterLogoutUri);
	}

	// myPage
	@RequestMapping("/usr/member/myPage")
	public String showMyPage() {

		return "usr/member/myPage";
	}

	// 회원정보 변경시 비밀번호 확인
	@RequestMapping("/usr/member/checkPassword")
	public String showCheckPassword() {

		return "usr/member/checkPassword";
	}

	@RequestMapping("/usr/member/doCheckPw")
	@ResponseBody
	public String doCheckPw(String loginPw, String replaceUri) {
		
		if (Ut.empty(loginPw)) {
			return rq.jsHistoryBack("!! 비밀번호를 입력 해 주세요. !!");
		}

		if (rq.getLoginedMember().getLoginPw().equals(loginPw) == false) {
			return Ut.jsHistoryBack("!! 비밀번호가 일치하지 않습니다. !!");
		}

		// memberModifyAuthKey
		if (replaceUri.equals("../member/modifyMyInfo")) {
			String memberModifyAuthKey = memberService.genMemberModifyAuthKey(rq.getLoginedMemberId());

			replaceUri += "?memberModifyAuthKey=" + memberModifyAuthKey;
		}

		// memberDeleteAuthKey
		if (replaceUri.equals("../member/deleteMyInfo")) {
			String memberDeleteAuthKey = memberService.genMemberDeleteAuthKey(rq.getLoginedMemberId());

			replaceUri += "?memberDeleteAuthKey=" + memberDeleteAuthKey;
		}

		return rq.jsReplace("", replaceUri);
	}

	// 개인정보수정
	@RequestMapping("/usr/member/modifyMyInfo")
	public String modifyMyInfo(String memberModifyAuthKey) {

		if (Ut.empty(memberModifyAuthKey)) {
			return rq.jsHistoryBackOnView("!! 회원 수정 인증코드가 필요합니다. !!");
		}

		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(),
				memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.jsHistoryBackOnView(checkMemberModifyAuthKeyRd.getMsg());
		}

		return "usr/member/modifyMyInfo";
	}

	@RequestMapping("/usr/member/doModifyMyInfo")
	@ResponseBody
	public String doModifyMyInfo(HttpServletRequest req, String memberModifyAuthKey, String loginPw, String nickname, String cellphoneNum,
			String email, MultipartRequest multipartRequest) {

		if (Ut.empty(memberModifyAuthKey)) {
			return rq.jsHistoryBack("!! 회원 수정 인증코드가 필요합니다. !!");
		}

		ResultData checkMemberModifyAuthKeyRd = memberService.checkMemberModifyAuthKey(rq.getLoginedMemberId(), memberModifyAuthKey);

		if (checkMemberModifyAuthKeyRd.isFail()) {
			return rq.jsHistoryBack(checkMemberModifyAuthKeyRd.getMsg());
		}

		System.err.println("memberModifyAuthKey : " + memberModifyAuthKey);
		System.err.println("nickname : " + nickname);
		System.err.println("cellphoneNum : " + cellphoneNum);
		System.err.println("email : " + email);
		System.err.println("loginPw : " + loginPw);
		
		if (Ut.empty(loginPw)) {
			loginPw = null;
		}
		
		ResultData modifyMyInfoRd = memberService.modifyMyInfo(rq.getLoginedMemberId(), loginPw, nickname, cellphoneNum, email);

		if (req.getParameter("deleteFile__member__0__extra__profileImg__1") != null ) {
			
			System.out.println("실행됨.");
			
			genFileService.deleteGenFiles("member", rq.getLoginedMemberId(), "extra", "profileImg", 1);
		}
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();

		for (String fileInputName : fileMap.keySet()) {
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				genFileService.save(multipartFile, rq.getLoginedMemberId());
			}
		}

		return rq.jsReplace(modifyMyInfoRd.getMsg(), "/usr/member/myPage");
	}

	// 회원 탈퇴
	@RequestMapping("/usr/member/deleteMyInfo")
	public String deleteMyInfo(String memberDeleteAuthKey) {

		if (Ut.empty(memberDeleteAuthKey)) {
			return rq.jsHistoryBackOnView("!! 회원 삭제 인증코드가 필요합니다. !!");
		}

		ResultData checkMemberDeleteAuthKeyRd = memberService.checkMemberDeleteAuthKey(rq.getLoginedMemberId(),
				memberDeleteAuthKey);

		if (checkMemberDeleteAuthKeyRd.isFail()) {
			return rq.jsHistoryBackOnView(checkMemberDeleteAuthKeyRd.getMsg());
		}

		return "usr/member/deleteMyInfo";
	}

	@RequestMapping("/usr/member/doDeleteMyInfo")
	@ResponseBody
	public String doDeleteMyInfo(String memberDeleteAuthKey) {

		// 인증코드 없으면 재접근 요청
		if (Ut.empty(memberDeleteAuthKey)) {
			return rq.jsHistoryBack("!! 회원 삭제 인증코드가 필요합니다. !!");
		}

		// 인증코드 확인
		ResultData checkMemberDeleteAuthKeyRd = memberService.checkMemberDeleteAuthKey(rq.getLoginedMemberId(),
				memberDeleteAuthKey);

		if (checkMemberDeleteAuthKeyRd.isFail()) {
			return rq.jsHistoryBack(checkMemberDeleteAuthKeyRd.getMsg());
		}

		// 회원 탈퇴 진행
		memberService.deleteMyInfo(rq.getLoginedMemberId());

		// 로그아웃
		rq.logout();

		return Ut.jsReplace("회원탈퇴가 완료되었습니다.", "/");

	}

}
