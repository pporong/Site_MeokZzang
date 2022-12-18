package com.MeokZzang.recipe.repository;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ScrapPointRepository {

	public int getSumScrapPointByMemberId(int actorId, String relTypeCode, int relId);
	
	public void addScrapPoint(int actorId, String relTypeCode, int relId);

	public void delScrapPoint(int actorId, String relTypeCode, int relId);

}
