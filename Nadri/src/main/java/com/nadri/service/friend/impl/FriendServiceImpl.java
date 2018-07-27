package com.nadri.service.friend.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.service.domain.Friend;
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
	//模备 格废
	@Override
	public List<Friend> listFriend(String userId) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("-------------------------------------ServiceImpl-------------------------------------");
		System.out.println("serviceImpl-listFriend-userId: "+ userId);
		return friendDao.listFriend(userId);
	}
	

	//模备 夸没 荐遏
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
	

	//模备 昏力
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

	//模备 夸没
	@Override
	public void addFriend(String userId, String friendId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		friendDao.addFriend(map);
	}

	
	//模备 夸没 秒家
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
	

	//模备 夸没 芭例
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

	//模备 沥焊 炼雀
	@Override
	public Friend getFriend(String friendId) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("----------------------------------------------------");
		System.out.println("serviceimpl - getFriend: "+friendDao.getFriend(friendId));
		System.out.println("----------------------------------------------------");
		return friendDao.getFriend(friendId);
	}
	

	

	
	//窍瘤荐 抛胶飘
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

	//糕滚狼 模备 格废
	@Override
	public List<Friend> searchFriend(String userId, String searchUserId) throws Exception {
		// TODO Auto-generated method stub
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("searchUserId", searchUserId);
		
		return friendDao.searchFriend(map);
	}

	

	

	

	

	

	

	
	
	

}
