package com.MeokZzang.recipe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.MeokZzang.recipe.service.ArticleService;
import com.MeokZzang.recipe.service.BoardService;
import com.MeokZzang.recipe.util.Ut;
import com.MeokZzang.recipe.vo.Article;
import com.MeokZzang.recipe.vo.Board;
import com.MeokZzang.recipe.vo.ResultData;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class UsrArticleController {

	// 인스턴스 변수
	@Autowired
	private ArticleService articleService;
	@Autowired
	private BoardService boardService;
	@Autowired
	private Rq rq;

	// 액션메서드 
	// write
	@RequestMapping("/usr/article/doWrite")
	@ResponseBody
	public String doWrite(int boardId, String title, String body, String replaceUri) {

		if (Ut.empty(title)) {
			return rq.jsHistoryBack("제목을 입력해주세요");
		}
		if (Ut.empty(body)) {
			return rq.jsHistoryBack("내용을 입력해주세요");
		}

		ResultData<Integer> writeArticleRd = articleService.writeArticle(rq.getLoginedMemberId(), boardId, title, body);

		int id = (int) writeArticleRd.getData1();
		
		if (Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../article/detail?id=%d", id);
		}

		return rq.jsReplace(Ut.f("%d번 게시물 등록이 완료되었습니다. :)",id), replaceUri);
	}
	
	@RequestMapping("/usr/article/write")
	public String viewWrite(String title, String body) {

		return "usr/article/write";
	}
	
	// list
	@RequestMapping("/usr/article/list")
	public String viewList(Model model, @RequestParam(defaultValue = "1") int boardId, @RequestParam(defaultValue = "1") int page) {
		
		Board board = boardService.getBoardById(boardId);
		
		if(board == null) {
			return rq.jsHistoryBackOnView("존재하지 않는 게시판입니다.");
		} 
		
		int articlesCount = articleService.getArticlesCount(boardId);

		int itemsInAPage = 20;
		
		int pagesCount = (int) Math.ceil((double)articlesCount / itemsInAPage);

		List<Article> articles = articleService.getForPrintArticles(rq.getLoginedMemberId(), boardId, page, itemsInAPage);

		model.addAttribute("boardId", boardId);
		model.addAttribute("page", page);
		model.addAttribute("board", board);
		model.addAttribute("articles", articles);
		model.addAttribute("articlesCount", articlesCount);	
		model.addAttribute("pagesCount", pagesCount);

		return "usr/article/list";
	}
	
	// delete
	@RequestMapping("/usr/article/doDelete")
	@ResponseBody
	public String doDelete(int id) {

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return rq.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다", id));
		} 
		// 삭제 권한 체크
		if (article.getMemberId() != rq.getLoginedMemberId()) {
			return rq.jsHistoryBack(Ut.f("%d번 게시물에 대한 권한이 없습니다.", id));
		}

		articleService.deleteArticle(id);

		return rq.jsReplace(Ut.f("%d번 게시물을 삭제했습니다", id), "../article/list");
	}
	
	// modify
	@RequestMapping("/usr/article/modify")
	public String viewModify(Model model, int id) {

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return rq.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다", id));
		}

		ResultData actorCanModifyRd = articleService.actorCanModify(rq.getLoginedMemberId(), article);

		if (actorCanModifyRd.isFail()) {
			return rq.jsHistoryBackOnView(actorCanModifyRd.getMsg());
		}

		model.addAttribute("article", article);

		return "usr/article/modify";
	}
	
	@RequestMapping("/usr/article/doModify")
	@ResponseBody
	public String doModify(int id, String title, String body) {

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		if (article == null) {
			return rq.jsHistoryBack(Ut.f("%d번 게시물은 존재하지 않습니다", id));
		}

		ResultData actorCanModifyRd = articleService.actorCanModify(rq.getLoginedMemberId(), article);

		if (actorCanModifyRd.isFail()) {
			return rq.jsHistoryBack(actorCanModifyRd.getMsg());
		}
		
		articleService.modifyArticle(id, title, body);

		return rq.jsReplace(Ut.f("%d번 게시물을 수정했습니다", id), Ut.f("../article/detail?id=%d", id));

	}

	// detail
	@RequestMapping("/usr/article/detail")
	public String viewDetail(Model model, int id) {

		Article article = articleService.getForPrintArticle(rq.getLoginedMemberId(), id);

		model.addAttribute("article", article);

		return "usr/article/detail";
	}

}
