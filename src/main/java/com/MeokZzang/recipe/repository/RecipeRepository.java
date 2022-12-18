package com.MeokZzang.recipe.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.MeokZzang.recipe.vo.Recipe;

@Mapper
public interface RecipeRepository {

	public List<Recipe> getRecipeList(int recipeCategory, String searchKeywordTypeCode, String searchKeyword, int limitStart, int limitTake);

	public Recipe getForPrintRecipe(int recipeId);

	public int getLastInsertId();

	public void writeRecipe(int memberId, int recipeCategory, String recipeName, String recipeBody, int recipePerson,
			int recipeLevel, int recipeCook, int recipeTime, String recipeStuff, String recipeSauce, String recipeMsgBody);

	public int getRecipiesCount(int recipeCategory, String searchKeywordTypeCode, String searchKeyword);

	public int increaseHitCount(int recipeId);

	public int getRecipeHitCount(int recipeId);

	public void deleteRecipe(int recipeId);

}
