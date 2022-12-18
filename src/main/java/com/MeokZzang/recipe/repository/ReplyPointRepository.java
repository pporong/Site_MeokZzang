package com.MeokZzang.recipe.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ReplyPointRepository {

	public int getSumReplyPointByMemberId(int actorId, String relTypeCode, int relId);
	
	public void addReplyPoint(int actorId, String relTypeCode, int relId);

	public void delReplyPoint(int actorId, String relTypeCode, int relId);

}