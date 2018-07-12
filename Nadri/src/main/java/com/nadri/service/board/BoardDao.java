package com.nadri.service.board;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Board;

public interface BoardDao {

	//게시물
	public void addBoard(Board board) throws Exception;
	
	public void updateBoard(Board board) throws Exception;
	
	public Board getBoard(int boardNo) throws Exception;
	
	public List<Board> getBoardList(Search search) throws Exception;
	
	public void deleteBoard(int boardNo) throws Exception;
	
	//좋아요
	public int getLikeCount(int boardNo) throws Exception;
	
	public int getLikeFlag(int boardNo, String userId) throws Exception;
	
	public void addLike(int boardNo, String userId) throws Exception;
	
	public void deleteLike(int boardNo, String userId) throws Exception;
}
