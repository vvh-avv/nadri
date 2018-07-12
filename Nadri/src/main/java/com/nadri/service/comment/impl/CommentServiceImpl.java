package com.nadri.service.comment.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.comment.CommentDao;
import com.nadri.service.comment.CommentService;
import com.nadri.service.domain.Comment;

@Service("commentServiceImpl")
public class CommentServiceImpl implements CommentService{
	
	@Autowired
	@Qualifier("commentDaoImpl")
	private CommentDao commentDao;
	
	public void setCommentDao(CommentDao commentDao) {
		this.commentDao = commentDao;
	}
	
	public CommentServiceImpl() {
	}

	@Override
	public void addComment(Comment comment) throws Exception {
		commentDao.addComment(comment);
	}

	@Override
	public void updateComment(Comment comment) throws Exception {
		commentDao.updateComment(comment);
	}

	@Override
	public List<Comment> getCommentList(Search search) throws Exception {
		List<Comment> list = commentDao.getCommentList(search);
		
		return list;
	}

	@Override
	public void deleteComment(int commentNo) throws Exception {
		commentDao.deleteComment(commentNo);
	}
	
	@Override
	public int getCommentCount(int boardNo) throws Exception{
		return commentDao.getCommentCount(boardNo);
	}
	
}
