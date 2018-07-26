package com.nadri.service.domain;

import java.math.BigDecimal;
import java.sql.Time;
import java.sql.Timestamp;
import java.util.Date;

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
	private String wayPointNav;
	private String stayTime;
	private String moveTime;
	private String wayPointStartHour;
	private String wayPointEndHour;
	
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

	public String getStayTime() {
		return stayTime;
	}

	public String getMoveTime() {
		return moveTime;
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

	public void setStayTime(String stayTime) {
		this.stayTime = stayTime;
	}

	public void setMoveTime(String moveTime) {
		this.moveTime = moveTime;
	}
	
	public String getWayPointNav() {
		return wayPointNav;
	}

	public String getWayPointStartHour() {
		return wayPointStartHour;
	}

	public String getWayPointEndHour() {
		return wayPointEndHour;
	}

	public void setWayPointNav(String wayPointNav) {
		this.wayPointNav = wayPointNav;
	}

	public void setWayPointStartHour(String wayPointStartHour) {
		this.wayPointStartHour = wayPointStartHour;
	}

	public void setWayPointEndHour(String wayPointEndHour) {
		this.wayPointEndHour = wayPointEndHour;
	}

	///toString
	@Override
	public String toString() {
		return "WayPoint [wayPointNo=" + wayPointNo + ", scheduleNo=" + scheduleNo + ", wayPointTitle=" + wayPointTitle
				+ ", wayPointImg=" + wayPointImg + ", wayPointX=" + wayPointX + ", wayPointY=" + wayPointY
				+ ", wayPointAddress=" + wayPointAddress + ", wayPointDetail=" + wayPointDetail + ", wayPointNav="
				+ wayPointNav + ", stayTime=" + stayTime + ", moveTime=" + moveTime + ", wayPointStartHour="
				+ wayPointStartHour + ", wayPointEndHour=" + wayPointEndHour + "]";
	}

}
