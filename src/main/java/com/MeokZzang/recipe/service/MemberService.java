package com.MeokZzang.recipe.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.MeokZzang.recipe.repository.MemberRepository;
import com.MeokZzang.recipe.util.Ut;
import com.MeokZzang.recipe.vo.Member;
import com.MeokZzang.recipe.vo.ResultData;

@Service
public class MemberService {

	@Value("${custom.siteMainUri}")
	private String siteMainUri;
	@Value("${custom.siteName}")
	private String siteName;
	
	private MemberRepository memberRepository;
	private AttrService attrService;
	private MailService mailService;

	public MemberService(MemberRepository memberRepository, AttrService attrService, MailService mailService) {
		this.memberRepository = memberRepository;
		this.attrService = attrService;
		this.mailService = mailService;
	}

	public ResultData join(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email) {
		
		Member existsMember = getMemberByLoginId(loginId);

		// id 중복체크
		if (existsMember != null) {
			return ResultData.from("F-7", Ut.f("이미 사용중인 아이디(%s)입니다", loginId));
		}
		
		// name + email 중복체크
		existsMember = getMemberByNameAndEmail(name, email);

		if (existsMember != null) {
			return ResultData.from("F-8", Ut.f("이미 사용중인 이름(%s)과 이메일(%s)입니다", name, email));
		}
		
		loginPw = Ut.sha256(loginPw);
		
		memberRepository.join(loginId, loginPw, name, nickname, cellphoneNum, email);
		
		int id = memberRepository.getLastInsertId();

		return ResultData.from("S-1", "회원가입이 완료되었습니다", "id", id);
	}
	
	public Member getMemberByNameAndEmail(String name, String email) {
		return memberRepository.getMemberByNameAndEmail(name, email);
	}

	public Member getMemberByLoginId(String loginId) {
		return memberRepository.getMemberByLoginId(loginId);

	}
	
	public Member getMemberById(int id) {
		return memberRepository.getMemberById(id);
	}

	public ResultData modifyMyInfo(int id, String loginPw, String nickname, String cellphoneNum, String email) {
		
		loginPw = Ut.sha256(loginPw);
		
		memberRepository.modifyMyInfo(id, loginPw, nickname, cellphoneNum, email);

		return ResultData.from("S-1", "회원 정보 변경 성공!");

	}

	public Member getForPrintMember(Member loginedMember, int id) {

		Member member = memberRepository.getForPrintMember(id);

		return member;
	}

	public String genMemberModifyAuthKey(int actorId) {
		String memberModifyAuthKey = Ut.getTempPassword(10);

		attrService.setValue("member", actorId, "extra", "memberModifyAuthKey", memberModifyAuthKey, Ut.getDateStrLater(60 * 5));

		return memberModifyAuthKey;
	}

	public ResultData checkMemberModifyAuthKey(int actorId, String memberModifyAuthKey) {

		String saved = attrService.getValue("member", actorId, "extra", "memberModifyAuthKey");

		if(!saved.equals(memberModifyAuthKey)) {
			return ResultData.from("F-1", "!! 인증코드가 일치하지 않거나 만료된 코드입니다. !!");
		}

		return ResultData.from("S-1", "정상 코드입니다");
	}
	
	public ResultData notifyTempLoginPwByEmailRd(Member actor) {
		String title = "[" + siteName + "] 임시 패스워드 발송";
		String tempPassword = Ut.getTempPassword(6);
		String body = "<h1>임시 패스워드 : " + tempPassword + "</h1>";
		body += "<a href=\"" + siteMainUri + "/usr/member/login\" target=\"_blank\">로그인 하러가기</a>";

		ResultData sendResultData = mailService.send(actor.getEmail(), title, body);

		if (sendResultData.isFail()) {
			return sendResultData; 
		}

		setTempPassword(actor, tempPassword);

		return ResultData.from("S-1", "계정의 이메일주소로 임시 패스워드가 발송되었습니다. :)");
	}

	private void setTempPassword(Member actor, String tempPassword) {
		memberRepository.modifyMyInfo(actor.getId(), Ut.sha256(tempPassword), null, null, null);
	}

}
