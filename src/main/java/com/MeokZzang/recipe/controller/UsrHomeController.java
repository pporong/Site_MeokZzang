package com.MeokZzang.recipe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.MeokZzang.recipe.service.ArticleService;
import com.MeokZzang.recipe.service.RecipeService;
import com.MeokZzang.recipe.vo.Article;
import com.MeokZzang.recipe.vo.Recipe;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class UsrHomeController {
	
	@Autowired
	private Rq rq;
	@Autowired
	private ArticleService articleService;
	@Autowired
	private RecipeService recipeService;
	
	public UsrHomeController(Rq rq) {
		this.rq = rq;
	}
	
	@RequestMapping("/usr/home/main")
	public String showMain(Model model) {
		
		// 공지사항 다섯개 출력
		List<Article> articles = articleService.getForPrintNotice();
		
		// 최신 레시피
		List <Recipe> newRecipes = recipeService.getForPrintNewRecipe();
		
		// 추천 랭킹 레시피
		List <Recipe> topRecipes = recipeService.getForPrintTopRecipe();
		
		
		model.addAttribute("articles", articles);
		model.addAttribute("newRecipes", newRecipes);
		model.addAttribute("topRecipes", topRecipes);
		return "usr/home/main";
	}	
	
	@RequestMapping("/")
	public String showRoot() {
		return "redirect:/usr/home/main";
	}
	
}
