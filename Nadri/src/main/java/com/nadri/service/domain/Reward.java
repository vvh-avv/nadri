package com.nadri.service.domain;

public class Reward {
	
	private String userId;
	private String rewardName;
	private String rewardImg;
	private String rewardLevel;
	
	@Override
	public String toString() {
		return "Reward [userId=" + userId + ", rewardName=" + rewardName + ", rewardImg=" + rewardImg + ", rewardLevle="
				+ rewardLevel + "]";
	}
	
	public String getUserId() {
		return userId;
	}
	
	public void setUserId(String userId) {
		this.userId = userId;
	}
	
	public String getRewardName() {
		return rewardName;
	}
	
	public void setRewardName(String rewardName) {
		this.rewardName = rewardName;
	}
	
	public String getRewardImg() {
		return rewardImg;
	}
	
	public void setRewardImg(String rewardImg) {
		this.rewardImg = rewardImg;
	}
	
	public String getRewardLevel() {
		return rewardLevel;
	}
	
	public void setRewardLevel(String rewardLevle) {
		this.rewardLevel = rewardLevle;
	}

}
