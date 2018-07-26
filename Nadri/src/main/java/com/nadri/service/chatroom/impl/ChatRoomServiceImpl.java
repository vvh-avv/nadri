package com.nadri.service.chatroom.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.chatroom.ChatRoomDao;
import com.nadri.service.chatroom.ChatRoomService;
import com.nadri.service.domain.ChatRoom;

@Service("chatRoomServiceImpl")
public class ChatRoomServiceImpl implements ChatRoomService{
	@Autowired
	@Qualifier("chatRoomDaoImpl")
	ChatRoomDao chatRoomDao = new ChatRoomDaoImpl() ;
	
	public ChatRoomServiceImpl() {
		
	}
	
	public ChatRoomServiceImpl(ChatRoomDaoImpl chatRoomDao) {
		this.chatRoomDao = chatRoomDao ;
	}
	
	public ChatRoomDao getChatDao() {
		return chatRoomDao ;
	}

	@Override
	public int addChatRoom(ChatRoom chatRoom) throws Exception {
		// TODO Auto-generated method stub
		return chatRoomDao.addChatRoom(chatRoom) ;
	}

	@Override
	public List<ChatRoom> getChatRoomList(Search search, String userId) throws Exception {
		// TODO Auto-generated method stub
		return chatRoomDao.getChatRoomList(search, userId) ;
	}

	@Override
	public int getTotalCount(int chatNo) throws Exception {
		// TODO Auto-generated method stub
		return 0;
	}
	
	@Override
	public ChatRoom getChatRoom(int chatRoomNo) throws Exception {
		ChatRoom chatRoom = chatRoomDao.getChatRoom(chatRoomNo) ; 
		return chatRoom ;
	}
	
	@Override
	public ChatRoom getChatRoom2(String userId1 , String userId2) throws Exception {	
		return chatRoomDao.getChatRoom2(userId1, userId2) ; 
	}
}
