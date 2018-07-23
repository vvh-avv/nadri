package com.nadri.service.chatroom.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.chatroom.ChatRoomDao;
import com.nadri.service.domain.ChatRoom;


@Repository("chatRoomDaoImpl")
public class ChatRoomDaoImpl implements ChatRoomDao {

		@Autowired
		@Qualifier("sqlSessionTemplate")
		private SqlSession sqlSession ;
		
		public ChatRoomDaoImpl(SqlSession sqlSession) {
			this.sqlSession = sqlSession ;
			System.out.println(sqlSession.getClass());
		}
		
		public ChatRoomDaoImpl() {
			
		}
		
		public SqlSession getSqlSession() {
			return sqlSession;
		}

		public void setSqlSession(SqlSession sqlSession) {
			this.sqlSession = sqlSession;
		}

		@Override
		public int addChatRoom(ChatRoom chatRoom) throws Exception {
			// TODO Auto-generated method stub
			return sqlSession.insert("ChatRoomMapper.addChatRoom", chatRoom) ;
		}

		@Override
		public List<ChatRoom> getChatRoomList(Search search, String userId) throws Exception {
			// TODO Auto-generated method stub
			HashMap<String , Object> map = new HashMap<String , Object>() ;
			map.put("search", search) ;
			map.put("userId", userId) ;
			List<ChatRoom> list = sqlSession.selectList("ChatRoomMapper.chatRoomList" , map ) ;
			System.out.println("1");
			for(ChatRoom i : list) {
				System.out.println( i ) ;
			}
			return sqlSession.selectList("ChatRoomMapper.chatRoomList" , map ) ;
		}
		
		@Override
		public int getTotalCount(int chatNo) throws Exception {
			// TODO Auto-generated method stub
			return 0;
		}
		
		@Override
		public ChatRoom getChatRoom(int chatRoomNo) throws Exception {
			ChatRoom chatRoom = sqlSession.selectOne("ChatRoomMapper.getchatRoom", chatRoomNo) ; 
			return chatRoom ;
		}
		
		@Override
		public ChatRoom getChatRoom2(String userId1 , String userId2) throws Exception {
			HashMap<String , String> map = new HashMap<String , String>() ;
			map.put("userId1" , userId1) ;
			map.put("userId2" , userId2) ;
			ChatRoom chatRoom = sqlSession.selectOne("ChatRoomMapper.getchatRoom2", map) ;
			if ( chatRoom == null) {
				return  new ChatRoom() ;
			}
			return chatRoom ;
		}
}
