package com.nadri.service.chatroom.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nadri.common.Search;
import com.nadri.service.chatroom.ChatRoomService;
import com.nadri.service.domain.ChatRoom;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-common.xml", "classpath:config/context-aspect.xml",
												"classpath:config/context-mybatis.xml", "classpath:config/context-transaction.xml" })
public class ChatRoomServiceTest {
	@Autowired
	@Qualifier("chatRoomServiceImpl")
	ChatRoomService chatRoomService ; 
	
	//@Test
	public void addChatRoom() throws Exception {
		ChatRoom chatRoom = new ChatRoom() ;
		chatRoom.setUserId("user01,user02");
		chatRoom.setUserName("πŸµœ¿Ã,¡¶¥œ");
		chatRoomService.addChatRoom(chatRoom) ;
	}
	
	@Test
	public void  chatRoomList() throws Exception {
		Search search = new Search() ;
		ArrayList<ChatRoom>list = (ArrayList<ChatRoom>) chatRoomService.getChatRoomList(search, "user01") ;

		for(ChatRoom i : list) {
			System.out.println( i ) ;
		 } 
	}
}









