package com.nadri.service.friend;

import java.util.List;

import org.springframework.web.bind.annotation.PathVariable;

import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;

public interface FriendService {
	
	//模备 夸没 荐遏
	public int acceptFriend(String userId, String friendId) throws Exception;
	
	//模备 昏力
	public int deleteFriend(String userId, String friendId) throws Exception;
	
	//模备 夸没矫
	public int addFriend(String userId, String friendId) throws Exception;
	
	//模备 夸没 秒家
	public int cancelFriend(String userId, String friendId) throws Exception;
	
	//模备 夸没 芭例
	public int refuseFriend(String userId, String friendId) throws Exception;

	//糕滚狼 模备 格废
	public List<Friend> searchFriend(String userId, String searchUserId)throws Exception;	

	public List<Friend> selectFriendList(User user) throws Exception;
	
	
	//窍瘤荐 抛胶飘
   public String listFriendFromBoard(@PathVariable String userId) throws Exception;
   
   public int checkFriend(String userId, String friendId, int friendCode) throws Exception;


   
}
