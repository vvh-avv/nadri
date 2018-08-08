package com.nadri.service.domain;

import java.sql.Date;

public class User {
	
	///Field
	private String userId;							//유저 아이디
	private String userName;						//유저 이름
	private String password;						//비밀번호
	private String email;								//이메일
	private String profileImg;						//프로필 사진
	private String sex;									//성별(0: 남, 1: 여)
	//////////////////////////////////////////////////////////////////
	private String phone;							//휴대전화 번호
	private String phone1;							//전화번호 첫 번째 세 자리
	private String phone2;							//전화번호 두 번째 세 자리
	private String phone3;							//전화번호 세 번째 세 자리
	//////////////////////////////////////////////////////////////////
	private int age;										//나이
	private String introduce;						//자기소개
	private Date regDate;							//가입일
	private String role;								//역할(0: 유저, 1: 관리자)
	private Date lastLogin;							//마지막으로 로그인한 시간
	private String status;							//유저 상태(0: 정상, 1: 차단, 2: 탈퇴)
	private String ip;									//유저 아이피
	private String infoOption;					//검색시 정보 공개 여부(0: 공개, 1: 비공개)
	private Date quitDate;							//탈퇴일
	private String quitReason;					//탈퇴 사유
	
	private String token;							//알림받기 위해 토큰값 추가 //안드로이드
	
	
	///Constructor method
	public User(){
	}
	
	///Method
	public void setToken(String token) {
		this.token = token;
	}
	public String getToken() {
		return token;
	}
	public String getUserId() {
		return userId;
	}


	public void setUserId(String userId) {
		this.userId = userId;
	}


	public String getUserName() {
		return userName;
	}


	public void setUserName(String userName) {
		this.userName = userName;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getProfileImg() {
		return profileImg;
	}


	public void setProfileImg(String profileImg) {
		this.profileImg = profileImg;
	}


	public String getSex() {
		return sex;
	}


	public void setSex(String sex) {
		this.sex = sex;
	}
	
	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
		if(phone != null && phone.length()!=0){
			phone1 = phone.split("-")[0];
			phone2 = phone.split("-")[1];
			phone3 = phone.split("-")[2];
		}
	}

	public String getPhone1() {
		return phone1;
	}


	public void setPhone1(String phone1) {
		this.phone1 = phone1;
	}


	public String getPhone2() {
		return phone2;
	}


	public void setPhone2(String phone2) {
		this.phone2 = phone2;
	}


	public String getPhone3() {
		return phone3;
	}


	public void setPhone3(String phone3) {
		this.phone3 = phone3;
	}


	public int getAge() {
		return age;
	}


	public void setAge(int age) {
		this.age = age;
	}


	public String getIntroduce() {
		return introduce;
	}


	public void setIntroduce(String introduce) {
		this.introduce = introduce;
	}


	public Date getRegDate() {
		return regDate;
	}


	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}


	public String getRole() {
		return role;
	}


	public void setRole(String role) {
		this.role = role;
	}


	public Date getLastLogin() {
		return lastLogin;
	}


	public void setLastLogin(Date lastLogin) {
		this.lastLogin = lastLogin;
	}


	public String getStatus() {
		return status;
	}


	public void setStatus(String status) {
		this.status = status;
	}


	public String getIp() {
		return ip;
	}


	public void setIp(String ip) {
		this.ip = ip;
	}


	public String getInfoOption() {
		return infoOption;
	}


	public void setInfoOption(String infoOption) {
		this.infoOption = infoOption;
	}


	public Date getQuitDate() {
		return quitDate;
	}


	public void setQuitDate(Date quitDate) {
		this.quitDate = quitDate;
	}


	public String getQuitReason() {
		return quitReason;
	}


	public void setQuitReason(String quitReason) {
		this.quitReason = quitReason;
	}

	@Override
	public String toString() {
		return "User [userId=" + userId + ", userName=" + userName + ", password=" + password + ", email=" + email
				+ ", profileImg=" + profileImg + ", sex=" + sex + ", phone=" + phone + ", phone1=" + phone1
				+ ", phone2=" + phone2 + ", phone3=" + phone3 + ", age=" + age + ", introduce=" + introduce
				+ ", regDate=" + regDate + ", role=" + role + ", lastLogin=" + lastLogin + ", status=" + status
				+ ", ip=" + ip + ", infoOption=" + infoOption + ", quitDate=" + quitDate + ", quitReason=" + quitReason
				+ ", token="+token+"]";
	}
	
}