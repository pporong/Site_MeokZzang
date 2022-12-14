package com.MeokZzang.recipe.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.MeokZzang.recipe.vo.Recipe;

@Mapper
public interface RecipeRepository {

	public List<Recipe> getRecipeList();

	public Recipe getRecipeDetail(int recipeId);

	public int getLastInsertId();

	public void writeRecipe(int memberId, int recipeCategory, String recipeName, String recipeBody, int recipePerson,
			int recipeLevel, int recipeCook, int recipeTime);

}
