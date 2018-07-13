package com.nadri.service.domain;

public class Inquire {
	

	private int inquireNo;
	private String inquireCode;
	private String userId;
	private String reportUserId;
	private String inquireChkCode;
	private String inquireTitle;
	private String inquireWrite;
	private String inquireLink;
	private String inquireFile1;
	private String inquireFile2;
	private String inquireFile3;
	private String inquireTime;
	
	public Inquire() {
		super();
		// TODO Auto-generated constructor stub
	}
	
	@Override
	public String toString() {
		return "Inquire [inquireNo=" + inquireNo + ", inquireCode=" + inquireCode + ", userId=" + userId
				+ ", reportUserId=" + reportUserId + ", inquireChkCode=" + inquireChkCode + ", inquireTitle="
				+ inquireTitle + ", inquireWrite=" + inquireWrite + ", inquireLink=" + inquireLink + ", inquireFile1="
				+ inquireFile1 + ", inquireFile2=" + inquireFile2 + ", inquireFile3=" + inquireFile3 + ", inquireTime="
				+ inquireTime + "]";
	}

	public String getInquireCode() {
		return inquireCode;
	}
	public void setInquireCode(String inquireCode) {
		this.inquireCode = inquireCode;
	}
	
	public String getInquireTitle() {
		return inquireTitle;
	}
	public void setInquireTitle(String inquireTitle) {
		this.inquireTitle = inquireTitle;
	}
	public String getInquireWrite() {
		return inquireWrite;
	}
	public void setInquireWrite(String inquireWrite) {
		this.inquireWrite = inquireWrite;
	}
	public String getInquireFile1() {
		return inquireFile1;
	}
	public void setInquireFile1(String inquireFile1) {
		this.inquireFile1 = inquireFile1;
	}
	public String getInquireFile2() {
		return inquireFile2;
	}
	
	public void setInquireFile2(String inquireFile2) {
		this.inquireFile2 = inquireFile2;
	}


	public String getReportUserId() {
		return reportUserId;
	}

	public void setReportUserId(String reportUserId) {
		this.reportUserId = reportUserId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getInquireChkCode() {
		return inquireChkCode;
	}

	public void setInquireChkCode(String inquireChkCode) {
		this.inquireChkCode = inquireChkCode;
	}



	public String getInquireFile3() {
		return inquireFile3;
	}



	public void setInquireFile3(String inquireFile3) {
		this.inquireFile3 = inquireFile3;
	}



	public String getInquireTime() {
		return inquireTime;
	}



	public void setInquireTime(String inquireTime) {
		this.inquireTime = inquireTime;
	}



	public String getInquireLink() {
		return inquireLink;
	}



	public void setInquireLink(String inquireLink) {
		this.inquireLink = inquireLink;
	}

	public int getInquireNo() {
		return inquireNo;
	}

	public void setInquireNo(int inquireNo) {
		this.inquireNo = inquireNo;
	}
	
	

}
