package com.nadri.service.domain;

public class Friend {
	
	///Field
	private int friendNo;								//친구 번호(시퀀스)
	private String userId;							//유저 아이디(요청한 친구)
	private String friendId;							//친구 아이디(요청받은 친구)
	private String friendCode;					//친구 상태 코드(0:친구 신청 중or 아무것도 아닌 사이 1: 요청 수락시 2: 차단)
	private String profileImg;						//프로필 사진
	private String userName;								//친구 이름 표시
	private String createdDate;					//친구 생성일
	private int count;									//친구 총 수 세기 위한 수단


	///Constructor method
	public Friend(){
	}


	///Method 
	public int getFriendNo() {
		return friendNo;
	}


	public void setFriendNo(int friendNo) {
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


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getCreatedDate() {
		return createdDate;
	}


	public void setCreatedDate(String createdDate) {
		this.createdDate = createdDate;
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
				+ friendCode + ", profileImg=" + profileImg + ", userName=" + userName + ", createdDate=" + createdDate
				+ ", count=" + count + "]";
	}

}