package com.MeokZzang.recipe.repository;

import java.util.List;

import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import com.MeokZzang.recipe.vo.Article;

@Mapper
public interface ArticleRepository {
	
	public void writeArticle(int memberId, String title, String body);

	public Article getForPrintArticle(int id);
	
	public List<Article> getArticles(int boardId);
	
	public List<Article> getForPrintArticles(int boardId);
	
	public void deleteArticle(int id);

	public void modifyArticle(int id, String title, String body);

	public int getLastInsertId();

	

}
