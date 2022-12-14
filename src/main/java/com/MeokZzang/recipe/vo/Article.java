package com.MeokZzang.recipe.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class Article {
	private int id;
	private String regDate;
	private String updateDate;
	private int memberId;
	private String title;
	private String body;
	private int boardId;
	private int hitCount;
	private int goodReactionPoint;
	private int badReactionPoint;

	private String extra__writerName;
	private boolean extra__actorCanModify;
	private boolean extra__actorCanDelete;
	
	public String getForPrintType1RegDate() {
		return regDate.substring(2, 16).replace(" ", " ");
	}
	public String getForPrintType1updateDate() {
		return regDate.substring(2, 16).replace(" ", " ");
	}
	
	public String getForPrintBody() {
		return body.replaceAll("\n", "<br>");
	}
}