package com.MeokZzang.recipe.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReactionPointRepository {

	public int getSumReactionPointByMemberId(int actorId, String relTypeCode, int relId);

	public void addGoodReactionPoint(int actorId, String relTypeCode, int relId);

	public void delGoodReactionPoint(int actorId, String relTypeCode, int relId);
	
	public void addBadReactionPoint(int actorId, String relTypeCode, int relId);

	public void delBadReactionPoint(int actorId, String relTypeCode, int relId);
	
	public void addGoodReactionPointReply(int actorId, String relTypeCode, int relId);

	public void delGoodReactionPointReply(int actorId, String relTypeCode, int relId);

	public void getRpInfoByMemberId(int actorId, String relTypeCode, int relId);

}
