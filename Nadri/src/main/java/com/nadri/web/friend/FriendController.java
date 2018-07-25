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
		System.out.println("--------------------------------------------------------------------------");
		model.addAttribute("fList", fList);
		System.out.println("after fList: "+fList);
		
		return "forward:/friend/listFriend.jsp";
	}

	
	//模备 眠啊
	@RequestMapping(value="acceptFriend")
	public String acceptFriend(String userId, String friendId)throws Exception{
		friendService.acceptFriend(userId, friendId);
		return "redirect:/friend/listFriend?userId="+userId;
	}
	
	
	//模备 沥焊 炼雀
	@RequestMapping(value="getFriend", method=RequestMethod.GET)
	public String getFriend(@RequestParam("friendId") String friendId, Model model)throws Exception{
		System.out.println("/friend/getFriend: GET");
		
		Friend friend = friendService.getFriend(friendId);
		
		model.addAttribute("friend", friend);
		
		return "forward:/friend/getFreind.jsp";
	}
	
	//模备 昏力
	@RequestMapping(value="deleteFriend", method=RequestMethod.POST)
	public String deleteFriend(String userId, String friendId)throws Exception{
		friendService.deleteFriend(userId, friendId);
		return "forward:/friend/listFriend?userId="+userId;
	}
	
	
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
	
	
	//模备 夸没 秒家
	@RequestMapping(value="cancelFriend")
	public String cancelFriend(@RequestBody Map<String, String> parameterMap, Model model)throws Exception{
		if (parameterMap != null) {
			friendService.cancelFriend(parameterMap.get("userId"), parameterMap.get("friendId"));
			
				List<Friend> searchFriendList = null;
				searchFriendList = friendService.searchFriend(parameterMap.get("userId"), parameterMap.get("searchUserId"));
				model.addAttribute("searchFriendList", searchFriendList);
		}
		return "friend/listFriend";
	}
	
	
	//模备 夸没 芭例
	@RequestMapping(value="refuseFriend")
	public String refuseFriend(String userId, String friendId, HttpSession session) throws Exception{
		friendService.refuseFriend(userId, friendId);
		return "redirect:/friend/listFriend?userId="+userId;
	}
	
}
