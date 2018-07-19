/*package com.nadri.web.friend;

import java.util.List;
import java.util.Map;

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

import com.nadri.common.Page;
import com.nadri.common.Search;
import com.nadri.service.domain.Friend;
import com.nadri.service.domain.User;
import com.nadri.service.friend.FriendService;
import com.nadri.service.user.UserService;

@Controller
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
	}

	//method
	//模备 肝扁
	@RequestMapping
	public String addFriend(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, @ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception {
		
		
	}
	
	//模备 格废
	@RequestMapping(value="listFriend", method=RequestMethod.POST)
	public List<Friend> listFriend(@ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception{
		System.out.println("friend/rest/listFriend: POST");
		
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setSearchKeyword (session.getAttribute("user")).getUserId());

		Map<String, Object> map = friendService.listFriend(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);

		model.addAttribute("list",map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);

		return (List)map.get("list");
	}
	
	//模备 谗扁
	@RequestMapping
	public String deleteFriend(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, @ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception{
		System.out.println("restController - deleteFriend");
		
		
	}
	
	//
	@RequestMapping(value="rest/cutFriend", method=RequestMethod.POST)
	public String cutFriend(@RequestBody Map<String, Object> map, Model model) throws Exception{
		System.out.println("cutFriend()");
		
		int userId = ((int)map.get("userId"));
		int friendId = ((int)map.get("friendId"));
		
		friendService.cancelFriend(userId, friendId, 0);
		friendService.updateStatus(friendId, userId, 1);
	
		
		return null;
	}
	
	@RequestMapping(value="rest/refuseFriend", method=RequestMethod.POST)
	public String refuseFriend(@RequestBody Map<String, Object> map, Model model) throws Exception{
		System.out.println("refuseFriend()");
		
		int userId = ((int)map.get("userId"));
		int friendId = ((int)map.get("friendId"));
		int noticeId = ((int)map.get("noticeId"));
		
		friendService.updateStatus(friendId, userId, 1);		

		commonService.deleteNotice(noticeId);
	
		
		return null;
	}
	
	@RequestMapping(value="rest/okFriend", method=RequestMethod.POST)
	public String okFriend(@RequestBody Map<String, Object> map, Model model) throws Exception{
		System.out.println("okFriend()");
		int noticeId = ((int)map.get("noticeId"));

		commonService.deleteNotice(noticeId);
	
		
		return null;
	}
	
	
	@RequestMapping(value="rest/addFollow", method=RequestMethod.POST)
	public String addFollow(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, Model model) throws Exception{
		System.out.println("cutFriend()");
		System.out.println("addfollowFriend :: "+friend);
		
		int userId = ((int)map.get("userId"));
		int friendId = ((int)map.get("friendId"));
		String userName =  ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId);
		System.out.println(friend);
		
		friendService.addFriend(friend, "1");
		
		
		return null;
	}
	
	@RequestMapping(value="rest/cancelFollow", method=RequestMethod.POST)
	public String cancelFollow(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, Model model) throws Exception{
		System.out.println("restCancelFollow");
		
		int userId = ((int)map.get("userId"));
		int friendId = ((int)map.get("friendId"));
		String userName =  ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId);
		System.out.println(friend);
		
		friendService.cancelFriend(userId, friendId, 1);
		
		return null;
	}
	
}
*/