package com.nadri.service.user;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.User;

public interface UserDao {

	// 회원가입
	public void addUser(User user) throws Exception ;

	// 회원 조회
	public User getUser(String userId) throws Exception ;

	// 회원 목록
	public List<User> getUserList(Search search) throws Exception ;

	// 회원정보수정
	public void updateUser(User user) throws Exception ;
	
	// 회원 탈퇴
	public void quitUser(String userId) throws Exception;

	
	//아이디 찾기
	public User findUserId(User user) throws Exception;

	//비밀번호 찾기
	public void findUserPassword(User user) throws Exception;
	
	// 게시판 Page 처리를 위한 전체Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception ;
	
	//보상 목록
	public Map<String, Object> getRewardList(Search search) throws Exception;
	
	//게시물 목록
	public Map<String, Object> getBoardList(Search search) throws Exception;
	
	//스케줄 목록
	public Map<String, Object> getScheduleList(Search search) throws Exception;
	
	//일정바구니, 장소바구니 목록
	public Map<String, Object> getCartList(Search search) throws Exception;
	
	//유저 신고내역 목록
	public Map<String, Object> getUserReportList(Search search) throws Exception;
	

	
	////////////////////180712 예지 추가///////////////////////
	//회원 활동 불러오기
	public Map<String,Object> getUserLog(String userId,int number,String duration) ;

	

}