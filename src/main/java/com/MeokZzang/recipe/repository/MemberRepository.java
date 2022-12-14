package com.MeokZzang.recipe.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.MeokZzang.recipe.vo.Article;
import com.MeokZzang.recipe.vo.Member;

@Mapper
public interface MemberRepository {

	public void join(String loginId, String loginPw, String name, String nickname, String cellphoneNum, String email);

	public int getLastInsertId();
	
	public Member getMemberById(int id);
	
	public Member getMemberByLoginId(String loginId);
	
	public Member getMemberByNameAndEmail(String name, String email);
	
	public Member getMemberByNickname(String nickname);
	
	public Member getLoginedMemberName(int id);

	public void modifyMyInfo(int id, String loginPw, String nickname, String cellphoneNum, String email);

	public Member getForPrintMember(int id);
	
	public Member getArticleByMemberId();

	public int getMembersCount(int authLevel, String searchKeywordTypeCode, String searchKeyword);

	public List<Member> getForPrintMembers(int authLevel, String searchKeywordTypeCode, String searchKeyword,
			int limitStart, int limitTake);

	public void deleteMember(int id);

	public List<Article> getArticlesByMemberId(int id, int limitStart, int limitTake);

	public int getArticlesCount(int id);
}
