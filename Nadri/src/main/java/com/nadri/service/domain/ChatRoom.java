package com.nadri.service.domain;

import java.sql.Date;

public class ChatRoom {
	private int chatRoomNo ;
	private Chat chat  ;
	private String userId ;
	private String userName ;
	private String lastContent ;
	private Date sendingDate ;
	private int flag ;
	
	public ChatRoom() {
		
	}
	
	public int getChatRoomNo() {
		return chatRoomNo;
	}
	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}
	
	public Chat getChat() {
		return chat ;
	}
	public void setChat(Chat chat) {
		this.chat = chat ;
	}
	public Date getSendingDate() {
		return sendingDate;
	}
	public void setSendingDate(Date sendingDate) {
		this.sendingDate = sendingDate;
	}
	public String getLastContent() {
		return lastContent;
	}
	public void setLastContent(String lastContent) {
		this.lastContent = lastContent;
	}
	public String getUserName() {
		return userName;
	}

	public void setUsers(String userName) {
		this.userName = userName;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String toString() {
		return "chatRoomNo : " + chatRoomNo + "userId : " + userId +" userName : " + userName	+ " Chat : " +  chat + " sendingDate : " + sendingDate +
				  " lastContent : " + lastContent ; 
	}
}
