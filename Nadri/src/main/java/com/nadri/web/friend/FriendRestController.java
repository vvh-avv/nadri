package com.nadri.web.friend;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;
import com.nadri.service.friend.FriendService;
import com.nadri.service.user.UserService;

@RestController
@RequestMapping("/friend/*")
public class FriendRestController {

	//field
	@Autowired
	@Qualifier("friendServiceImpl")
	private FriendService friendService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	
	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	
	//constructor method
	public FriendRestController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}

	
	//하지수테스트
   @RequestMapping(value="json/listFriendFromBoard/{userId}") //, method=RequestMethod.POST)
   public String listFriendFromBoard(@PathVariable String userId) throws Exception{
      System.out.println("/friend/json/listFriendFromBoard : GET / POST");
            
      return friendService.listFriendFromBoard(userId);
   }
   
   //친구 추가
   @RequestMapping(value="json/addFriend/{friendId}")
   public void addFriend(@PathVariable String friendId, HttpSession session) throws Exception{
	   System.out.println("/friend/json/addFriend : GET / POST");
	   
	   User user = (User)session.getAttribute("user");
	   
	   friendService.addFriend(user.getUserId(), friendId);
	   System.out.println("friendRestController - addFriend: "+friendId);
   }
   
  //친구 여부 확인
   @RequestMapping(value="json/chkFriend/{friendId}/{friendCode}")
   public int chkFriend(@PathVariable String friendId, @PathVariable int friendCode, HttpSession session) throws Exception{
      System.out.println("/friend/json/chkFriend : GET / POST");
      
      User user = (User)session.getAttribute("user");
      
      return friendService.checkFriend(user.getUserId(), friendId, friendCode);
   }
	
   
  
   //친구 삭제
 	@RequestMapping(value="json/deleteFriend/{friendId}")
 	public int deleteFriend(@PathVariable String friendId, HttpSession session)throws Exception{
 		
 		System.out.println("/friend/deleteFriend: GET/POST");
 		Friend friend = (Friend) session.getAttribute("friend");
 		System.out.println("friendcontroller - deleteFriend: "+friendId);
 		return friendService.deleteFriend(friend.getFriendId());
 		
 	}
 	
 	 //친구 승인
 	@RequestMapping(value="json/acceptFriend/{friendId}")
 	public void acceptFriend(@PathVariable String friendId, HttpSession session)throws Exception{
 		
 		System.out.println("/friend/acceptFriend: GET/POST");
 		User user = (User) session.getAttribute("user");
 		
 		friendService.acceptFriend(user.getUserId(), friendId);
 		System.out.println("friendcontroller - acceptFriend: "+friendId);
 	}
 	
 /*	//친구 조회
 	@RequestMapping( value="json/getFriend/{friendId}", method=RequestMethod.GET )
	public Friend getFriend( @PathVariable String friendId ) throws Exception{
		
		System.out.println("----------------------------------------------------");
		System.out.println("/user/json/getFriend : GET - "+ friendId);
		System.out.println("----------------------------------------------------");
		//Business Logic
		return friendService.getFriend(friendId);
	}*/
   
   
}
