package com.MeokZzang.recipe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.MeokZzang.recipe.service.RecipeService;
import com.MeokZzang.recipe.vo.Recipe;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class UsrRecipeController {

	// 인스턴스 변수
	@Autowired
	private RecipeService recipeService;
	@Autowired
	private Rq rq;
	
	// 레시피 목록
	@RequestMapping("/usr/recipe/recipeList")
	public String viewRecipeList(Model model) {
		
		List<Recipe> recipies = recipeService.getRecipeList();
		
		model.addAttribute("recipies", recipies);
		return "usr/recipe/recipeList";
	}
	
	// 레시피 상세보기
	@RequestMapping("/usr/recipe/recipeDetail")
	public String viewRecipeDetail(Model model, int recipeId) {
		
		Recipe recipe = recipeService.getRecipeDetail(recipeId);
		
		String stuff = recipe.getRecipeStuff().substring(0, recipe.getRecipeStuff().length() - 1 );
		 
		String [] bodyMsg = recipe.getRecipeMsgBody().split(",");
		
		model.addAttribute("recipe", recipe);
		model.addAttribute("bodyMsg", bodyMsg);
		model.addAttribute("stuff", stuff);
		
		return "usr/recipe/recipeDetail";
	}
	
}
