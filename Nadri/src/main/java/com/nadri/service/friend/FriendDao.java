package com.nadri.service.friend;

import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;

public interface FriendDao {

	////하지수 테스트
	public String listFriendFromBoard(@PathVariable String userId) throws Exception;
	
	//친구 맺기
	public void addFriend(Friend friend, String status) throws Exception;
	
	//친구요청,친구신청
	public void acceptFriend(Friend friend) throws Exception;
	
	//친구 추천
	public List<Friend> recommendFriend(String userId) throws Exception;
	
	//친구 끊기
	public void deleteFriend(String friendId) throws Exception;
	
	//친구 목록
	public List<Friend> listFriend(Search search) throws Exception;
	
	//친구 차단
	public boolean blockFriend(Friend friendId) throws Exception;
	
	//친구 조회
	public Friend getFriend(String friendId) throws Exception;
	
	//친구 코드 업데이트
	public Friend updateFriend(Friend status) throws Exception;
	
	//친구 총 수 얻어오기
	public int getTotalCount(Search search) throws Exception;

	//친구 승인
	public void enterFriend(Friend friend)throws Exception;
	
	//친구 확인
	public int checkFriend(String userId, String friendId, int status) throws Exception;
	
	//친구 신청 취소
	public void cancelFriend(String userId, String friendId, int status) throws Exception;
	
	//친구 상태 변경
	public void updateStatus(String userId, String friendId, int status) throws Exception;
	
	//follow 확인
	public int checkFollow(String userId, String friendId, int status) throws Exception;

	//친구 총 수
	public List countFriend(String userId) throws Exception;


}
