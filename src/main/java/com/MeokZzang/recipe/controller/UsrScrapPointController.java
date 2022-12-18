package com.MeokZzang.recipe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.MeokZzang.recipe.service.ScrapPointService;
import com.MeokZzang.recipe.vo.ResultData;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class UsrScrapPointController {

	@Autowired
	private ScrapPointService scrapPointService;
	@Autowired
	private Rq rq;

	// doScrap
	@RequestMapping("/usr/scrapPoint/doScrap")
	@ResponseBody
	public String doScrap(String relTypeCode, int relId, String replaceUri) {

		ResultData actorCanMakeScrapRd = scrapPointService.actorCanMakeScrap(rq.getLoginedMemberId(), relTypeCode,
				relId);

		if (actorCanMakeScrapRd.isFail()) {
			return rq.jsHistoryBackOnView("스크랩 하지 않았어요! 스크랩 후 이용 가능합니다!");
		}

		ResultData addScrapPointRd = scrapPointService.addScrapPoint(rq.getLoginedMemberId(), relTypeCode, relId);

		return rq.jsReplace(addScrapPointRd.getMsg(), replaceUri);
	}

	// DeleteScrap
	@RequestMapping("/usr/scrapPoint/doDeleteScrap")
	@ResponseBody
	public String doDeleteScrap(String relTypeCode, int relId, String replaceUri) {

		ResultData actorCanMakeScrapRd = scrapPointService.actorCanMakeScrap(rq.getLoginedMemberId(), relTypeCode,
				relId);

		if (actorCanMakeScrapRd.isSuccess()) {
			return rq.jsHistoryBackOnView(actorCanMakeScrapRd.getMsg());
		}
		ResultData delScrapPointRd = scrapPointService.delScrapPoint(rq.getLoginedMemberId(), relTypeCode, relId);

		return rq.jsReplace(delScrapPointRd.getMsg(), replaceUri);
	}

}
