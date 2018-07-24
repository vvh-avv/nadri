package com.nadri.service.domain;

public class Friend {
	
	///Field
	private int friendNo;								//模备 锅龋(矫啮胶)
	private String userId;							//蜡历 酒捞叼(夸没茄 模备)
	private String friendId;							//模备 酒捞叼(夸没罐篮 模备)
	private String friendCode;					//模备 内靛 (0: 酒公巴档 酒丛, 1: 模备)
	private String friendRequest;				//模备 夸没 (Y: 模备 夸没しし, N: 模备 夸没 救 窃)

	
	///Constructor method
		public Friend(){
		}
	
	
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

	public String getFriendRequest() {
		return friendRequest;
	}


	public void setFriend_request(String friendRequest) {
		this.friendRequest = friendRequest;
	}


	@Override
	public String toString() {
		return "Friend [friendNo=" + friendNo + ", userId=" + userId + ", friendId=" + friendId + ", friendCode="
				+ friendCode + ", friendRequest=" + friendRequest + "]";
	}


	

}