package com.MeokZzang.recipe.repository;

import org.apache.ibatis.annotations.Mapper;

import com.MeokZzang.recipe.vo.Member;

@Mapper
public interface MemberRepository {

	public void join(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email);

	public int getLastInsertId();
	
	public Member getMemberById(int id);
	
	public Member getMemberByLoginId(String loginId);
	
	public Member getMemberByNameAndEmail(String name, String email);
	
	public Member getLoginedMemberName(int id);

	public void modifyMyInfo(int id, String loginPw, String nickname, String cellphoneNum, String email);

	public Member getForPrintMember(int id);
}
