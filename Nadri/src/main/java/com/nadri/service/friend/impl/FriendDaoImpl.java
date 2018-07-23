package com.nadri.service.friend.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.codehaus.jackson.map.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.web.bind.annotation.PathVariable;

import com.nadri.common.Search;
import com.nadri.service.domain.Friend;
import com.nadri.service.friend.FriendDao;

@Repository("friendDaoImpl")
public class FriendDaoImpl implements FriendDao {

	//field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession (SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//constructor method
	public FriendDaoImpl() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	////窍瘤荐 抛胶飘
	@Override
	public String listFriendFromBoard(@PathVariable String userId) throws Exception{
		List<Friend> friend = sqlSession.selectList("FriendMapper.listFriendFromBoard", userId);
		List<String> friendId = new ArrayList<String>(); 
		
		for(int i=0; i<friend.size(); i++) {
			friendId.add(friend.get(i).getFriendId());
		}
		
		String json = new ObjectMapper().writeValueAsString( friendId );
		
		return json;
	}
	
	//method
	//模备 函版
	@Override
	public Friend updateFriend(Friend status) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//模备 犬牢
	@Override
	public Friend getFriend(String friendId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FriendMapper.getFriend", friendId);
	}
	
	//模备 肝扁(夸没)
	@Override
	public void addFriend(Friend friend, String status) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("FriendDaoImpl - AddFriend: "+friend);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("friend", friend);
		map.put("status", status);
		
		sqlSession.insert("FriendMapper.addFriend", map);
	}
	
	//模备 铰牢
	@Override
	public void enterFriend(Friend friend) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FriendMapper.enterFriend", friend);
	}
	
	//模备 夸没, 脚没
	@Override
	public void acceptFriend(Friend friend) throws Exception {
		// TODO Auto-generated method stub
	}
	
	//模备 眠玫
	@Override
	public List<Friend> recommendFriend(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FriendMapper.recommendFriend", userId);
	}
	
	//模备 谗扁
	@Override
	public void deleteFriend(String friendId) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("FriendMapper.deleteFriend",friendId);
	}
	
	//模备 府胶飘
	@Override
	public List<Friend> listFriend(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FriendMapper.listFriend",search);
	}

	//模备 瞒窜
	@Override
	public boolean blockFriend(Friend friendId) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}	

	//醚 模备 荐 技扁
	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FriendMapper.getTotalCount", search);
	}
	
	//模备 咯何 犬牢
	@Override
	public int checkFriend(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
		
		Integer returnValue = sqlSession.selectOne("FriendMapper.checkFriend", map);
		if(returnValue==null) { returnValue=0; }
		
		return returnValue;
	}

	//模备 脚没 秒家
	@Override
	public void cancelFriend(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
				
		sqlSession.delete("FriendMapper.cancelFriend", map);
	}

	//模备 内靛 函版
	@Override
	public void updateStatus(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
		
		sqlSession.update("FriendMapper.updateStatus", map);
	}


	//follow 犬牢
	@Override
	public int checkFollow(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
		
		return sqlSession.selectOne("FriendMapper.checkFollow", map);
	}

	//模备 荐 墨款飘
	@Override
	public List countFriend(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FriendMapper.countFriend", userId);
	}

	


}
