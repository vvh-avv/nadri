package com.nadri.service.domain;

public class Friend {
	
	///Field
	private int friendNo;								//친구 번호
	private String userId;							//유저 아이디(요청한 친구)
	private String friendId;							//친구 아이디(요청받은 친구)
	private String friendCode;					//친구 코드(0:친구 신청 중or 아무것도 아닌 사이 1: 요청 수락시 2: 차단)
	private String profileImg;						//프로필 사진
	private String name;								//이름
	private int count;									


	///Constructor method
	public Friend(){
	}


	///Method 
	public int getFrienNo() {
		return friendNo;
	}



	public void setFrienNo(int friendNo) {
		this.friendNo = friendNo;
	}



	public String getUserId() {
		return userId;
	}



	public void setUserId(String userId) {
		this.userId = userId;
	}



	public String getFriendId() {
		return friendId;
	}



	public void setFriendId(String friendId) {
		this.friendId = friendId;
	}



	public String getFriendCode() {
		return friendCode;
	}



	public void setFriendCode(String friendCode) {
		this.friendCode = friendCode;
	}



	public String getProfileImg() {
		return profileImg;
	}



	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	public int getCount() {
		return count;
	}



	public void setCount(int count) {
		this.count = count;
	}


	@Override
	public String toString() {
		return "Friend [friendNo=" + friendNo + ", userId=" + userId + ", friendId=" + friendId + ", friendCode="
				+ friendCode + ", profileImg=" + profileImg + ", name=" + name + ", count=" + count + "]";
	}


}