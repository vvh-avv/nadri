package com.nadri.service.friend.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

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
	//模备 眠啊
	/*@Override
	public int acceptFriend(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("--------------------------DaoImpl - acceptFriend---------------------------");
		System.out.println("DaoImpl - acceptFriend start"+map);
		System.out.println("acceptFriend processing: "+sqlSession.insert("FriendMapper.acceptFriend", map));
		return sqlSession.insert("FriendMapper.acceptFriend", map);
	}*/
	
	@Override
	public int acceptFriend(Friend friend) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("--------------------------DaoImpl - acceptFriend---------------------------");
		System.out.println("DaoImpl - acceptFriend start"+friend);
		System.out.println("acceptFriend processing: "+sqlSession.insert("FriendMapper.acceptFriend", friend));
		//return sqlSession.insert("FriendMapper.acceptFriend", friend);
		if(sqlSession.update("FriendMapper.acceptFriend", friend) == 0) {
			return sqlSession.insert("FriendMapper.acceptFriend", friend);
		}
		return 1;
	}

	//模备 昏力
	@Override
	public int deleteFriend(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("--------------------------DaoImpl - deleteFriend---------------------------");
		System.out.println("deleteFriend start");	
		System.out.println("deleteFriend start: "+ map);

		System.out.println("deleteFriend processing: "+sqlSession.delete("FriendMapper.deleteFriend", map));
	
		
		return sqlSession.delete("FriendMapper.deleteFriend", map);
	}

	//模备 夸没 秒家
	@Override
	public int cancelFriend(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("FriendMapper.cancelFriend", map);
	}

	//模备 夸没
	@Override
	public void addFriend(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub

		sqlSession.insert("FriendMapper.addFriend", map);
	}
	
	

	//模备 夸没 芭例
	@Override
	public int refuseFriend(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.delete("FriendMapper.refuseFriend", map);
	}
	
	//模备 府胶飘
	@Override
	public List<Friend> listFriend(@PathVariable String userId) throws Exception {
		// TODO Auto-generated method stub
		System.out.println("-------------------------------------DaoImpl---------------------------------------");
		List<Friend> friend = sqlSession.selectList("FriendMapper.listFriendFromBoard", userId);
		List<String> friendId = new ArrayList<String>();
		
		for(int i = 0; i<friend.size(); i++) {
			friendId.add(friend.get(i).getFriendId());
		}
		
		System.out.println("friendDaoImpl: "+sqlSession.selectList("FriendMapper.listFriend", userId));
		return sqlSession.selectList("FriendMapper.listFriend", userId);
	}
	
	@Override
	public List<Friend> listFriend2(@PathVariable String userId) throws Exception {
		// TODO Auto-generated method stub

		System.out.println("-------------------------------------DaoImpl2---------------------------------------");
		List<Friend> friend = sqlSession.selectList("FriendMapper.listFriend2", userId);
		List<String> friendId = new ArrayList<String>();
		
		for(int i = 0; i<friend.size(); i++) {
			friendId.add(friend.get(i).getFriendId());
		}
		
		System.out.println("friendDaoImpl2: "+sqlSession.selectList("FriendMapper.listFriend2", userId));
		return sqlSession.selectList("FriendMapper.listFriend2", userId);
	}
	

	//模备 沥焊 炼雀
	@Override
	public Friend getFriend(String friendId) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("FriendMapper.getFriend", friendId);
	}	

	
	@Override
	public List<Friend> searchFriend(Map<String, String> map) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectList("FriendMapper.searchFriend", map);
	}
	
	 @Override
	   public List<Friend> selectFriendList(User user) throws Exception {
	      // TODO Auto-generated method stub
	      return sqlSession.selectList("FriendMapper.selectFriendList", user);
	   }

	//窍瘤荐 抛胶飘
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
	   
	 //模备 咯何 犬牢
      @Override
      public int checkFriend(String userId, String friendId, int status) throws Exception {
         // TODO Auto-generated method stub
         Map<String, Object> map = new HashMap<String, Object>();
         map.put("userId", userId);
         map.put("friendId", friendId);
         map.put("friendCode", status);
                  
         return sqlSession.selectOne("FriendMapper.checkFriend", map);
      }
	      
	      

    
}
