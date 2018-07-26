package com.nadri.service.chatroom;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.ChatRoom;

public interface ChatRoomService {

	public int addChatRoom(ChatRoom chatRoom) throws Exception ;
	
	public List<ChatRoom> getChatRoomList(Search search , String userId) throws Exception ;
	
	public ChatRoom getChatRoom(int chatroomNo) throws Exception ;
	
	public ChatRoom getChatRoom2(String userId1 , String userId2) throws Exception ;
	
	public int getTotalCount( int chatNo ) throws Exception ;	
	
}
