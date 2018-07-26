package com.nadri.service.chatroom.test;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
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
import com.nadri.service.domain.User;
import com.nadri.service.user.UserService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-common.xml", "classpath:config/context-aspect.xml",
												"classpath:config/context-mybatis.xml", "classpath:config/context-transaction.xml" })
public class ChatRoomServiceTest {
	@Autowired
	@Qualifier("chatRoomServiceImpl")
	ChatRoomService chatRoomService ; 
	
	@Autowired
	@Qualifier("userServiceImpl")
	UserService userService ; 
	
	
	
	//@Test
	public void addChatRoom() throws Exception {
		ChatRoom chatRoom = new ChatRoom() ;
		chatRoom.setUserId("user01,user02,user03,user04,user05,user06");
		chatRoomService.addChatRoom(chatRoom) ;
	}
	
	@Test
	public void  chatRoomList() throws Exception {
		Search search = new Search() ;
		ArrayList<ChatRoom>list = (ArrayList<ChatRoom>) chatRoomService.getChatRoomList(search, "user01") ;
		System.out.println(list.size());
		
//		for(int i = 0 ; i < list.size() ; i++) {
//			for(int j = i  ; j < list.size() ; j++) {
//				if( list.get(i).getChatRoomNo() == list.get(j).getChatRoomNo() ) {
//					if( list.get(i).getUserProfileImg().split(",").length >= 4 ) {
//						list.remove(j) ;
//						break ;
//					} else {
//						list.get(i).setUserProfileImg( list.get(i).getUserProfileImg() + "," + list.get(j).getUserProfileImg() ) ;
//						list.remove(j) ;
//					}
//				}
//			}
//		}
//		
		for(ChatRoom i : list) {
			System.out.println("i : " + i ) ;
		}
		
//		List<User> userId = new ArrayList<User>() ;
//		String[] temp ;
//		for(ChatRoom i : list) {
//			temp = i.getUserId().split(",") ;
//			
//			
//			for(int j = 0 ; j < temp.length ; j++) {
//				User user = new User() ;
//				user.setUserId( temp[j] ) ;
//				userId.add(user) ;
//			}
//			System.out.println( i ) ;
//		}
		
		
		
//		userId.add(i.getUserId())
		
//		userService.get
		
		
	}
	
	//@Test
	public void  getChatRoom() throws Exception {
		ChatRoom chatRoom = chatRoomService.getChatRoom2("user01" , "user02") ;

		System.out.println( chatRoom ) ;
	}
}









