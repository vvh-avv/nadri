package com.nadri.service.friend.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

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
	}


	//method
	//模备 肝扁
	@Override
	public void addFriend(Friend friend, String status) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("FriendMapper - AddFriend: "+friend);
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("friend", friend);
		map.put("status", status);
		
		sqlSession.insert("FriendMapper.addFriend", map);
	}

	
	//模备 夸没, 脚没
	@Override
	public void acceptFriend(Friend friend) throws Exception {
		// TODO Auto-generated method stub
	}

	
	@Override
	public void deleteFriend(String friendId) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.delete("FriendMapper.deleteFriend",friendId);
	}


	@Override
	public List<Friend> listFriend(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FriendMapper.listFriend",search);
	}


	@Override
	public boolean blockFriend(Friend friendId) throws Exception {
		// TODO Auto-generated method stub
		return false;
	}


	@Override
	public Friend getFriend(String friendId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FriendMapper.getFriend", friendId);
	}


	@Override
	public Friend updateFriend(Friend status) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	@Override
	public int getTotalCount(Search search) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FriendMapper.getTotalCount", search);
	}


	@Override
	public void enterFriend(Friend friend) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.insert("FriendMapper.enterFriend", friend);
	}


	@Override
	public int checkFriend(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
		
		return sqlSession.selectOne("FriendMapper.checkFriend", map);
	}


	@Override
	public void cancelFriend(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
				
		sqlSession.delete("FriendMapper.cancelFriend", map);
	}


	@Override
	public void updateStatus(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
		
		sqlSession.update("FriendMapper.updateStatus", map);
	}


	@Override
	public int checkFollow(String userId, String friendId, int status) throws Exception {
		// TODO Auto-generated method stub
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("userId", userId);
		map.put("friendId", friendId);
		map.put("status", status);
		
		return sqlSession.selectOne("FriendMapper.checkFollow", map);
	}


	@Override
	public List countFriend(String userId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FriendMapper.countFriend", userId);
	}

	




	

}
