package com.MeokZzang.recipe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MeokZzang.recipe.repository.ReplyRepository;
import com.MeokZzang.recipe.util.Ut;
import com.MeokZzang.recipe.vo.Article;
import com.MeokZzang.recipe.vo.Member;
import com.MeokZzang.recipe.vo.Reply;
import com.MeokZzang.recipe.vo.ResultData;

@Service
public class ReplyService {

	@Autowired
	private ReplyRepository replyRepository;

	public ReplyService(ReplyRepository replyRepository) {
		this.replyRepository = replyRepository;
	}

	// write
	public ResultData<Integer> writeReply(int actorId, String relTypeCode, int relId, String body) {

		replyRepository.writeReply(actorId, relTypeCode, relId, body);

		int id = replyRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 글에 댓글이 등록 되었습니다 :)", relId), "id", id);
	}

	// 댓글 list
	public List<Reply> getForPrintReplies(Member actor, String relTypeCode, int relId) {
		List<Reply> replies = replyRepository.getForPrintReplies(relTypeCode, relId);

		for (Reply reply : replies) {
			updateForPrintData(actor, reply);
		}

		return replies;
	}

	private void updateForPrintData(Member actor, Reply reply) {
		
		if (actor == null) {
			return;
		}
		
		ResultData actorCanModifyRd = actorCanModify(actor, reply);
		reply.setExtra__actorCanModify(actorCanModifyRd.isSuccess());

		ResultData actorCanDeleteRd = actorCanDelete(actor, reply);
		reply.setExtra__actorCanDelete(actorCanDeleteRd.isSuccess());
	}

	// 수정 권한
	private ResultData actorCanModify(Member actor, Reply reply) {

		if (reply == null) {
			return ResultData.from("F-1", "댓글이 존재하지 않습니다");
		}

		if (reply.getMemberId() != actor.getId()) {
			return ResultData.from("F-2", "해당 댓글에 대한 수정 권한이 없습니다");
		}

		return ResultData.from("S-1", "수정 가능");
	}

	// 댓글 수정
	public ResultData modifyReply(int id, String body) {
		
		replyRepository.modifyReply(id, body);
		
		return ResultData.from("S-1", Ut.f("%d번 댓글이 수정되었습니다", id));
	}
	
	// 삭제 권한
	private ResultData actorCanDelete(Member actor, Reply reply) {
		if (reply == null) {
			return ResultData.from("F-1", "댓글이 존재하지 않습니다");
		}

		if (reply.getMemberId() != actor.getId()) {
			return ResultData.from("F-2", "해당 댓글에 삭제 대한 권한이 없습니다");
		}

		return ResultData.from("S-1", "삭제 가능");
	}

	// 댓글 삭제
	public ResultData<Integer> deleteReply(int id) {

		replyRepository.deleteReply(id);

		return ResultData.from("S-1", Ut.f("댓글이 삭제되었습니다"));
	}

	// 댓글 하나만 가져오기
	public Reply getForPrintReply(Member actor, int id) {
		Reply reply = replyRepository.getForPrintReply(id);

		updateForPrintData(actor, reply);

		return reply;
	}

	//
	// 댓글 추천기능
	// + good
	public ResultData increaseGoodReplyRp(int relId) {
		int affectedRowsCount = replyRepository.increaseGoodReplyRp(relId);

		if (affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}

		return ResultData.from("S-1", "좋아요 증가", "affectedRowsCount", affectedRowsCount);

	}
	
	// - good
	public ResultData decreaseGoodReplyRp(int relId) {
		int affectedRowsCount = replyRepository.decreaseGoodReplyRp(relId);

		if (affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}

		return ResultData.from("S-2", "좋아요 취소", "affectedRowsCount", affectedRowsCount);
		
	}

	// + bad
	public ResultData increaseBadReplyRp(int relId) {
		int affectedRowsCount = replyRepository.increaseBadReplyRp(relId);

		if (affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}

		return ResultData.from("S-1", "싫어요 증가", "affectedRowsCount", affectedRowsCount);

	}

	// - bad
	public ResultData decreaseBadReplyRp(int relId) {
		int affectedRowsCount = replyRepository.decreaseBadReplyRp(relId);

		if (affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}

		return ResultData.from("S-2", "싫어요 취소", "affectedRowsCount", affectedRowsCount);
		
	}

	public Article getReply(int id) {
		return replyRepository.getReply(id);
	}

}
