package com.nadri.service.friend;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;

public interface FriendDao {

	//模备 肝扁
	public void addFriend(Friend friend, String status) throws Exception;
	
	//模备夸没,模备脚没
	public void acceptFriend(Friend friend) throws Exception;
	
	//模备 眠玫
	public List<Friend> recommendFriend(String userId) throws Exception;
	
	//模备 谗扁
	public void deleteFriend(String friendId) throws Exception;
	
	//模备 格废
	public List<Friend> listFriend(Search search) throws Exception;
	
	//模备 瞒窜
	public boolean blockFriend(Friend friendId) throws Exception;
	
	//模备 炼雀
	public Friend getFriend(String friendId) throws Exception;
	
	//模备 内靛 诀单捞飘
	public Friend updateFriend(Friend status) throws Exception;
	
	//模备 醚 荐 掘绢坷扁
	public int getTotalCount(Search search) throws Exception;

	//模备 铰牢
	public void enterFriend(Friend friend)throws Exception;
	
	//模备 犬牢
	public int checkFriend(String userId, String friendId, int status) throws Exception;
	
	//模备 脚没 秒家
	public void cancelFriend(String userId, String friendId, int status) throws Exception;
	
	//模备 惑怕 函版
	public void updateStatus(String userId, String friendId, int status) throws Exception;
	
	//follow 犬牢
	public int checkFollow(String userId, String friendId, int status) throws Exception;

	//模备 醚 荐
	public List countFriend(String userId) throws Exception;


}
