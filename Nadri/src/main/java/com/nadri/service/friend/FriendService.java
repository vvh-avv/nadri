package com.nadri.service.friend;

import java.util.List;
import org.springframework.web.bind.annotation.PathVariable;

import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;

public interface FriendService {
	
	//친구 요청 수락
	public int acceptFriend(Friend friend) throws Exception;
	/*public int acceptFriend(String userId, String friendId)throws Exception;*/
	
	//친구 삭제
	public int deleteFriend(String userId, String friendId) throws Exception;
		
	//친구 요청시
	public void addFriend(String userId, String friendId) throws Exception;
	
	//친구 요청 취소
	public int cancelFriend(String userId, String friendId) throws Exception;
	
	//친구 요청 거절
	public int refuseFriend(String userId, String friendId) throws Exception;

	//멤버의 친구 목록
	public List<Friend> searchFriend(String userId, String searchUserId)throws Exception;	

	public List<Friend> listFriend(String userId) throws Exception;

	//친구 정보 조회
	public Friend getFriend(String friendId) throws Exception;
	
	
	
	//하지수 테스트
   public String listFriendFromBoard(@PathVariable String userId) throws Exception;
   
   public int checkFriend(String userId, String friendId, int friendCode) throws Exception;

   
   
  

   










   
}
