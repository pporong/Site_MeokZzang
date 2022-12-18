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
		
		Recipe recipe = recipeService.getForPrintRecipe(rq.getLoginedMemberId(), recipeId);
		
		String [] bodyMsg = recipe.getRecipeMsgBody().split(",");
		String [] stuff = recipe.getRecipeStuff().split(",");
		String [] sauce = recipe.getRecipeSauce().split(",");
		
		model.addAttribute("recipe", recipe);
		model.addAttribute("bodyMsg", bodyMsg);
		model.addAttribute("stuff", stuff);
		model.addAttribute("sauce", sauce);
		
		return "usr/recipe/recipeDetail";
	}
	
	
	// 레시피 delete
	@RequestMapping("/usr/recipe/doDelete")
	@ResponseBody
	public String doDelete(int recipeId) {

		Recipe recipe = recipeService.getForPrintRecipe(rq.getLoginedMemberId(), recipeId);

		if (recipe == null) {
			return rq.jsHistoryBack(Ut.f("%d번 레시피는 존재하지 않습니다", recipeId));
		} 
		// 삭제 권한 체크
		if (recipe.getMemberId() != rq.getLoginedMemberId()) {
			return rq.jsHistoryBack(Ut.f("%d번 레시피에 대한 삭제 권한이 없습니다.", recipeId));
		}

		recipeService.deleteRecipe(recipeId);

		return rq.jsReplace(Ut.f("%d번 레시피를 삭제했습니다", recipeId), "../recipe/recipeList");
	}
	
	
	// 레시피 modify
	@RequestMapping("/usr/recipe/modify")
	public String viewModify(Model model, int recipeId) {

		Recipe recipe = recipeService.getForPrintRecipe(rq.getLoginedMemberId(), recipeId);

		if (recipe == null) {
			return rq.jsHistoryBack(Ut.f("%d번 레시피는 존재하지 않습니다", recipeId));
		}

		ResultData actorCanModifyRd = recipeService.actorCanModify(rq.getLoginedMemberId(), recipe);

		if (actorCanModifyRd.isFail()) {
			return rq.jsHistoryBackOnView(actorCanModifyRd.getMsg());
		}

		model.addAttribute("recipe", recipe);

		return "usr/recipe/recipeModify";
	}
	
	@RequestMapping("/usr/recipe/doModify")
	@ResponseBody
	public String doModify(Model model, int recipeId, int recipeCategory, String recipeName, String recipeBody, int recipePerson, int recipeLevel, int recipeCook, int recipeTime,
			 String recipeStuff, String recipeSauce, String recipeMsgBody, String replaceUri, MultipartRequest multipartRequest) {

		Recipe recipe = recipeService.getForPrintRecipe(rq.getLoginedMemberId(), recipeId);

		if (recipe == null) {
			return rq.jsHistoryBack(Ut.f("%d번 레시피는 존재하지 않습니다", recipeId));
		}
		// 수정 권한 체크
		if (recipe.getMemberId() != rq.getLoginedMemberId()) {
			return rq.jsHistoryBack(Ut.f("%d번 레시피에 대한 수정 권한이 없습니다.", recipeId));
		}

		ResultData actorCanModifyRd = recipeService.actorCanModify(rq.getLoginedMemberId(), recipe);

		if (actorCanModifyRd.isFail()) {
			return rq.jsHistoryBack(actorCanModifyRd.getMsg());
		}
		
		recipeService.modifyRecipe(recipeId, recipeCategory, recipeName, recipeBody, recipePerson, recipeLevel, recipeCook, recipeTime,
				 recipeStuff, recipeSauce, recipeMsgBody);
		
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
		
		String [] bodyMsg = recipe.getRecipeMsgBody().split(",");
		String [] stuff = recipe.getRecipeStuff().split(",");
		String [] sauce = recipe.getRecipeSauce().split(",");

		model.addAttribute("recipe", recipe);
		model.addAttribute("bodyMsg", bodyMsg);
		model.addAttribute("stuff", stuff);
		model.addAttribute("sauce", sauce);

		return rq.jsReplace(Ut.f("%d번 레시피를 수정했습니다 :) ", recipeId), replaceUri);
	}
	
	// 레시피 hitCount
	@RequestMapping("/usr/recipe/doIncreaseHitCountRd")
	@ResponseBody
	public ResultData<Integer> doIncreaseHitCountRd(int recipeId) {
		
		ResultData<Integer> increaseHitCountRd = recipeService.increaseHitCount(recipeId);

		if (increaseHitCountRd.isFail()) {
			return increaseHitCountRd;
		}

		ResultData<Integer> rd = ResultData.newData(increaseHitCountRd, "hitCount", recipeService.getRecipeHitCount(recipeId));

		rd.setData2("recipeId", recipeId);

		return rd;
	}
	
	
}
