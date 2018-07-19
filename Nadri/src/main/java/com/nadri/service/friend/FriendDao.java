package com.nadri.service.friend;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;

public interface FriendDao {

	//模备肝扁
	public void addFriend(Friend friend, String status) throws Exception;
	
	//模备夸没,模备脚没
	public void acceptFriend(Friend friend) throws Exception;
	
	//模备谗扁
	public void deleteFriend(String friendId) throws Exception;
	
	//模备格废
	public List<Friend> listFriend(Search search) throws Exception;
	
	//模备瞒窜
	public boolean blockFriend(Friend friendId) throws Exception;
	
	//模备炼雀
	public Friend getFriend(String friendId) throws Exception;
	
	//status惑怕 诀单捞飘
	public Friend updateFriend(Friend status) throws Exception;
	
	//totalCount
	public int getTotalCount(Search search) throws Exception;

	//
	public void enterFriend(Friend friend)throws Exception;
	
	//
	public int checkFriend(String userId, String friendId, int status) throws Exception;
	
	//
	public void cancelFriend(String userId, String friendId, int status) throws Exception;
	
	//
	public void updateStatus(String userId, String friendId, int status) throws Exception;
	
	//
	public int checkFollow(String userId, String friendId, int status) throws Exception;

	//
	public List countFriend(String userId) throws Exception;


}
