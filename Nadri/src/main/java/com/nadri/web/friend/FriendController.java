package com.nadri.web.friend;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import com.nadri.common.Page;
import com.nadri.common.Search;
import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;
import com.nadri.service.friend.FriendService;
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
	@RequestMapping("/selectFriendList")
	public String selectFriendList(Model model, User user, HttpSession session) throws Exception {
		List<Friend> friendList = new ArrayList<Friend>();//模备 格废
		List<Friend> friendRequestList = new ArrayList<Friend>();//模备 夸没 格废
		List<Friend> friendAllList = null;//葛电 模备 格废
		if (session.getAttribute("user") != null) {
			if (user != null) {
				if(user.getUserId() != null) {
					String userIdSession = ((User)session.getAttribute("user")).getUserId();
					if (user.getUserId().equals(userIdSession)) {
						//秦寸 酒捞叼客 包访等 葛电 模备格废 罐澜
						friendAllList = friendService.selectFriendList(user);
						
						for (Friend friend : friendAllList) {
							//模备牢 版快
							if (friend.getFriendCode().equals("1")) {
								friendList.add(friend);
							
							} else {//模备 夸没牢 版快
								friendRequestList.add(friend);
							}
						}
					}
				}
			}
			model.addAttribute("friendList", friendList);
			model.addAttribute("friendRequestList", friendRequestList);
			return "friendList";
		}
		
		return "redirect:/index.jsp";
	}
	
	
	//糕滚 八祸
	@RequestMapping("/searchFriend")
	public String searchFriend(@RequestBody Map<String, String> parameterMap, Model model) throws Exception{
		List<Friend> searchFriendList = null;
		if (parameterMap != null) {
			searchFriendList = friendService.searchFriend(parameterMap.get("userId"), parameterMap.get("searchUserId"));
		}
		model.addAttribute("searchFriendList", searchFriendList);
		
		return "/friend/listFriend";
	}
	
	
	//模备 眠啊
	@RequestMapping("/acceptFriend")
	public String acceptFriend(String userId, String friendId)throws Exception{
		friendService.acceptFriend(userId, friendId);
		return "redirect:/friend/listFriend?userId="+userId;
	}
	
	
	//模备 昏力
	@RequestMapping("/deleteFriend")
	public String deleteFriend(String userId, String friendId)throws Exception{
		friendService.deleteFriend(userId, friendId);
		return "redirect:/friend/listFriend?userId="+userId;
	}
	
	
	//模备 夸没
	@RequestMapping("/addFriend")
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
	@RequestMapping("/cancelFriend")
	public String cancelFriend(@RequestBody Map<String, String> parameterMap, Model model)throws Exception{
		if (parameterMap != null) {
			int result = friendService.cancelFriend(parameterMap.get("userId"), parameterMap.get("friendId"));
			
			if (result > 0) {
				List<Friend> searchFriendList = null;
				searchFriendList = friendService.searchFriend(parameterMap.get("userId"), parameterMap.get("searchUserId"));
				model.addAttribute("searchFriendList", searchFriendList);
			}
		}
		
		return "friend/listFriend";
	}
	
	
	//模备 夸没 芭例
	@RequestMapping("/refuseFriend")
	public String refuseFriend(String userId, String friendId, HttpSession session) throws Exception{
		friendService.refuseFriend(userId, friendId);
		return "redirect:/friend/selectFriendList?userId="+userId;
	}
	
}
