package com.nadri.service.comment;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Comment;

public interface CommentDao {

	public void addComment(Comment Comment) throws Exception;
	
	public void updateComment(Comment Comment) throws Exception;

	public Comment getComment(int commentNo) throws Exception;
	
	public List<Comment> getCommentList(int boardNo) throws Exception;
	
	public void deleteComment(int CommentNo) throws Exception;
}
