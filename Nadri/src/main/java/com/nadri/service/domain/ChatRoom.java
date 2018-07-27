package com.nadri.service.domain;

public class ChatRoom {
	private int chatRoomNo ;
	private String userId ;
	private String userProfileImg ;
	private int flag ; 
	
	public ChatRoom() {
		
	}
	
	public int getChatRoomNo() {
		return chatRoomNo;
	}
	public void setChatRoomNo(int chatRoomNo) {
		this.chatRoomNo = chatRoomNo;
	}
	
	
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	

	public String getUserProfileImg() {
		return userProfileImg;
	}

	public void setUserProfileImg(String userProfileImg) {
		this.userProfileImg = userProfileImg;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public String toString() {
		return "chatRoomNo : " + chatRoomNo + "userId : " + userId + " userProfileImg : " + userProfileImg + " falg : " + flag ;
	}
}
