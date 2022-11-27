package com.MeokZzang.recipe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MeokZzang.recipe.repository.ArticleRepository;
import com.MeokZzang.recipe.util.Ut;
import com.MeokZzang.recipe.vo.Article;
import com.MeokZzang.recipe.vo.ResultData;

@Service
public class ArticleService {
	@Autowired
	private ArticleRepository articleRepository;

	public ArticleService(ArticleRepository articleRepository) {
		this.articleRepository = articleRepository;
	}
	
	public Article getForPrintArticle(int actorId, int id) {
		Article article = articleRepository.getForPrintArticle(id);

		updateForPrintData(actorId, article);

		return article;
	}
	
	private void updateForPrintData(int actorId, Article article) {
		if (article == null) {
			return;
		}

		ResultData actorCanDeleteRd = actorCanDelete(actorId, article);
		article.setExtra__actorCanDelete(actorCanDeleteRd.isSuccess());
		
		ResultData actorCanModifyRd = actorCanModify(actorId, article);
		article.setExtra__actorCanModify(actorCanModifyRd.isSuccess());

	}

	public List<Article> getForPrintArticles(int actorId, int boardId, int page, int itemsInAPage,
			String searchKeywordTypeCode, String searchKeyword) {

		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;

		List<Article> articles = articleRepository.getForPrintArticles(boardId, searchKeywordTypeCode, searchKeyword,
				limitStart, limitTake);

		for (Article article : articles) {
			updateForPrintData(actorId, article);
		}

		return articles;
	}
	
	public ResultData<Integer> writeArticle(int memberId, int boardId, String title, String body) {
		articleRepository.writeArticle(memberId, boardId, title, body);
		int id = articleRepository.getLastInsertId();

		return ResultData.from("S-1", Ut.f("%d번 게시물이 생성되었습니다", id), "id", id);
	}
	
	public void deleteArticle(int id) {
		articleRepository.deleteArticle(id);
	}

	public ResultData<Article> modifyArticle(int id, String title, String body) {
		articleRepository.modifyArticle(id, title, body);
		
		Article article = getForPrintArticle(0, id);

		return ResultData.from("S-1", Ut.f("%d번 게시물을 수정했습니다", id), "article", article);
	}

	// 수정 권한
	public ResultData actorCanModify(int loginedMemberId, Article article) {

		if (article.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", "해당 게시물에 대한 수정 권한이 없습니다");
		}

		return ResultData.from("S-1", "수정 가능");
	}
	
	// 삭제 권한
	public ResultData actorCanDelete(int actorId, Article article) {

		if (article == null) {
			return ResultData.from("F-1", "게시물이 존재하지 않습니다");
		}

		if (article.getMemberId() != actorId) {
			return ResultData.from("F-2", "해당 게시물에 대한 권한이 없습니다");
		}

		return ResultData.from("S-1", "삭제 가능");
	}

	public int getArticlesCount(int boardId, String searchKeywordTypeCode, String searchKeyword) {
		return articleRepository.getArticlesCount(boardId, searchKeywordTypeCode, searchKeyword);
	}

	public ResultData<Integer> increaseHitCount(int id) {
		
		int affectedRowsCount = articleRepository.increaseHitCount(id);

		if (affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}

		return ResultData.from("S-1", "조회수 증가", "affectedRowsCount", affectedRowsCount);
	}

	public int getArticleHitCount(int id) {	
		return articleRepository.getArticleHitCount(id);
	}





}