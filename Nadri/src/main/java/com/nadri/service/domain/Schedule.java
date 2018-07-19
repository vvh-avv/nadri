package com.nadri.service.domain;

import java.sql.Date;
import java.util.List;

public class Schedule {
	
	///Field
	private int scheduleNo;
	private Date scheduleDate;
	private String scheduleImg;
	private String scheduleTitle;
	private String scheduleReview;
	private String hashTag;
	private String userId;
	private Date scheduleCreateTime;
	private Date scheduleModifyTime;
	private String openRange;
	private String transportationCode;
	private List<WayPoint> wayPoints;
	private String startHour;
	private String endHour;
	
	///Constructor
	public Schedule() {
	}
	
	///Method
	public int getScheduleNo() {
		return scheduleNo;
	}

	public Date getScheduleDate() {
		return scheduleDate;
	}

	public String getScheduleImg() {
		return scheduleImg;
	}

	public String getScheduleTitle() {
		return scheduleTitle;
	}

	public String getScheduleReview() {
		return scheduleReview;
	}

	public String getHashTag() {
		return hashTag;
	}

	public String getUserId() {
		return userId;
	}

	public Date getScheduleCreateTime() {
		return scheduleCreateTime;
	}

	public Date getScheduleModifyTime() {
		return scheduleModifyTime;
	}

	public String getOpenRange() {
		return openRange;
	}

	public String getTransportationCode() {
		return transportationCode;
	}

	public List<WayPoint> getWayPoints() {
		return wayPoints;
	}

	public String getStartHour() {
		return startHour;
	}

	public String getEndHour() {
		return endHour;
	}

	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}

	public void setScheduleDate(Date scheduleDate) {
		this.scheduleDate = scheduleDate;
	}

	public void setScheduleImg(String scheduleImg) {
		this.scheduleImg = scheduleImg;
	}

	public void setScheduleTitle(String scheduleTitle) {
		this.scheduleTitle = scheduleTitle;
	}

	public void setScheduleReview(String scheduleReview) {
		this.scheduleReview = scheduleReview;
	}

	public void setHashTag(String hashTag) {
		this.hashTag = hashTag;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setScheduleCreateTime(Date scheduleCreateTime) {
		this.scheduleCreateTime = scheduleCreateTime;
	}

	public void setScheduleModifyTime(Date scheduleModifyTime) {
		this.scheduleModifyTime = scheduleModifyTime;
	}

	public void setOpenRange(String openRange) {
		this.openRange = openRange;
	}

	public void setTransportationCode(String transportationCode) {
		this.transportationCode = transportationCode;
	}

	public void setWayPoints(List<WayPoint> wayPoints) {
		this.wayPoints = wayPoints;
	}

	public void setStartHour(String startHour) {
		this.startHour = startHour;
	}

	public void setEndHour(String endHour) {
		this.endHour = endHour;
	}

	
	///toString
	@Override
	public String toString() {
		return "Schedule [scheduleNo=" + scheduleNo + ", scheduleDate=" + scheduleDate + ", scheduleImg=" + scheduleImg
				+ ", scheduleTitle=" + scheduleTitle + ", scheduleReview=" + scheduleReview + ", hashTag=" + hashTag
				+ ", userId=" + userId + ", scheduleCreateTime=" + scheduleCreateTime + ", scheduleModifyTime="
				+ scheduleModifyTime + ", openRange=" + openRange + ", transportationCode=" + transportationCode
				+ ", wayPoints=" + wayPoints + ", startHour=" + startHour + ", endHour=" + endHour + "]";
	}
}
