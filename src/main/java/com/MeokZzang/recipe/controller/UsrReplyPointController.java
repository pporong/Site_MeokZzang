package com.MeokZzang.recipe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.MeokZzang.recipe.service.ReplyPointService;
import com.MeokZzang.recipe.vo.ResultData;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class UsrReplyPointController {

	@Autowired
	private ReplyPointService replyPointService;
	@Autowired
	private Rq rq;

	// doPlusReplyPoint
	@RequestMapping("/usr/replyPoint/doPlusReplyPoint")
	@ResponseBody
	public String doPlusReplyPoint(String relTypeCode, int relId, String replaceUri) {

		ResultData actorCanMakeReplyLikeRd = replyPointService.actorCanMakeReplyLike(rq.getLoginedMemberId(), relTypeCode,
				relId);

		if (actorCanMakeReplyLikeRd.isFail()) {
			return rq.jsHistoryBackOnView("추천 하지 않았어요! 추천 후 이용 가능합니다!");
		}

		ResultData addReplyPointRd = replyPointService.addReplyPoint(rq.getLoginedMemberId(), relTypeCode, relId);
		
		return rq.jsReplace(addReplyPointRd.getMsg(), replaceUri);
	}

	// doDeleteReplyPoint
	@RequestMapping("/usr/replyPoint/doDeleteReplyPoint")
	@ResponseBody
	public String doDeleteReplyPoint(String relTypeCode, int relId, String replaceUri) {

		ResultData actorCanMakeReplyLikeRd = replyPointService.actorCanMakeReplyLike(rq.getLoginedMemberId(), relTypeCode,
				relId);

		if (actorCanMakeReplyLikeRd.isSuccess()) {
			return rq.jsHistoryBackOnView(actorCanMakeReplyLikeRd.getMsg());
		}
		
		ResultData deleteReplyPointRd = replyPointService.delReplyPoint(rq.getLoginedMemberId(), relTypeCode, relId);

		return rq.jsReplace(deleteReplyPointRd.getMsg(), replaceUri);
	}

}
