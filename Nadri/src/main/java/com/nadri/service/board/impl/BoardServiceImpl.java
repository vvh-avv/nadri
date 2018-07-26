package com.nadri.service.board.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.board.BoardDao;
import com.nadri.service.board.BoardService;
import com.nadri.service.domain.Board;

@Service("boardServiceImpl")
public class BoardServiceImpl implements BoardService{
	
	@Autowired
	@Qualifier("boardDaoImpl")
	private BoardDao boardDao;
	
	public void setBoardDao(BoardDao boardDao) {
		this.boardDao = boardDao;
	}
	
	public BoardServiceImpl() {
	}

	//게시물
	@Override
	public void addBoard(Board board) throws Exception {
		boardDao.addBoard(board);
	}

	@Override
	public void updateBoard(Board board) throws Exception {
		boardDao.updateBoard(board);
	}

	@Override
	public Board getBoard(int boardNo) throws Exception {
		return boardDao.getBoard(boardNo);
	}

	@Override
	public List<Board> getBoardList(Search search, String userId) throws Exception {		
		List<Board> list = boardDao.getBoardList(search, userId);
		
		return list;
	}

	@Override
	public void deleteBoard(int boardNo) throws Exception {
		boardDao.deleteBoard(boardNo);
	}
	
	//좋아요
	@Override
	public int getLikeCount(int boardNo) throws Exception{
		return boardDao.getLikeCount(boardNo);
	}
	
	@Override
	public int getLikeFlag(int boardNo, String userId) throws Exception{
		return boardDao.getLikeFlag(boardNo, userId);
	}
	
	@Override
	public void addLike(int boardNo, String userId) throws Exception{
		boardDao.addLike(boardNo, userId);
	}
	
	@Override
	public void deleteLike(int boardNo, String userId) throws Exception{
		boardDao.deleteLike(boardNo, userId);
	}
	
	//마이페이지 작성한 글보기
	@Override
	public List<Board> getMyBoardList(String userId) throws Exception{
		return boardDao.getMyBoardList(userId);
	}

	@Override
	public int checkBoard(int boardCode, String userId) throws Exception {
		return boardDao.checkBoard(boardCode, userId);
	}
	
	//메인화면 추천게시물
	@Override
	public List<Board> getRecomBoard(Search search) throws Exception{
		return boardDao.getRecomBoard(search);
	}
	
	//메인화면 추천게시물 (회원/친구좋아요)
	@Override
	public List<Board> getRecomUserLike(Search search, String userId) throws Exception {
		return boardDao.getRecomUserLike(search, userId);
	}

	//메인화면 추천게시물 (회원/작성글)
	@Override
	public List<Board> getRecomUserBoard(Search search, String userId) throws Exception {
		return boardDao.getRecomUserBoard(search, userId);
	}
	
	//보상
	@Override
	public int getMyCount(String keyword, String userId) throws Exception {
		return boardDao.getMyCount(keyword, userId);
	}


}
