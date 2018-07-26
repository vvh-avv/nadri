package com.nadri.service.domain;

import java.math.BigDecimal;
import java.sql.Date;

public class Cart {

	/// Field
	private int cartNo;
	private int scheduleNo;
	private int spotNo;
	private String userId;
	private String cartCode;
	private String cartDetail;
	private String cartTitle;
	private String cartAddress;
	private BigDecimal cartX;
	private BigDecimal cartY;
	private String cartImg;
	private Date cartCreateTime;
	private int stampCode;
	
	///Constructor
	public Cart() {
	}
	
	///Method
	public int getCartNo() {
		return cartNo;
	}

	public int getScheduleNo() {
		return scheduleNo;
	}

	public int getSpotNo() {
		return spotNo;
	}

	public String getUserId() {
		return userId;
	}

	public String getCartCode() {
		return cartCode;
	}

	public String getCartDetail() {
		return cartDetail;
	}

	public String getCartTitle() {
		return cartTitle;
	}

	public String getCartAddress() {
		return cartAddress;
	}

	public BigDecimal getCartX() {
		return cartX;
	}

	public BigDecimal getCartY() {
		return cartY;
	}

	public String getCartImg() {
		return cartImg;
	}

	public Date getCartCreateTime() {
		return cartCreateTime;
	}

	public int getStampCode() {
		return stampCode;
	}

	public void setCartNo(int cartNo) {
		this.cartNo = cartNo;
	}

	public void setScheduleNo(int scheduleNo) {
		this.scheduleNo = scheduleNo;
	}

	public void setSpotNo(int spotNo) {
		this.spotNo = spotNo;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public void setCartCode(String cartCode) {
		this.cartCode = cartCode;
	}

	public void setCartDetail(String cartDetail) {
		this.cartDetail = cartDetail;
	}

	public void setCartTitle(String cartTitle) {
		this.cartTitle = cartTitle;
	}

	public void setCartAddress(String cartAddress) {
		this.cartAddress = cartAddress;
	}

	public void setCartX(BigDecimal cartX) {
		this.cartX = cartX;
	}

	public void setCartY(BigDecimal cartY) {
		this.cartY = cartY;
	}

	public void setCartImg(String cartImg) {
		this.cartImg = cartImg;
	}

	public void setCartCreateTime(Date cartCreateTime) {
		this.cartCreateTime = cartCreateTime;
	}

	public void setStampCode(int stampCode) {
		this.stampCode = stampCode;
	}
	
	///toString
	@Override
	public String toString() {
		return "Cart [cartNo=" + cartNo + ", scheduleNo=" + scheduleNo + ", spotNo=" + spotNo + ", userId=" + userId
				+ ", cartCode=" + cartCode + ", cartDetail=" + cartDetail + ", cartTitle=" + cartTitle
				+ ", cartAddress=" + cartAddress + ", cartX=" + cartX + ", cartY=" + cartY + ", cartImg=" + cartImg
				+ ", cartCreateTime=" + cartCreateTime + ", stampCode=" + stampCode + "]";
	}
}
