package com.nadri.service.friend.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
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
	//模备 格废
	@Override
	public List<Friend> selectFriendList(User user) throws Exception {
		// TODO Auto-generated method stub
		return friendDao.selectFriendList(user);
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
	

	//模备 夸没 荐遏
	@Override
	public int acceptFriend(String userId, String friendId) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		List<Map<String, String>> list = new ArrayList<Map<String, String>>();
		
			Map<String, String> map1 = new HashMap<String, String>();
			map1.put("userId", userId);
			map1.put("friendId", friendId);
			friendDao.deleteFriend(map1);
			
			Map<String, String> map2 = new HashMap<String, String>();
			map2.put("userId", userId);
			map2.put("friendId", friendId);
			
			list.add(map1);
			list.add(map2);
			
			result = friendDao.acceptFriend(list);
					
			return result;
	}

	//模备 昏力
	@Override
	public int deleteFriend(String userId, String friendId) throws Exception {
		// TODO Auto-generated method stub
		int result = 0;
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		result = friendDao.deleteFriend(map);
		
		return result;
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

	

	

	
	
	

}
