package com.nadri.service.friend;

import java.util.List;
import java.util.Map;

import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;

public interface FriendDao {
	
	//친구 추가
	public int addFriend(List<Map<String, String>> list) throws Exception;
	
	//친구 삭제
	public int deleteFriend(Map<String, String> list)throws Exception;
	
	//친구 요청 취소
	public int cancelFriend(Map<String, String> map)throws Exception;
	
	//친구 요청
	public int createFriend(Map<String, String> map) throws Exception;
	
	//친구 요청 거절
	public int refuseFriend(Map<String, String> map) throws Exception;
	
	//사용자 아이디와 검색할 아이디를 이용하여 유저 목록 리턴
	public List<Friend> searchFriend(Map<String, String> map)throws Exception;

	public List<Friend> selectFriendList(User user)throws Exception;

	
	//하지수 테스트
	public String listFriendFromBoard(String userId) throws Exception;

	//친구 여부 확인
	public int checkFriend(String userId, String friendId, int status) throws Exception;



}
