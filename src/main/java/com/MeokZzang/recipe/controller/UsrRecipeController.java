package com.MeokZzang.recipe.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.MeokZzang.recipe.service.RecipeService;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class UsrRecipeController {

	// 인스턴스 변수
	@Autowired
	private RecipeService recipeService;
	@Autowired
	private Rq rq;
	
	@RequestMapping("/usr/recipe/recipeList")
	public String viewRecipeList(Model model) {
		
		return "usr/recipe/recipeList";
	}
	
}
