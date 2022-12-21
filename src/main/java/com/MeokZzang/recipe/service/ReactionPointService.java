package com.MeokZzang.recipe.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MeokZzang.recipe.repository.ReactionPointRepository;
import com.MeokZzang.recipe.vo.ResultData;

@Service
public class ReactionPointService {

	@Autowired
	private ReactionPointRepository reactionPointRepository;
	@Autowired
	private ArticleService articleService;
	@Autowired
	private ReplyService replyService;

	public ResultData actorCanMakeReaction(int actorId, String relTypeCode, int relId) {
		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요");
		}
		int sumReactionPointByMemberId = reactionPointRepository.getSumReactionPointByMemberId(actorId, relTypeCode,
				relId);

		if (sumReactionPointByMemberId != 0) {
			return ResultData.from("F-2", "추천기능 사용 불가!", "sumReactionPointByMemberId", sumReactionPointByMemberId);
		}

		return ResultData.from("S-1", "추천기능 사용 가능!", "sumReactionPointByMemberId", sumReactionPointByMemberId);
	}

	// AddGood : 게시물
	public ResultData addGoodRp(int actorId, String relTypeCode, int relId) {

		reactionPointRepository.addGoodReactionPoint(actorId, relTypeCode, relId);

		switch (relTypeCode) {
		case "article":
			articleService.increaseGoodRp(relId);
		}
		return ResultData.from("S-1", "좋아요 !");

	}

	// DelGood 게시물
	public ResultData deleteGoodRp(int actorId, String relTypeCode, int relId) {

		reactionPointRepository.delGoodReactionPoint(actorId, relTypeCode, relId);

		switch (relTypeCode) {
		case "article":
			articleService.decreaseGoodRp(relId);
		}
		return ResultData.from("S-2", "좋아요 취소 !");
	}

	// AddBad : 게시물
	public ResultData addBadRp(int actorId, String relTypeCode, int relId) {

		reactionPointRepository.addBadReactionPoint(actorId, relTypeCode, relId);

		switch (relTypeCode) {
		case "article":
			articleService.increaseBadRp(relId);
			break;
		}
		return ResultData.from("S-3", "싫어요 완료~");
	}

	// DelBad : 게시물
	public ResultData deleteBadRp(int actorId, String relTypeCode, int relId) {

		reactionPointRepository.delBadReactionPoint(actorId, relTypeCode, relId);

		switch (relTypeCode) {
		case "article":
			articleService.decreaseBadRp(relId);
			break;
		}
		return ResultData.from("S-4", "싫어요 취소 완료~");

	}

	// 멤버별 게시물 추천 상황
	public ResultData getRpInfoByMemberId(int actorId, String relTypeCode, int relId) {

		reactionPointRepository.getRpInfoByMemberId(actorId, relTypeCode, relId);

		return ResultData.from("S-2", "게시물별 추천 상황");
	}

	public void getBadRpCount(int relId) {

	}

}