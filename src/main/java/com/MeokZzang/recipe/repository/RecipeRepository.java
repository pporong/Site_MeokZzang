package com.MeokZzang.recipe.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.MeokZzang.recipe.vo.Recipe;

@Mapper
public interface RecipeRepository {

	List<Recipe> getRecipeList();

	Recipe getRecipeDetail(int recipeId);

}
