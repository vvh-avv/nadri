package com.nadri.service.friend;

import java.util.List;
import java.util.Map;

import org.springframework.web.bind.annotation.PathVariable;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;

public interface FriendService {

	////하지수 테스트
	public String listFriendFromBoard(@PathVariable String userId) throws Exception;
	
	//친구 맺기
	public void addFriend(Friend friend, String status) throws Exception;
	
	//친구 리스트
	public Map<String, Object> listFriend(Search search) throws Exception;
	
	//친구 요청, 신청
	public Map<String , Object > acceptFriend(Search search) throws Exception;
	
	//친구추천(알수도있는친구)
	public List<Friend> recommendFriend(String userId) throws Exception;

	//친구 조회(확인)
	public Friend getFriend (String friendId) throws Exception;
	
	//친구 코드 업데이트
	public void updateFriend(Friend friend) throws Exception;

	//친구 끊기
	public void deleteFreind(String friendId )throws Exception;
	
	//친구 승인
	public void  enterFriend(Friend friend) throws Exception;

	//친구 여부 확인
	public int checkFriend(String userId, String friendId, int status) throws Exception;
	
	//친구 신청 취소
	public void cancelFriend(String userId, String friendId, int status) throws Exception;

	//상태 업데이트
	public void updateStatus(String userId, String friendId, int status) throws Exception;
	
	//follow 확인
	public int checkFollow(String userId, String friendId, int status) throws Exception;

	//친구 총 수 확인
	public List countFriend(String userId) throws Exception;

	
}
