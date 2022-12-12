package com.MeokZzang.recipe.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Recipe {
	private int recipeId;
	private int recipeCategory;
	private String recipeName;
	private String recipeMsgBody;
	private int writerId;
	private int recipePerson;
	private int recipeLevel;
	private String recipeTitleImg;
	private String recipeBodyImg;
	private int recipeCook;
	private String recipeStuff;
	private String recipeSource;
	private int recipeTime;
	private int recipeHitCount;
	private int recipePoint;
	private String recipeRegDate;
	private String recipeUpdateDate;
	private String recipeDelStatus;
	private String recepeDelDate;

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