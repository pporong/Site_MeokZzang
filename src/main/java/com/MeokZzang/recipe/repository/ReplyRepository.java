package com.MeokZzang.recipe.repository;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.MeokZzang.recipe.vo.Article;
import com.MeokZzang.recipe.vo.Reply;

@Mapper
public interface ReplyRepository {
	
	public void writeReply(int actorId, String relTypeCode, int relId, String body);

	public int getLastInsertId();
	
	public List<Reply> getForPrintReplies(String relTypeCode, int relId);

	public int deleteReply(int id);
	
	public Reply getForPrintReply(int id);

	public void modifyReply(int id, String body);

	public int increaseGoodReplyRp(int relId);

	public int decreaseGoodReplyRp(int relId);

	public Article getReply(int id);
}
