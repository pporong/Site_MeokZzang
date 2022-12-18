package com.MeokZzang.recipe.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MeokZzang.recipe.repository.ReplyPointRepository;
import com.MeokZzang.recipe.vo.ResultData;

@Service
public class ReplyPointService {

	@Autowired
	private ReplyPointRepository replyPointRepository;
	@Autowired
	private ReplyService replyService;
	
	public ResultData actorCanMakeReplyLike(int actorId, String relTypeCode, int relId) {
		
		if (actorId == 0) {
			return ResultData.from("F-1", "로그인 후 이용해주세요");
		}
		int sumReplyPointByMemberId = replyPointRepository.getSumReplyPointByMemberId(actorId, relTypeCode, relId);

		if(sumReplyPointByMemberId != 0) {
			return ResultData.from("F-2", "댓글 추천 기능 사용 불가!", "sumReplyPointByMemberId", sumReplyPointByMemberId);
		}

		return ResultData.from("S-1", "댓글 추천 기능 사용 가능!", "sumReplyPointByMemberId", sumReplyPointByMemberId);
	}

	// addReplyPoint
	public ResultData addReplyPoint(int actorId, String relTypeCode, int relId) {
		
		replyPointRepository.addReplyPoint(actorId, relTypeCode, relId);

		switch (relTypeCode) {
		case "reply" :
				replyService.increaseReplyPoint(relId);
		}
		return ResultData.from("S-1", "댓글 추천 !");
	}

	// delReplyPoint
	public ResultData delReplyPoint(int actorId, String relTypeCode, int relId) {

		replyPointRepository.delReplyPoint(actorId, relTypeCode, relId);

		switch (relTypeCode) {
		case "reply" :
				replyService.decreaseReplyPoint(relId);
		}
		return ResultData.from("S-2", "댓글 추천 취소!");
	}
	
}
