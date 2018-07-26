package com.nadri.service.board.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.board.BoardDao;
import com.nadri.service.domain.Board;

@Repository("boardDaoImpl")
public class BoardDaoImpl implements BoardDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public BoardDaoImpl() {
	}
	
	//게시물
	public void addBoard(Board board) throws Exception{
		sqlSession.insert("BoardMapper.insertBoard", board);
	}

	public void updateBoard(Board board) throws Exception {
		sqlSession.update("BoardMapper.updateBoard", board);
	}

	public Board getBoard(int boardNo) throws Exception {
		return sqlSession.selectOne("BoardMapper.getBoard", boardNo);
	}

	public List<Board> getBoardList(Search search) throws Exception {
		return sqlSession.selectList("BoardMapper.getBoardList", search);
	}

	public void deleteBoard(int boardNo) throws Exception {
		sqlSession.delete("BoardMapper.deleteBoard", boardNo);
	}
	
	//좋아요
	public int getLikeCount(int boardNo) throws Exception{
		return sqlSession.selectOne("BoardMapper.getLikeCount", boardNo);
	}
	
	public int getLikeFlag(int boardNo, String userId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("userId", userId);
		
		return sqlSession.selectOne("BoardMapper.getLikeFlag", map);
	}
	
	public void addLike(int boardNo, String userId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("userId", userId);
		
		sqlSession.insert("BoardMapper.insertLike", map);
	}

	public void deleteLike(int boardNo, String userId) throws Exception{
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardNo", boardNo);
		map.put("userId", userId);
		
		sqlSession.delete("BoardMapper.deleteLike", map);
	}

	//마이페이지 작성한 글보기
	public List<Board> getMyBoardList(String userId) throws Exception{
		return sqlSession.selectList("BoardMapper.getMyBoardList", userId);
	}

	public int checkBoard(int boardCode, String userId) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("boardCode", boardCode);
		map.put("userId", userId);
		
		return sqlSession.selectOne("BoardMapper.checkBoard", map);
	}
	
	//메인화면 추천게시물
	public List<Board> getRecomBoard(Search search) throws Exception{
		return sqlSession.selectList("BoardMapper.getRecomBoard", search);
	}

	//보상
	@Override
	public int getMyCount(String keyword, String userId) throws Exception {
		Map<String, String> map = new HashMap<String, String>();
		map.put("keyword", keyword);
		map.put("userId", userId);
		
		return sqlSession.selectOne("BoardMapper.getMyCount", map);
	}
}
