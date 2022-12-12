package com.MeokZzang.recipe.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.MeokZzang.recipe.repository.RecipeRepository;
import com.MeokZzang.recipe.vo.Recipe;

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
	

}