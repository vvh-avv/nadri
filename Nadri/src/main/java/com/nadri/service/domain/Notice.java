package com.nadri.service.domain;

public class Notice {
	private int noticeNo ;
	private String senderId ;
	private String receiverId ;
	private int masterNo ;
	private int otherPk ;
	private int noticeCode ;
	private String content ;
	private boolean flag ;
	private int count ;
	
	public int getNoticeNo() {
		return noticeNo;
	}

	public void setNoticeNo(int noticeNo) {
		this.noticeNo = noticeNo;
	}

	public String getSenderId() {
		return senderId;
	}

	public void setSenderId(String senderId) {
		this.senderId = senderId;
	}

	public String getReceiverId() {
		return receiverId;
	}

	public void setReceiverId(String receiverId) {
		this.receiverId = receiverId;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public boolean isFlag() {
		return flag;
	}

	public void setFlag(boolean flag) {
		this.flag = flag;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}
	
	public int getMasterNo() {
		return masterNo;
	}

	public void setMasterNo(int masterNo) {
		this.masterNo = masterNo;
	}

	public int getOtherPk() {
		return otherPk;
	}

	public void setOtherPk(int otherPk) {
		this.otherPk = otherPk;
	}

	public int getNoticeCode() {
		return noticeCode;
	}

	public void setNoticeCode(int noticeCode) {
		this.noticeCode = noticeCode;
	}

	public String toString() {
		return " noticeNo : " + noticeNo + " senderId : " + senderId + " receiverId : " + receiverId + " otherPk : " + otherPk + " content : " + content +
				" flag : " + flag + " count : " + count + " noticeCode : " + noticeCode ;
	}
}