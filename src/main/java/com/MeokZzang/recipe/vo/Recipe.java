package com.MeokZzang.recipe.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe {
	private int recipeId;	// 레시피 id
	private int recipeCategory; // 카테고리 (한식, 양식, 중식, 일식, 기타)
	private String recipeName;	// 레시피 이름
	private String recipeBody; // 레시피 간단 설명
	private String recipeMsgBody; // 레시피 과정 설명
	private int writerId;	// 작성자 id
	private int recipePerson;	// 인원
	private int recipeLevel;	// 난이도
	private String recipeTitleImg; // 완성 사진
	private String recipeBodyImg;	// 레시피 과정 사진
	private int recipeCook;	// 조리 방법
	private String recipeStuff;	// 재료
	private String recipeSauce;	// 양념
	private int recipeTime;	// 소요 시간
	private int recipeHitCount;	// 조회수
	private int recipePoint;	// 추천수
	private String recipeRegDate;	// 작성날짜
	private String recipeUpdateDate;	// 수정날짜
	private String recipeDelStatus;	// 삭제 여부
	private String recepeDelDate;	// 삭제 날짜

	private String extra__writerName;
	private boolean extra__actorCanModify;
	private boolean extra__actorCanDelete;
	
	public String getForPrintType1RegDate() {
		return recipeRegDate.substring(2, 16).replace(" ", " ");
	}
	public String getForPrintType1updateDate() {
		return recipeRegDate.substring(2, 16).replace(" ", " ");
	}
	
	public String getForPrintBody() {
		return recipeMsgBody.replaceAll("\n", "<br>");
	}
}