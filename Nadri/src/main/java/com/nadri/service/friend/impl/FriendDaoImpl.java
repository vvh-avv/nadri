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

import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;
import com.nadri.service.friend.FriendDao;


@Repository("friendDaoImpl")
public class FriendDaoImpl implements FriendDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	
	public FriendDaoImpl() {
		System.out.println(this.getClass());
	}
	
	//method
	//친구 추가
	@Override
	public int addFriend(List<Map<String, String>> list) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("friend.addFriend", list);
	}

	//친구 삭제
	@Override
	public int deleteFriend(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("friend.deleteFriend", map);
	}

	//친구 요청 취소
	@Override
	public int cancelFriend(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("friend.cancelFriend", map);
	}

	//친구 요청
	@Override
	public int createFriend(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.insert("friend.createFriend", map);
	}

	//친구 요청 거절
	@Override
	public int refuseFriend(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("friend.refuseFriend", map);
	}
	
	//사용자 아이디와 검색할 아이디를 이용, 유저 목록 리턴
	@Override
	public List<Friend> searchFriend(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("friend.searchFriend", map);
	}
	
	@Override
	public List<Friend> selectFriendList(User user) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("friend.selectFriendList", user);
	}
		


	//하지수 테스트
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
	   
	 //친구 여부 확인
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

	

	

	

	   
	
}
