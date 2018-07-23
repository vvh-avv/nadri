package com.nadri.service.domain;

import java.sql.Timestamp;
import java.util.List;

public class Comment {

	//Field
	private int commentNo;
	private int boardNo;
	private User user;
	private Timestamp commentTime;
	private String commentContent;
	
	//Constructor
	public Comment() {
	}

	//Method
	public int getCommentNo() {
		return commentNo;
	}

	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}

	public int getBoardNo() {
		return boardNo;
	}

	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Timestamp getcommentTime() {
		return commentTime;
	}

	public void setcommentTime(Timestamp commentTime) {
		this.commentTime = commentTime;
	}

	public String getCommentContent() {
		return commentContent;
	}

	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}

	
	@Override
	public String toString() {
		return "CommentVO : [commentNo] "+commentNo+" [boardNo] "+boardNo+
				" [commentTime] "+commentTime+" [commentContent] "+commentContent+
				" [user] "+user;
	}

}
