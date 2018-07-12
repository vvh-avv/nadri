package com.nadri.service.comment;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Comment;

public interface CommentDao {

	public void addComment(Comment Comment) throws Exception;
	
	public void updateComment(Comment Comment) throws Exception;
	
	public List<Comment> getCommentList(Search search) throws Exception;
	
	public void deleteComment(int CommentNo) throws Exception;
	
	public int getCommentCount(int boardNo) throws Exception;
}
