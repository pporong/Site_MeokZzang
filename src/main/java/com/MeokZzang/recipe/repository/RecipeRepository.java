package com.MeokZzang.recipe.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.MeokZzang.recipe.vo.Recipe;

@Mapper
public interface RecipeRepository {

	public List<Recipe> getRecipeList();

	public Recipe getRecipeDetail(int recipeId);

	public int getLastInsertId();

}
