package com.nadri.service.domain;

import java.math.BigDecimal;
import java.sql.Date;

public class Spot {
	
	///Field
	private int spotNo;
	private String spotCode;
	private String spotTitle;
	private String spotPhone;
	private String spotAddress;
	private String spotDetail;
	private BigDecimal spotX;
	private BigDecimal spotY;
	private String spotImg;
	private Date spotCreateTime;
	private Date spotModifyTime;
	private String spotProvince;
	private String spotDetailURL;
	private int spotReadCnt;
	
	///Constructor
	public Spot() {
	}
	
	///Method
	public int getSpotNo() {
		return spotNo;
	}

	public String getSpotCode() {
		return spotCode;
	}
	
	public String getSpotTitle() {
		return spotTitle;
	}

	public String getSpotPhone() {
		return spotPhone;
	}

	public String getSpotAddress() {
		return spotAddress;
	}

	public String getSpotDetail() {
		return spotDetail;
	}

	public BigDecimal getSpotX() {
		return spotX;
	}

	public BigDecimal getSpotY() {
		return spotY;
	}

	public String getSpotImg() {
		return spotImg;
	}

	public Date getSpotCreateTime() {
		return spotCreateTime;
	}

	public Date getSpotModifyTime() {
		return spotModifyTime;
	}

	public String getSpotProvince() {
		return spotProvince;
	}

	public String getSpotDetailURL() {
		return spotDetailURL;
	}

	public int getSpotReadCnt() {
		return spotReadCnt;
	}

	public void setSpotNo(int spotNo) {
		this.spotNo = spotNo;
	}

	public void setSpotCode(String spotCode) {
		this.spotCode = spotCode;
	}

	public void setSpotPhone(String spotPhone) {
		this.spotPhone = spotPhone;
	}

	public void setSpotAddress(String spotAddress) {
		this.spotAddress = spotAddress;
	}

	public void setSpotDetail(String spotDetail) {
		this.spotDetail = spotDetail;
	}

	public void setSpotX(BigDecimal spotX) {
		this.spotX = spotX;
	}

	public void setSpotY(BigDecimal spotY) {
		this.spotY = spotY;
	}

	public void setSpotImg(String spotImg) {
		this.spotImg = spotImg;
	}

	public void setSpotCreateTime(Date spotCreateTime) {
		this.spotCreateTime = spotCreateTime;
	}

	public void setSpotModifyTime(Date spotModifyTime) {
		this.spotModifyTime = spotModifyTime;
	}

	public void setSpotProvince(String spotProvince) {
		this.spotProvince = spotProvince;
	}

	public void setSpotTitle(String spotTitle) {
		this.spotTitle = spotTitle;
	}

	public void setSpotDetailURL(String spotDetailURL) {
		this.spotDetailURL = spotDetailURL;
	}

	public void setSpotReadCnt(int spotReadCnt) {
		this.spotReadCnt = spotReadCnt;
	}
	
	///toString
	@Override
	public String toString() {
		return "Spot [spotNo=" + spotNo + ", spotCode=" + spotCode + ", spotTitle=" + spotTitle + ", spotPhone="
				+ spotPhone + ", spotAddress=" + spotAddress + ", spotDetail=" + spotDetail + ", spotX=" + spotX
				+ ", spotY=" + spotY + ", spotImg=" + spotImg + ", spotCreateTime=" + spotCreateTime
				+ ", spotModifyTime=" + spotModifyTime + ", spotProvince=" + spotProvince + ", spotDetailURL="
				+ spotDetailURL + ", spotReadCnt=" + spotReadCnt + "]";
	}

}
