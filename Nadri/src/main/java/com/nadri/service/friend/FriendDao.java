package com.nadri.service.friend;

import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;

public interface FriendDao {
	
	//模备 眠啊
	public int acceptFriend(Friend friend) throws Exception;
	/*public int acceptFriend(Map<String, String> map) throws Exception;*/
	
	//模备 昏力
	public  int deleteFriend(Map<String, String> map)throws Exception;
	
	//模备 夸没 秒家
	public int cancelFriend(Map<String, String> map)throws Exception;
	
	//模备 夸没
	public void addFriend(Map<String, String> map) throws Exception;
	
	//模备 夸没 芭例
	public int refuseFriend(Map<String, String> map) throws Exception;
	
	//模备 府胶飘
	//public List<Friend> listFriend(String userId)throws Exception;

	public List<Friend> listFriend(String userId) throws Exception;

	//模备 沥焊 炼雀
	public Friend getFriend(String friendId)throws Exception;
	
	
	public List<Friend> searchFriend(Map<String, String> map)throws Exception;

	
	//窍瘤荐 抛胶飘
	public String listFriendFromBoard(String userId) throws Exception;

	//模备 咯何 犬牢
	public int checkFriend(String userId, String friendId, int status) throws Exception;


	
		
	
	public List<Friend> selectFriendList(User user) throws Exception;



}
