package com.nadri.service.board;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Board;

public interface BoardDao {

	//게시물
	public void addBoard(Board board) throws Exception;
	
	public void updateBoard(Board board) throws Exception;
	
	public Board getBoard(int boardNo) throws Exception;
	
	public List<Board> getBoardList(Search search, String userId) throws Exception;
	
	public void deleteBoard(int boardNo) throws Exception;
	
	//좋아요
	public int getLikeCount(int boardNo) throws Exception;
	
	public int getLikeFlag(int boardNo, String userId) throws Exception;
	
	public void addLike(int boardNo, String userId) throws Exception;
	
	public void deleteLike(int boardNo, String userId) throws Exception;

	//마이페이지 작성한 글보기
	public List<Board> getMyBoardList(String userId) throws Exception;

	public int checkBoard(int boardCode, String userId) throws Exception;
	
	//메인화면 추천게시물
	public List<Board> getRecomBoard(Search search) throws Exception;

	//메인화면 추천게시물 (회원/친구좋아요)
	public List<Board> getRecomUserLike(Search search, String userId) throws Exception;
	
	//메인화면 추천게시물 (회원/작성글)
	public List<Board> getRecomUserBoard(Search search, String userId) throws Exception;
	
	//보상
	public int getMyCount(String keyword, String userId) throws Exception;

}
