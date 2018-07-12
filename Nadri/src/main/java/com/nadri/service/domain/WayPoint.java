package com.nadri.service.domain;

import java.math.BigDecimal;
import java.sql.Time;

public class WayPoint {
	
	///Field
	private int wayPointNo;
	private int scheduleNo;
	private String wayPointTitle;
	private String wayPointImg;
	private BigDecimal wayPointX;
	private BigDecimal wayPointY;
	private String wayPointAddress;
	private String wayPointDetail;
	private Time stayTime;
	private Time moveTime;
	private Time startHour;
	private Time endHour;
	
	///Constructor
	public WayPoint() {
	}
	
	///Method
	public int getWayPointNo() {
		return wayPointNo;
	}

	public int getScheduleNo() {
		return scheduleNo;
	}

	public String getWayPointTitle() {
		return wayPointTitle;
	}

	public String getWayPointImg() {
		return wayPointImg;
	}

	public BigDecimal getWayPointX() {
		return wayPointX;
	}

	public BigDecimal getWayPointY() {
		return wayPointY;
	}

	public String getWayPointAddress() {
		return wayPointAddress;
	}

	public String getWayPointDetail() {
		return wayPointDetail;
	}

	public Time getStayTime() {
		return stayTime;
	}

	public Time getMoveTime() {
		return moveTime;
	}

	public Time getStartHour() {
		return startHour;
	}

	public Time getEndHour() {
		return endHour;
	}

	public void setWayPointNo(int wayPointNo) {
		this.wayPointNo = wayPointNo;
	}

	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}

	public void setWayPointTitle(String wayPointTitle) {
		this.wayPointTitle = wayPointTitle;
	}

	public void setWayPointImg(String wayPointImg) {
		this.wayPointImg = wayPointImg;
	}

	public void setWayPointX(BigDecimal wayPointX) {
		this.wayPointX = wayPointX;
	}

	public void setWayPointY(BigDecimal wayPointY) {
		this.wayPointY = wayPointY;
	}

	public void setWayPointAddress(String wayPointAddress) {
		this.wayPointAddress = wayPointAddress;
	}

	public void setWayPointDetail(String wayPointDetail) {
		this.wayPointDetail = wayPointDetail;
	}

	public void setStayTime(Time stayTime) {
		this.stayTime = stayTime;
	}

	public void setMoveTime(Time moveTime) {
		this.moveTime = moveTime;
	}

	public void setStartHour(Time startHour) {
		this.startHour = startHour;
	}

	public void setEndHour(Time endHour) {
		this.endHour = endHour;
	}
	
	///toString
	@Override
	public String toString() {
		return "WayPoint [wayPointNo=" + wayPointNo + ", scheduleNo=" + scheduleNo + ", wayPointTitle=" + wayPointTitle
				+ ", wayPointImg=" + wayPointImg + ", wayPointX=" + wayPointX + ", wayPointY=" + wayPointY
				+ ", wayPointAddress=" + wayPointAddress + ", wayPointDetail=" + wayPointDetail + ", stayTime="
				+ stayTime + ", moveTime=" + moveTime + ", startHour=" + startHour + ", endHour=" + endHour + "]";
	}
	
}
