package com.MeokZzang.recipe.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.MeokZzang.recipe.service.GenFileService;
import com.MeokZzang.recipe.service.RecipeService;
import com.MeokZzang.recipe.util.Ut;
import com.MeokZzang.recipe.vo.Recipe;
import com.MeokZzang.recipe.vo.ResultData;
import com.MeokZzang.recipe.vo.Rq;

@Controller
public class UsrRecipeController {

	// 인스턴스 변수
	@Autowired
	private RecipeService recipeService;
	@Autowired
	private GenFileService genFileService;
	@Autowired
	private Rq rq;
	
	// 레시피 등록
	@RequestMapping("/usr/recipe/writeRecipe")
	public String viewRecipeWrite() {

		return "usr/recipe/recipeWrite";
	}
	
	@RequestMapping("/usr/recipe/doWriteRecipe")
	@ResponseBody
	public String doRecipeWrite(@RequestParam(defaultValue = "0") int recipeCategory, String recipeName, String recipeBody, int recipePerson,
			int recipeLevel, int recipeCook, int recipeTime, @RequestParam(defaultValue = "/") String replaceUri) {

		// 데이터 유효성 검사
		if (Ut.empty(recipeCategory)) {
			return rq.jsHistoryBack("카테고리를 입력해주세요");
		}
		if (Ut.empty(recipeName)) {
			return rq.jsHistoryBack("레시피 이름을 입력해주세요");
		}
		if (Ut.empty(recipeBody)) {
			return rq.jsHistoryBack("레시피 설명을 입력해주세요");
		}
		
		ResultData<Integer> writeRecipeRd = recipeService.writeRecipe(rq.getLoginedMemberId(), recipeCategory,
				recipeName, recipeBody, recipePerson, recipeLevel, recipeCook, recipeTime);
		
		int recipeId = (int) writeRecipeRd.getData1();
		
		if(Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../usr/recipe/recipeDetail?recipeId=%d", recipeId);
		}

		return rq.jsReplace(Ut.f("%d번 레시피 등록이 완료되었습니다. :)", recipeId), replaceUri);
	}
	
	
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
