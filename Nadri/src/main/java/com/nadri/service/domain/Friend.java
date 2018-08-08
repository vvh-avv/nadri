package com.nadri.service.domain;

public class Friend {
   
   ///Field
   private int friendNo;                        //친구 번호(시퀀스)
   private String userId;                     //유저 아이디(요청한 친구)
   private String friendId;                     //친구 아이디(요청받은 친구)
   private String friendCode;               //친구 코드 (0: 아무것도 아님, 1: 친구)
   private String userName;               //친구 이름
   private String profileImg ;				//프로필 사진
   private String introduce ;				//자기소개
 
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
   
   public String getUserName() {
      return userName;
   }


   public void setFriendName(String userName) {
      this.userName = userName;
   }
   
   public String getProfileImg() {
      return profileImg;
   }


   public void setProfileImg(String profileImg) {
      this.profileImg = profileImg;
   }


   public void setUserName(String userName) {
      this.userName = userName;
   }


   public String getIntroduce() {
      return introduce;
   }


   public void setIntroduce(String introduce) {
      this.introduce = introduce;
   }


@Override
public String toString() {
	return "Friend [friendNo=" + friendNo + ", userId=" + userId + ", friendId=" + friendId + ", friendCode="
			+ friendCode + ", userName=" + userName + ", profileImg=" + profileImg + ", introduce=" + introduce + "]";
}

}