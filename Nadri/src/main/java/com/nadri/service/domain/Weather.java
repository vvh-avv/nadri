package com.nadri.service.domain;

import java.sql.Timestamp;

public class Weather {
	
	private int weatherCode;
	private String weatherName;
	private Timestamp weatherTime;
	private int weatherNo;
	
	@Override
	public String toString() {
		return "Weather [weatherCode=" + weatherCode + ", weatherName=" + weatherName + ", weatherTime=" + weatherTime
				+ ", weatherNo=" + weatherNo + "]";
	}
	
	public int getWeatherCode() {
		return weatherCode;
	}
	
	public void setWeatherCode(int weatherCode) {
		this.weatherCode = weatherCode;
	}
	
	public String getWeatherName() {
		return weatherName;
	}
	
	public void setWeatherName(String weatherName) {
		this.weatherName = weatherName;
	}
	
	public Timestamp getWeatherTime() {
		return weatherTime;
	}
	
	public void setWeatherTime(Timestamp weatherTime) {
		this.weatherTime = weatherTime;
	}
	
	public int getWeatherNo() {
		return weatherNo;
	}
	
	public void setWeatherNo(int weatherNo) {
		this.weatherNo = weatherNo;
	}
	
	

}
