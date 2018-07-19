package com.nadri.service.comment;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Comment;

public interface CommentService {
	
	public void addComment(Comment comment) throws Exception;
	
	public void updateComment(Comment comment) throws Exception;
	
	public Comment getComment(int commentNo) throws Exception;
	
	public List<Comment> getCommentList(int boardNo) throws Exception;
	
	public void deleteComment(int commentNo) throws Exception;
}
