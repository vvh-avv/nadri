package com.nadri.service.domain;

import java.sql.Timestamp;
import java.util.List;

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
	//기능구현하다보니 추가된 필드
	private int commCnt;
	private int likeFlag;
	private int likeCnt;
	private String commLastTime;
	private List<Comment> comment;
	private int boardCode; //0:일반게시물 //그외 : 스케줄번호
	
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

	public int getLikeFlag() {
		return likeFlag;
	}

	public void setLikeFlag(int likeFlag) {
		this.likeFlag = likeFlag;
	}

	public int getCommCnt() {
		return commCnt;
	}

	public void setCommCnt(int commCnt) {
		this.commCnt = commCnt;
	}

	public int getLikeCnt() {
		return likeCnt;
	}

	public void setLikeCnt(int likeCnt) {
		this.likeCnt = likeCnt;
	}

	public String getCommLastTime() {
		return commLastTime;
	}

	public void setCommLastTime(String commLastTime) {
		this.commLastTime = commLastTime;
	}
	
	public List<Comment> getComment() {
		return comment;
	}

	public void setComment(List<Comment> comment) {
		this.comment = comment;
	}
	
	public int getBoardCode() {
		return boardCode;
	}

	public void setBoardCode(int boardCode) {
		this.boardCode = boardCode;
	}
	
	@Override
	public String toString() {
		return "BoardVO : [boardCode] "+boardCode+" [user]"+user+"[boardNo] "+boardNo+" [boardDate] "+boardDate+
				" [boardTitle] "+boardTitle+" [boardContent] "+boardContent+
				" [boardImg] "+boardImg+" [openRange] "+openRange+" [hashTag] "+hashTag+
				" [commCnt] "+commCnt+" [likeCnt] "+likeCnt+" [commLastTime] "+commLastTime+
				" [comment] "+comment;
	}
}
