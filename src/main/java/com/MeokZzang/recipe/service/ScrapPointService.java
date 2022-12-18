package com.MeokZzang.recipe.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MeokZzang.recipe.repository.ScrapPointRepository;
import com.MeokZzang.recipe.vo.ResultData;

@Service
public class ScrapPointService {

	@Autowired
	private ScrapPointRepository scrapPointRepository;
	@Autowired
	private RecipeService recipeService;

	public ResultData actorCanMakeScrap(int actorId, String relTypeCode, int relId) {
		
		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요");
		}
		int sumScrapnPointByMemberId =  scrapPointRepository.getSumScrapPointByMemberId(actorId, relTypeCode, relId);

		if(sumScrapnPointByMemberId != 0) {
			return ResultData.from("F-2", "스크랩기능 사용 불가!", "sumScrapnPointByMemberId", sumScrapnPointByMemberId);
		}

		return ResultData.from("S-1", "스크랩기능 사용 가능!", "sumScrapnPointByMemberId", sumScrapnPointByMemberId);
	}
	
	// AddScrap
	public ResultData addScrapPoint(int actorId, String relTypeCode, int relId) {

		scrapPointRepository.addScrapPoint(actorId, relTypeCode, relId);

		switch (relTypeCode) {
		case "recipe" :
				recipeService.increaseScrapPoint(relId);
		}
		return ResultData.from("S-1", "스크랩 !");
		
	}
	
	// DelScrap
	public ResultData delScrapPoint(int actorId, String relTypeCode, int relId) {
		
		scrapPointRepository.delScrapPoint(actorId, relTypeCode, relId);

		switch (relTypeCode) {
		case "recipe" :
			recipeService.decreaseScrapPoint(relId);
		}
		return ResultData.from("S-2", "스크랩 취소 !");
	}
	
}
