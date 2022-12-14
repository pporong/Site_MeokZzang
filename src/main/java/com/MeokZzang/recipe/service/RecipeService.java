package com.MeokZzang.recipe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MeokZzang.recipe.repository.RecipeRepository;
import com.MeokZzang.recipe.util.Ut;
import com.MeokZzang.recipe.vo.Recipe;
import com.MeokZzang.recipe.vo.ResultData;

@Service
public class RecipeService {
	@Autowired
	private RecipeRepository recipeRepository;

	public RecipeService(RecipeRepository recipeRepository) {
		this.recipeRepository = recipeRepository;
	}

	public List<Recipe> getRecipeList() {
		
		return recipeRepository.getRecipeList();
	}

	public Recipe getRecipeDetail(int recipeId) {
		
		return recipeRepository.getRecipeDetail(recipeId);
	}


	// 레시피 작성
	public ResultData<Integer> writeRecipe(int memberId, int recipeCategory, String recipeName,
			String recipeBody, int recipePerson, int recipeLevel, int recipeCook, int recipeTime) {
		
		recipeRepository.writeRecipe(memberId, recipeCategory, 
				recipeName, recipeBody, recipePerson, recipeLevel, recipeCook, recipeTime);
		
		int recipeId = recipeRepository.getLastInsertId();
		
		return ResultData.from("S-1", Ut.f("%d번 레시피가 생성되었습니다", recipeId), "recipeId", recipeId);
	}
	

}