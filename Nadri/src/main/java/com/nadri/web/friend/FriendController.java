package com.nadri.web.friend;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;
import com.nadri.service.friend.FriendService;
import com.nadri.service.user.UserDao;
import com.nadri.service.user.UserService;

@Controller
@RequestMapping("/friend/*")
public class FriendController {

	//field
	@Autowired
	@Qualifier("friendServiceImpl")
	private FriendService friendService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	
	@Value("#{commonProperties['pageUnit']}")
	// @Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;

	@Value("#{commonProperties['pageSize']}")
	// @Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;

	
	//constructor method
	public FriendController() {
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	//method
	@RequestMapping(value = "listFriend", method= {RequestMethod.GET, RequestMethod.POST})
	public String listFriend(HttpSession session, Model model)throws Exception{

		String userId = ((User)session.getAttribute("user")).getUserId();
		
		System.out.println("/friend/listFriend start: "+userId);
		List<Friend> fList = friendService.listFriend(userId);
		
		System.out.println("-------------------------------------listFriend controller-------------------------------------");
		System.out.println("controller fList: "+fList);
		model.addAttribute("fList", fList);
		System.out.println("friend controller - after fList: "+fList);
		
		return "forward:/friend/listFriend.jsp";
	}
	
	//method
		@RequestMapping(value = "listFriend2", method= {RequestMethod.GET, RequestMethod.POST})
		public String listFriend2(HttpSession session, Model model)throws Exception{

			String userId = ((User)session.getAttribute("user")).getUserId();
			
			System.out.println("/friend/listFriend2 start: "+userId);
			List<Friend> fList2 = friendService.listFriend2(userId);
			System.out.println("//////////////////////////"+fList2);
			
			System.out.println("-------------------------------------listFriend2 controller-------------------------------------");
			System.out.println("controller fList2: "+fList2);
			model.addAttribute("fList2", fList2);
			System.out.println("friend controller - after fList2: "+fList2);
			
			return "forward:/friend/listFriend.jsp";
		}

	
	//模备 眠啊
	/*@RequestMapping(value="acceptFriend", method=RequestMethod.GET )
	public String acceptFriend(@RequestParam("friendId") String friendId, Model model)throws Exception{
		System.out.println("controller - acceptFriend start");
		Friend friend = friendService.getFriend(friendId);
		System.out.println("acceptFriend 搬苞 眠啊等 模备: "+friendId);
		model.addAttribute("Friend", friend);
		System.out.println("acceptFriend - model俊 淬变 模备"+friend);
	
		return "forward:/friend/listFriend.jsp";
	}*/
	
	
	
	//模备 夸没	
	@RequestMapping(value="addFriend")
	public String addFriend(@RequestBody Map<String, String> parameterMap, Model model)throws Exception{
		if (parameterMap != null) {
			friendService.addFriend(parameterMap.get("userId"), parameterMap.get("friendId"));
			
			List<Friend> searchFriendList = null;
			searchFriendList = friendService.searchFriend(parameterMap.get("userId"), parameterMap.get("searchFriendId"));
			model.addAttribute("searchFriendList", searchFriendList);
			}

		return "friend/listFriend";
	}
	
	
	
}
