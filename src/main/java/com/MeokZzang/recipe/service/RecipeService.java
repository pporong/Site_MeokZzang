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

	// 레시피 리스트
	public List<Recipe> getRecipeList(int actorId, int recipeCategory , int page, int itemsInAPage, String searchKeywordTypeCode, String searchKeyword) {
		
		int limitStart = (page - 1) * itemsInAPage;
		int limitTake = itemsInAPage;
		
		List<Recipe> recipies = recipeRepository.getRecipeList(recipeCategory, searchKeywordTypeCode, searchKeyword, limitStart, limitTake);
		
		for (Recipe recipe : recipies) {
			updateForPrintData(actorId, recipe);
		}
		
		return recipies;
	}
	
	// 레시피 카운트
	public int getRecipiesCount(int recipeCategory, String searchKeywordTypeCode, String searchKeyword) {
		return recipeRepository.getRecipiesCount(recipeCategory, searchKeywordTypeCode, searchKeyword);
	}
	
	public void updateForPrintData(int actorId, Recipe recipe) {
		
		if (recipe == null) {
			return;
		}

		ResultData actorCanDeleteRd = actorCanDelete(actorId, recipe);
		recipe.setExtra__actorCanDelete(actorCanDeleteRd.isSuccess());
		
		ResultData actorCanModifyRd = actorCanModify(actorId, recipe);
		recipe.setExtra__actorCanModify(actorCanModifyRd.isSuccess());
		
	}

	// 레시피 상세보기
	public Recipe getForPrintRecipe(int actorId, int recipeId) {
		
		Recipe recipe = recipeRepository.getForPrintRecipe(recipeId);
		
		updateForPrintData(actorId, recipe);
		
		return recipe;
	}
	
	// 수정 권한
	public ResultData actorCanModify(int loginedMemberId, Recipe recipe) {
		
		if (recipe.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", "해당 게시물에 대한 수정 권한이 없습니다");
		}

		return ResultData.from("S-1", "수정 가능");
	}

	// 수정
	public ResultData<Recipe> modifyRecipe(int recipeId, int recipeCategory, String recipeName, String recipeBody, int recipePerson,
			int recipeLevel, int recipeCook, int recipeTime, String recipeStuff, String recipeSauce,
			String recipeMsgBody) {
		
		recipeRepository.modifyRecipe(recipeId, recipeCategory, recipeName, recipeBody, recipePerson,
			 recipeLevel, recipeCook, recipeTime, recipeStuff, recipeSauce, recipeMsgBody);
		
		Recipe recipe = getForPrintRecipe(0, recipeId);
		
		return ResultData.from("S-1", Ut.f("%d번 레시피를 수정했습니다", recipeId), "recipe", recipe);
	}
	
	// 삭제 권한
	public ResultData actorCanDelete(int loginedMemberId, Recipe recipe) {
		
		if (recipe == null) {
			return ResultData.from("F-1", "게시물이 존재하지 않습니다");
		}

		if (recipe.getMemberId() != loginedMemberId) {
			return ResultData.from("F-2", "해당 게시물에 대한 삭제 권한이 없습니다");
		}

		return ResultData.from("S-1", "삭제 가능");
	}

	// 삭제
	public void deleteRecipe(int recipeId) {
		recipeRepository.deleteRecipe(recipeId);
	}
	
	// 레시피 작성
	public ResultData<Integer> writeRecipe(int memberId, int recipeCategory, String recipeName,
			String recipeBody, int recipePerson, int recipeLevel, int recipeCook, int recipeTime, String recipeStuff, String recipeSauce, String recipeMsgBody) {
		
		recipeRepository.writeRecipe(memberId, recipeCategory, 
				recipeName, recipeBody, recipePerson, recipeLevel, recipeCook, recipeTime, recipeStuff, recipeSauce, recipeMsgBody);
		
		int recipeId = recipeRepository.getLastInsertId();
		
		return ResultData.from("S-1", Ut.f("%d번 레시피가 생성되었습니다", recipeId), "recipeId", recipeId);
	}

	// hitCount	
	public ResultData<Integer> increaseHitCount(int recipeId) {
		
		int affectedRowsCount = recipeRepository.increaseHitCount(recipeId);

		if (affectedRowsCount == 0) {
			return ResultData.from("F-1", "해당 게시물은 존재하지 않습니다.", "affectedRowsCount", affectedRowsCount);
		}

		return ResultData.from("S-1", "조회수 증가", "affectedRowsCount", affectedRowsCount);
	}

	public int getRecipeHitCount(int recipeId) {
		return recipeRepository.getRecipeHitCount(recipeId);
	}




}