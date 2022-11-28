package com.MeokZzang.recipe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.MeokZzang.recipe.service.ReactionPointService;
import com.MeokZzang.recipe.vo.ResultData;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class UsrReactionPointController {

	@Autowired
	private ReactionPointService reactionPointService;
	@Autowired
	private Rq rq;

	// doLike
	@RequestMapping("/usr/reactionPoint/doGoodReaction")
	@ResponseBody
	public String doGoodReaction(String relTypeCode, int relId, String replaceUri) {

		ResultData actorCanMakeReactionRd = reactionPointService.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode, relId);
		
		if (actorCanMakeReactionRd.isFail()) {
			return rq.jsHistoryBackOnView("아무런 리액션을 취하지 않았어요! 리액션 후 이용 가능합니다!");
		}

		reactionPointService.addGoodRp(rq.getLoginedMemberId(), relTypeCode, relId);

		return rq.jsReplace("좋아요를 눌렀어요!", replaceUri);
	}
	
	// delLike
	@RequestMapping("/usr/reactionPoint/doDeleteGoodReaction")
	@ResponseBody
	public String doDeleteGoodReaction(String relTypeCode, int relId, String replaceUri) {

		ResultData actorCanMakeReactionRd = reactionPointService.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode, relId);

		// 직접 도메인을 치고 올 경우 방어
		if (actorCanMakeReactionRd.isSuccess()) {
			return rq.jsHistoryBackOnView(actorCanMakeReactionRd.getMsg());
		}
		reactionPointService.deleteGoodRp(rq.getLoginedMemberId(), relTypeCode, relId);
		
		return rq.jsReplace("좋아요를 취소했어요!", replaceUri);
	}

	// doDLike
	@RequestMapping("/usr/reactionPoint/doBadReaction")
	@ResponseBody
	public String addBadReactionPoint(String relTypeCode, int relId, String replaceUri) {	

		ResultData actorCanMakeReactionRd = reactionPointService.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode, relId);
		
		// 직접 도메인을 치고 올 경우 방어?..
		if (actorCanMakeReactionRd.isFail()) {
			return rq.jsHistoryBackOnView("아무런 리액션을 취하지 않았어요! 리액션 후 이용 가능합니다!");
		}

		reactionPointService.addBadRp(rq.getLoginedMemberId(), relTypeCode, relId);

		return rq.jsReplace("싫어요를 눌렀어요!", replaceUri);
	}
	
	// delDLike
	@RequestMapping("/usr/reactionPoint/doDeleteBadReaction")
	@ResponseBody
	public String doDeleteBadReaction(String relTypeCode, int relId, String replaceUri) {

		ResultData actorCanMakeReactionRd = reactionPointService.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode, relId);

		// 직접 도메인을 치고 올 경우 방어?..
		if (actorCanMakeReactionRd.isSuccess()) {
			return rq.jsHistoryBackOnView(actorCanMakeReactionRd.getMsg());
		}
		reactionPointService.deleteBadRp(rq.getLoginedMemberId(), relTypeCode, relId);

		return rq.jsReplace("싫어요를 취소했어요!", replaceUri);
	}

}
