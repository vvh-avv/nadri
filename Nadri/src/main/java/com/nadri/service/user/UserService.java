package com.nadri.service.user;

import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.User;

public interface UserService {
	
	//회원가입
	public void addUser(User user) throws Exception;
	
	//내 정보 확인
	public User getUser(String userId) throws Exception;
	
	//회원 정보 리스트
	public Map<String, Object> getUserList(Search search) throws Exception;
	
	//회원 정보 수정
	public void updateUser(User user) throws Exception;
	
	//회원 ID 중복 수정
	public boolean checkDuplication(String userId) throws Exception;

	//회원탈퇴
	public void quitUser(String userId) throws Exception;
	
	//아이디 찾기
	public User findUserId(User user) throws Exception;
	
	//비밀번호 찾기
	public boolean findPassword(String email, String userId) throws Exception;
	
	
	//보상 리스트 
	public Map<String, Object> getRewardList(Search search) throws Exception;
	
	//게시물 리스트
	public Map<String, Object> getBoardList(Search search) throws Exception;
	
	//스케줄 리스트
	public Map<String, Object> getScheduleList(Search search) throws Exception;
	
	//카트(바구니) 리스트
	public Map<String, Object> getCartList(Search search) throws Exception;
	
	//신고 내역 확인 리스트
	public Map<String, Object> getUserReportList(Search search) throws Exception;

	
	/*//이메일 인증 키 검증
	public void userAuth(String email) throws Exception; */

	//이메일 관련: 상태 변화
	public void updateStatusCode(User user) throws Exception;

	//카카오 로그인
	public User getCode(String authorize_code) throws Exception;

	//아이디 중복체크
	public boolean checkUserId(String userId) throws Exception;
	
	//회원 활동 불러오기
	public Map<String,Object> getUserLog(String userId,int number,String duration);

	
}