package com.nadri.web.friend;

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
	@RequestMapping(value = "addFriend", method = RequestMethod.POST)
	public String addFriend(@ModelAttribute("friend") Friend friend, Model model) throws Exception {
		System.out.println("/friend/addFriend:POST");

		System.out.println("friendController addFriend ");
		
		return "forward:/friend/addFriend.jsp";	
	}
	
	
	/*@RequestMapping(value = "listFriend",method=RequestMethod.GET)
	public String listFriend(@ModelAttribute("search") Search search, HttpSession session, Model model ,HttpServletRequest request) throws Exception {
		System.out.println("friend/listFriend : GET");
		
		String userId = ((User) session.getAttribute("user")).getUserId();
		
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchKeyword(((User) session.getAttribute("user")).getUserId());
		
		Map<String, Object> map = friendService.listFriend(search);
		System.out.println("Controller - listFriend:"+search);
		
		Friend friend;
		String[] str;
		
		List list = (List) map.get("list");
		
		for(int i = 0; i < list.size(); i++) {
			friend = (Friend) list.get(i);
			str = friend.getCreatedDate().split("-");
			friend.setCreatedDate(str[0]+"¿ù"+str[1]+"ÀÏ");
			list.set(i, friend);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		List<Friend> list2 = friendService.recommendFriend(userId);

		model.addAttribute("list", list);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("recommendList", list2);
		request.setAttribute("countFriend",friendService.countFriend(userId));
		System.out.println(list2);

		return "forward:/friend/listFriend.jsp";
	}*/
	
	
	@RequestMapping(value="getFriend",method=RequestMethod.POST)
	public String getFriend(@RequestParam(value="friendId",required=false)String friendId, Model model, HttpSession session) throws Exception{		
		System.out.println("friend/getFriend:POST");

		Friend friend=friendService.getFriend(friendId);
		
		model.addAttribute("friend",friend);
		
		return "forward:/friend/getFriend.jsp";
	}
	
	
	@RequestMapping(value="updateFriend",method=RequestMethod.GET)
	public String updateFriend(@RequestParam(value="friendId",required=false)String friendId,Model model)throws Exception{
		System.out.println("/friend/updateFriend:GET");
		
		Friend friend=friendService.getFriend(friendId);
		model.addAttribute("friend",friend);
		
		return "forward:/friend/updateFriend.jsp";
	}
	
}
