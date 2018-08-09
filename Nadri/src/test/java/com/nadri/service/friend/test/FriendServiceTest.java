package com.nadri.service.friend.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nadri.service.domain.Friend;
import com.nadri.service.friend.FriendService;
import com.nadri.service.friend.impl.FriendServiceImpl;

import junit.framework.Assert;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-common.xml", "classpath:config/context-aspect.xml",
                                    "classpath:config/context-mybatis.xml", "classpath:config/context-transaction.xml" })
public class FriendServiceTest {

   @Autowired 
   @Qualifier("friendServiceImpl")
   public FriendService friendService;
   
   //@Test
   public void friendList() throws Exception {
      List<Friend> list = friendService.listFriend( "user01" ) ;
      for(Friend i : list) {
         System.out.println( i ) ;
      }
   }
   
   //@Test
   public void addFriend() throws Exception {
      friendService.addFriend("faduck", "30773") ;
   }
   
   //@Test
   public void listFriend() throws Exception{
	   //friendService.getFriend("faduck");
	   List<Friend> list = friendService.listFriend("faduck") ;
	   for(Friend i : list) {
		   System.out.println( i );
	   }
	
   }
   
   @Test
   public void acceptFriend() throws Exception{
	   
	   Friend friend = new Friend();
	   friend.setFriendCode("1");
	
	   friendService.acceptFriend(friend);
	   List<Friend> list = friendService.listFriend("faduck") ;
	   for(Friend i : list) {
		   System.out.println( i );
	   }

   }
   
}
