package com.nadri.service.comment.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.comment.CommentDao;
import com.nadri.service.domain.Comment;

@Repository("commentDaoImpl")
public class CommentDaoImpl implements CommentDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public CommentDaoImpl() {
	}
	
	//Method
	public void addComment(Comment comment) throws Exception{
		sqlSession.insert("CommentMapper.insertComment", comment);
	}

	public void updateComment(Comment comment) throws Exception {
		sqlSession.update("CommentMapper.updateComment", comment);
	}

	public List<Comment> getCommentList(Search search) throws Exception {
		return sqlSession.selectList("CommentMapper.getCommentList", search);
	}

	public void deleteComment(int commentNo) throws Exception {
		sqlSession.delete("CommentMapper.deleteComment", commentNo);
	}
	
	public int getCommentCount(int boardNo) throws Exception{
		return sqlSession.selectOne("CommentMapper.getCommentCount", boardNo);
	}
}
