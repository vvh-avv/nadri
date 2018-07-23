package com.nadri.web.friend;

import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.common.Page;
import com.nadri.common.Search;
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

	////하지수테스트
	@RequestMapping(value="json/listFriendFromBoard/{userId}")
	public String listFriendFromBoard(@PathVariable String userId) throws Exception{
		System.out.println("/friend/json/listFriendFromBoard : GET"); //$.getJSON 으로 가져오는거라 POST로 하면 에러
				
		return friendService.listFriendFromBoard(userId);
	}
	@RequestMapping(value="json/chkFriend/{friendId}")
	public int chkFriend(@PathVariable String friendId, HttpSession session) throws Exception{
		System.out.println("/friend/json/chkFriend : GET / POST");
		
		User user = (User)session.getAttribute("user");
		
		return friendService.checkFriend(user.getUserId(), friendId, 1);
	}
	
	//method
	//친구 목록
	@RequestMapping(value="json/listFriend", method=RequestMethod.POST)
	public List<Friend> listFriend(@ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception{
		System.out.println("friend/json/listFriend: POST");
		//현재 페이지
		if (search.getCurrentPage() == 0) {
			search.setCurrentPage(1);
		}
		
		search.setPageSize(pageSize);
		search.setSearchKeyword(((User)session.getAttribute("user")).getUserId());
		//map에 친구 리스트 담기
		Map<String, Object> map = friendService.listFriend(search);
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		//모델에 리스트, 페이지 정보 담기
		model.addAttribute("list",map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		//리스트 반환
		return (List)map.get("list");
	}
	
	//친구 맺기
	@RequestMapping(value="json/addFriend", method=RequestMethod.POST)
	public String addFriend(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, @ModelAttribute("search") Search search, HttpSession session, Model model) throws Exception {
		
		String userId2 = ((String) map.get("userId"));
		String friendId = ((String) map.get("friendId"));
		String userName = ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId2);
		System.out.println("친구 맺기할 친구 정보: "+friend);
		//userid, friendId 둘 다 0이면 친구(1명만 0이면 친구 신청상태)
		friendService.addFriend(friend, "0");
		
		return null;
	}
	
		
	//친구 신청 취소
	@RequestMapping(value = "json/cancelFriend", method=RequestMethod.POST)
	public String cancelFriend(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, @ModelAttribute("search") Search search,HttpSession session, Model model) throws Exception{
		System.out.println("json/cancelFriend()");
		
		String userId = ((String)map.get("userId"));
		String friendId = ((String)map.get("friendId"));
		String userName =  ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId);
		System.out.println(friend);
		
		friendService.cancelFriend(userId, friendId, 0);
		
		return null;
	}
	
	//친구 끊기
	@RequestMapping(value = "json/deleteFriend", method=RequestMethod.POST)
	public String delectFriend(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, @ModelAttribute("search") Search search,HttpSession session, Model model) throws Exception{
		System.out.println("json/deleteFriend()");
		
		String userId = ((String)map.get("userId"));
		String friendId = ((String)map.get("friendId"));
		String userName =  ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId);
		System.out.println(friend);
		
		friendService.cancelFriend(userId, friendId, 0);
		return null;
	}
	
	//받은 친구 신청 거절
	@RequestMapping(value="json/refuseFriend", method=RequestMethod.POST)
	public String refuseFriend(@RequestBody Map<String, Object> map, Model model) throws Exception{
		System.out.println("refuseFriend()");
		
		String userId = ((String)map.get("userId"));
		String friendId = ((String)map.get("friendId"));
		
		friendService.updateStatus(friendId, userId, 1);			
		
		return null;
	}
	
	
	@RequestMapping(value="json/okFriend", method=RequestMethod.POST)
	public String okFriend(@RequestBody Map<String, Object> map, Model model) throws Exception{
		System.out.println("okFriend()");
		
		return null;
	}
	
	//follow 추가
	@RequestMapping(value="json/addFollow", method=RequestMethod.POST)
	public String addFollow(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, Model model) throws Exception{
		System.out.println("cutFriend()");
		System.out.println("restController addfollowFriend - start :: "+friend);
		
		String userId = ((String)map.get("userId"));
		String friendId = ((String)map.get("friendId"));
		String userName =  ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId);
		System.out.println("restController addFollow: "+friend);
		
		friendService.addFriend(friend, "1");
		
		
		return null;
	}
	
	//follow 취소
	@RequestMapping(value="json/cancelFollow", method=RequestMethod.POST)
	public String cancelFollow(@RequestBody Map<String, Object> map, @ModelAttribute("friend") Friend friend, Model model) throws Exception{
		System.out.println("json/ancelFollow");
		
		String userId = ((String)map.get("userId"));
		String friendId = ((String)map.get("friendId"));
		String userName =  ((String)map.get("userName"));
		
		friend.setFriendId(friendId);
		friend.setUserId(userId);
		System.out.println("restController cancelFoller: "+friend);
		
		friendService.cancelFriend(userId, friendId, 1);
		return null;
	}
	
}
