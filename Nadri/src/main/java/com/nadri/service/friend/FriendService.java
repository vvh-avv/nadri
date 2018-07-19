package com.nadri.service.friend;

import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;

public interface FriendService {
		
	//模备 肝扁
	public void addFriend(Friend friend, String status) throws Exception;
	
	//模备 府胶飘
	public Map<String, Object> listFriend(Search search) throws Exception;
	
	//模备 夸没, 脚没
	public Map<String , Object > acceptFriend(Search search) throws Exception;

	//模备炼雀
	public Friend getFriend (String friendId) throws Exception;
	
	//status 诀单捞飘
	public void updateFriend(Friend friend) throws Exception;

	//模备 昏力
	public void deleteFreind(String friendId )throws Exception;
	
	//
	public void  enterFriend(Friend friend) throws Exception;

	//
	public int checkFriend(String userId, String friendId, int status) throws Exception;
	
	//模备 谗扁
	public void cancelFriend(String userId, String friendId, int status) throws Exception;

	//惑怕 诀单捞飘
	public void updateStatus(String userId, String friendId, int status) throws Exception;
	
	//
	public int checkFollow(String userId, String friendId, int status) throws Exception;

	//
	public List countFriend(String userId) throws Exception;


	
}
