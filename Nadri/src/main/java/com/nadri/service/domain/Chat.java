package com.nadri.service.domain;

import java.sql.Date;

public class Chat {
	private int chatNo ;
	private String chatContent ;
	private String flag ;
	private Date sendingDate ;
	private String senderId ;
	private String receiverId ;
	private int chatRoomNo ;
	
	public int getChatNo() {
		return chatNo;
	}
	public void setChatNo(int chatNo) {
		this.chatNo = chatNo;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getFlag() {
		return flag;
	}
	public void setFlag(String flag) {
		this.flag = flag;
	}
	public Date getSendingDate() {
		return sendingDate;
	}
	public void setSendingDate(Date sendingDate) {
		this.sendingDate = sendingDate;
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
	public int getChatRoomNo() {
		return chatRoomNo;
	}
	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}
	
	public String toString() {
		return "chatNo : " + chatNo + "  chatContent : " + chatContent + "   flag :" + flag + "  Date : " + sendingDate +
				"  senderId :  " + senderId + "  receiverId :  " + receiverId + "  chatRoomNo :  " + chatRoomNo ;
	}
}
