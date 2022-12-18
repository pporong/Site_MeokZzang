package com.MeokZzang.recipe.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

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
	
	// 레시피 작성
	@RequestMapping("/usr/recipe/writeRecipe")
	public String viewRecipeWrite() {

		return "usr/recipe/recipeWrite";
	}
	
	@RequestMapping("/usr/recipe/doWriteRecipe")
	@ResponseBody
	public String doRecipeWrite(int recipeCategory, String recipeName, String recipeBody, int recipePerson, int recipeLevel, int recipeCook, int recipeTime,
			 String recipeStuff, String recipeSauce, String recipeMsgBody, String replaceUri, MultipartRequest multipartRequest) {
		
		if (Ut.empty(recipeName)) {
			return rq.jsHistoryBack("레시피 이름을 입력해주세요");
		}
		if (Ut.empty(recipeBody)) {
			return rq.jsHistoryBack("레시피 소개를 입력해주세요");
		}
		
		ResultData<Integer> writeRecipeRd = recipeService.writeRecipe(rq.getLoginedMemberId(), recipeCategory,
				recipeName, recipeBody, recipePerson, recipeLevel, recipeCook, recipeTime, recipeStuff, recipeSauce, recipeMsgBody);
		
		int recipeId = (int) writeRecipeRd.getData1();
		
		Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
		
		for (String fileInputName : fileMap.keySet()) {
			
			MultipartFile multipartFile = fileMap.get(fileInputName);

			if (multipartFile.isEmpty() == false) {
				
				genFileService.save(multipartFile, recipeId);
			}
		}

		if(Ut.empty(replaceUri)) {
			replaceUri = Ut.f("../recipe/recipeDetail?recipeId=%d", recipeId);
		}
		
		return rq.jsReplace("레시피 등록이 완료되었습니다. :)",replaceUri);
	}
	
	
	// 레시피 목록
	@RequestMapping("/usr/recipe/recipeList")
	public String viewRecipeList(Model model, @RequestParam(defaultValue = "0") int recipeCategory, @RequestParam(defaultValue = "recipeName") String searchKeywordTypeCode,
			@RequestParam(defaultValue = "") String searchKeyword,
			@RequestParam(defaultValue = "1") int page) {
		
		int recipiesCount = recipeService.getRecipiesCount(recipeCategory, searchKeywordTypeCode, searchKeyword);
		
		int itemsInAPage = 10;
		
		// 한 페이지당 글 intemInAPage 갯수
		int pagesCount = (int) Math.ceil((double) recipiesCount / itemsInAPage);
		
		List<Recipe> recipies = recipeService.getRecipeList(rq.getLoginedMemberId(), recipeCategory, page, itemsInAPage, searchKeywordTypeCode, searchKeyword);
		
		model.addAttribute("page", page);
		model.addAttribute("pagesCount", pagesCount);

		model.addAttribute("recipeCategory", recipeCategory);
		model.addAttribute("searchKeyword", searchKeyword);
		model.addAttribute("recipiesCount", recipiesCount);
		
		model.addAttribute("recipies", recipies);
		
		return "usr/recipe/recipeList";
	}
	
	// 레시피 상세보기
	@RequestMapping("/usr/recipe/recipeDetail")
	public String viewRecipeDetail(Model model, int recipeId) {
		System.err.println(recipeId);
		
		Recipe recipe = recipeService.getRecipeDetail(recipeId);
		
		String [] bodyMsg = recipe.getRecipeMsgBody().split(",");
		
		model.addAttribute("recipe", recipe);
		model.addAttribute("bodyMsg", bodyMsg);
		
		return "usr/recipe/recipeDetail";
	}
	
}
