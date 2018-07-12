package com.nadri.service.domain;

import java.sql.Timestamp;

public class Board {
	
	//Field
	private int boardNo;
	private User user;
	private Timestamp boardDate;
	private String boardTitle;
	private String boardContent;
	private String boardImg;
	private String openRange;
	private String hashTag;
	
	//Constructor
	public Board() {
	}
	
	//Method
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

	public Timestamp getBoardDate() {
		return boardDate;
	}

	public void setBoardDate(Timestamp boardDate) {
		this.boardDate = boardDate;
	}

	public String getBoardTitle() {
		return boardTitle;
	}

	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}

	public String getBoardContent() {
		return boardContent;
	}

	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}

	public String getOpenRange() {
		return openRange;
	}

	public void setOpenRange(String openRange) {
		this.openRange = openRange;
	}

	public String getBoardImg() {
		return boardImg;
	}

	public void setBoardImg(String boardImg) {
		this.boardImg = boardImg;
	}

	public String getHashTag() {
		return hashTag;
	}

	public void setHashTag(String hashTag) {
		this.hashTag = hashTag;
	}
	
	@Override
	public String toString() {
		return "BoardVO : [boardNo] "+boardNo+" [boardDate] "+boardDate+
				" [boardTitle] "+boardTitle+" [boardContent] "+boardContent+
				" [boardImg] "+boardImg+" [openRange] "+openRange+" [hashTag] "+hashTag;
	}
}
