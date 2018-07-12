package com.nadri.service.board.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
	public Map<String, Object> getBoard(int boardNo) throws Exception {
		int reLikeCnt = boardDao.getLikeCount(boardNo);
		Board reBoard = boardDao.getBoard(boardNo);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("reLikeCnt", reLikeCnt ); //좋아요개수
		map.put("reBoard", reBoard); //게시물정보
		
		return map;
	}

	@Override
	public List<Board> getBoardList(Search search) throws Exception {
		List<Board> list = boardDao.getBoardList(search);
		
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
}
