package com.nadri.service.friend.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;
import com.nadri.service.friend.FriendDao;
import com.nadri.service.friend.FriendService;

@Service("friendServiceImpl")
public class FriendServiceImpl implements FriendService{
	
	@Autowired
	@Qualifier("friendDaoImpl")
	private FriendDao friendDao;
	
	
	public FriendServiceImpl() {
		
	}
	
	//method
	//친구 목록
	@Override
	public List<Friend> listFriend(String userId) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("-------------------------------------ServiceImpl-------------------------------------");
		System.out.println("serviceImpl-listFriend-userId: "+ userId);
		return friendDao.listFriend(userId);
	}
	
	@Override
	public List<Friend> listFriend2(String userId) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("-------------------------------------ServiceImpl2-------------------------------------");
		System.out.println("serviceImpl-listFriend2-userId: "+ userId);
		System.out.println("serviceImpl-listFriend2-dao로 넘길 유저 아이디 값: "+friendDao.listFriend2(userId));
		return friendDao.listFriend2(userId);
	}
	

	//친구 요청 수락
	/*@Override
	public int acceptFriend(String userId, String friendId) throws Exception {
		// TODO Auto-generated method stub
			System.out.println("---------------ServiceImpl - acceptFriend------------");
			System.out.println("serviceimpl - acceptFriend - userId: "+userId);
			System.out.println("serviceimpl - acceptFriend - friendId: "+friendId);
			System.out.println("---------------acceptFriend------------");
			Map<String, String> map = new HashMap<String, String>();
			map.put("userId", userId);
			map.put("friendId", friendId);
			return friendDao.acceptFriend(map);
	}*/
	
	@Override
	public int acceptFriend(Friend friend) throws Exception {
		// TODO Auto-generated method stub
			System.out.println("---------------ServiceImpl - acceptFriend------------");
			System.out.println("serviceimpl - acceptFriend : "+friend);
			System.out.println("---------------acceptFriend------------");

			return friendDao.acceptFriend(friend);
	}
	

	//친구 삭제
	@Override
	public int deleteFriend(String userId, String friendId) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("---------------ServiceImpl - deleteFriend------------");
		System.out.println(friendId);
		System.out.println(userId);
		System.out.println("---------------deleteFriend------------");
		
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		
		return friendDao.deleteFriend(map);
	}

	//친구 요청
	@Override
	public void addFriend(String userId, String friendId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		friendDao.addFriend(map);
	}

	
	//친구 요청 취소
	@Override
	public int cancelFriend(String userId, String friendId) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		result = friendDao.cancelFriend(map);
		
		return result;
	}
	

	//친구 요청 거절
	@Override
	public int refuseFriend(String userId, String friendId) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		result = friendDao.refuseFriend(map);
		
		return result; 
	}

	//친구 정보 조회
	@Override
	public Friend getFriend(String friendId) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("----------------------------------------------------");
		System.out.println("serviceimpl - getFriend: "+friendDao.getFriend(friendId));
		System.out.println("----------------------------------------------------");
		return friendDao.getFriend(friendId);
	}

	
	//하지수 테스트
		@Override
		public String listFriendFromBoard(String userId) throws Exception {
			// TODO Auto-generated method stub
			return friendDao.listFriendFromBoard(userId);
		}

	
	@Override
	public int checkFriend(String userId, String friendId, int friendCode) throws Exception {
		// TODO Auto-generated method stub
		return friendDao.checkFriend(userId, friendId, friendCode);
	}

	//멤버의 친구 목록
	@Override
	public List<Friend> searchFriend(String userId, String searchUserId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("searchUserId", searchUserId);
		
		return friendDao.searchFriend(map);
	}

	

	


}
