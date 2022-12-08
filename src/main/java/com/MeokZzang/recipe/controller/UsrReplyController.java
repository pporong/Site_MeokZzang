package com.MeokZzang.recipe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.MeokZzang.recipe.service.ArticleService;
import com.MeokZzang.recipe.service.ReplyService;
import com.MeokZzang.recipe.util.Ut;
import com.MeokZzang.recipe.vo.Article;
import com.MeokZzang.recipe.vo.Reply;
import com.MeokZzang.recipe.vo.ResultData;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class UsrReplyController {
	@Autowired
	private ReplyService replyService;
	@Autowired
	private ArticleService articleService;
	@Autowired
	private Rq rq;

	// 액션메서드
	@RequestMapping("/usr/reply/doWrite")
	@ResponseBody
	public String doWrite(String relTypeCode, int relId, String body, String replaceUri) {

		if (Ut.empty(relTypeCode)) {
			return rq.jsHistoryBack("relTypeCode 을(를) 입력 해 주세요. !!");
		}
		if (Ut.empty(relId)) {
			return rq.jsHistoryBack("relId 을(를) 입력 해 주세요. !!");
		}
		if (Ut.empty(body)) {
			return rq.jsHistoryBack("body 을(를) 입력 해 주세요. !!");
		}

		ResultData<Integer> writeReplyRd = replyService.writeReply(rq.getLoginedMemberId(), relTypeCode, relId, body);

		int id = writeReplyRd.getData1();

		if (Ut.empty(replaceUri)) {
			switch (relTypeCode) {
			case "article":
				replaceUri = Ut.f("../article/detail?id=%d", relId);
				break;
			}
		}
		return rq.jsReplace(writeReplyRd.getMsg(), replaceUri);
	}

	@RequestMapping("/usr/reply/doDelete")
	@ResponseBody
	public String doDelete(int id, String replaceUri) {

		if (Ut.empty(id)) {
			return rq.jsHistoryBack(Ut.f("존재하지 않는 id입니다."));
		}

		Reply reply = replyService.getForPrintReply(rq.getLoginedMember(), id);

		if (reply == null) {
			return rq.jsHistoryBack(Ut.f("%d번 댓글은 존재하지 않습니다.", id));
		}
		if (reply.isExtra__actorCanDelete() == false) {
			return rq.jsHistoryBack(Ut.f("해당 댓글에 대한 삭제 권한이 없습니다."));
		}

		ResultData<Integer> deleteReplyRd = replyService.deleteReply(id);

		if (Ut.empty(replaceUri)) {
			switch (reply.getRelTypeCode()) {
			case "article":
				replaceUri = Ut.f("../article/detail?id=%d", reply.getRelId());
				break;
			}
		}

		return rq.jsReplace(deleteReplyRd.getMsg(), replaceUri);
	}
	
	// 댓글 삭제 ajax
	@RequestMapping("/usr/reply/doDeleteAjax")
	@ResponseBody
	public ResultData doDeleteAjax(int id) {
		if ( Ut.empty(id) ) {
			return ResultData.from("F-1","!! id(을)를 입력해주세요 !!");
		}

		Reply reply = replyService.getForPrintReply(rq.getLoginedMember(), id);

		if ( reply == null ) {
			return ResultData.from("F-2", Ut.f("%d번 댓글은 존재하지 않습니다.", id));
		}

		if ( reply.isExtra__actorCanDelete() == false ) {
			return ResultData.from("F-3", Ut.f("%d번 댓글에 대한 삭제 권한이 없습니다.", id));
		}

		ResultData deleteReplyRd = replyService.deleteReply(id);

		return ResultData.from("S-1", deleteReplyRd.getMsg());
	}

	@RequestMapping("/usr/reply/modify")
	public String modify(int id, String replaceUri, Model model) {

		Reply reply = replyService.getForPrintReply(rq.getLoginedMember(), id);

		if (reply == null) {
			return rq.jsHistoryBack(Ut.f("%d번 댓글은 존재하지 않습니다.", id));
		}
		if (reply.isExtra__actorCanModify() == false) {
			return rq.jsHistoryBack(Ut.f("해당 댓글에 대한 수정 권한이 없습니다."));
		}

		String relDataTitle = null;
		switch (reply.getRelTypeCode()) {
		case "article":
			Article article = articleService.getArticle(reply.getRelId());
			relDataTitle = article.getTitle();
			break;
		}
		model.addAttribute("reply", reply);
		model.addAttribute("relDataTitle", relDataTitle);

		return "usr/reply/reModify";
	}

	// 수정
	@RequestMapping("/usr/reply/doModify")
	@ResponseBody
	public String doModify(int id, String body, String replaceUri) {

		Reply reply = replyService.getForPrintReply(rq.getLoginedMember(), id);
		if (Ut.empty(id)) {
			return rq.jsHistoryBack(Ut.f("존재하지 않는 id입니다."));
		}
		if (reply == null) {
			return rq.jsHistoryBack(Ut.f("%d번 댓글은 존재하지 않습니다", id));
		}
		if (Ut.empty(body)) {
			return rq.jsHistoryBack("!! 수정 내용을 입력 해 주세요. !!");
		}
		if (reply.isExtra__actorCanModify() == false) {
			return rq.jsHistoryBack(Ut.f("해당 댓글에 대한 수정 권한이 없습니다."));
		}
		
		ResultData modifyReplyRd = replyService.modifyReply(id, body);
		
		if (Ut.empty(replaceUri)) {
			switch (reply.getRelTypeCode()) {
			case "article":
				replaceUri = Ut.f("../article/detail?id=%d", reply.getRelId());
				break;
			}
		}
		return rq.jsReplace(modifyReplyRd.getMsg(), replaceUri);

	}

}
