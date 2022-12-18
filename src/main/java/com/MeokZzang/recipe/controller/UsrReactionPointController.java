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
		
		ResultData addGoodRpRd = reactionPointService.addGoodRp(rq.getLoginedMemberId(), relTypeCode, relId);

		return rq.jsReplace(addGoodRpRd.getMsg(), replaceUri);
	}
	
	// delLike
	@RequestMapping("/usr/reactionPoint/doDeleteGoodReaction")
	@ResponseBody
	public String doDeleteGoodReaction(String relTypeCode, int relId, String replaceUri) {

		ResultData actorCanMakeReactionRd = reactionPointService.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode, relId);

		if (actorCanMakeReactionRd.isSuccess()) {
			return rq.jsHistoryBackOnView(actorCanMakeReactionRd.getMsg());
		}
		ResultData deleteGoodRpRd = reactionPointService.deleteGoodRp(rq.getLoginedMemberId(), relTypeCode, relId);
		
		return rq.jsReplace(deleteGoodRpRd.getMsg(), replaceUri);
	}

	// doDLike
	@RequestMapping("/usr/reactionPoint/doBadReaction")
	@ResponseBody
	public String addBadReactionPoint(String relTypeCode, int relId, String replaceUri) {	

		ResultData actorCanMakeReactionRd = reactionPointService.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode, relId);
		
		if (actorCanMakeReactionRd.isFail()) {
			return rq.jsHistoryBackOnView("아무런 리액션을 취하지 않았어요! 리액션 후 이용 가능합니다!");
		}
		
		ResultData addBadRpRd = reactionPointService.addBadRp(rq.getLoginedMemberId(), relTypeCode, relId);

		return rq.jsReplace(addBadRpRd.getMsg(), replaceUri);
	}
	
	// delDLike
	@RequestMapping("/usr/reactionPoint/doDeleteBadReaction")
	@ResponseBody
	public String doDeleteBadReaction(String relTypeCode, int relId, String replaceUri) {

		ResultData actorCanMakeReactionRd = reactionPointService.actorCanMakeReaction(rq.getLoginedMemberId(), relTypeCode, relId);

		if (actorCanMakeReactionRd.isSuccess()) {
			return rq.jsHistoryBackOnView(actorCanMakeReactionRd.getMsg());
		}
		ResultData deleteBadRpRd = reactionPointService.deleteBadRp(rq.getLoginedMemberId(), relTypeCode, relId);

		return rq.jsReplace(deleteBadRpRd.getMsg(), replaceUri);
	}
	


}
