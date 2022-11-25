package com.MeokZzang.recipe.repository;

import org.apache.ibatis.annotations.Mapper;

import com.MeokZzang.recipe.vo.Board;

@Mapper
public interface BoardRepository {

	public Board getBoardById(int id);

}
