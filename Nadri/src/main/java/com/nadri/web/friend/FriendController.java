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
	//친구 맺기
	@RequestMapping(value = "addFriend", method = RequestMethod.POST)
	public String addFriend(@ModelAttribute("friend") Friend friend, Model model) throws Exception {
		System.out.println("/friend/addFriend:POST");

		System.out.println("friendController addFriend ");
		//내비게이션?? - 결과적으로는 필요없는??: rest controller에서 버튼 등의 형식으로 처리할 확률 높음
		return "forward:/friend/addFriend.jsp";	
	}
	
	//친구 리스트
	@RequestMapping(value = "listFriend",method=RequestMethod.GET)
	public String listFriend(@ModelAttribute("search") Search search, HttpSession session, Model model ,HttpServletRequest request) throws Exception {
		System.out.println("friend/listFriend : GET");
		//유저 아이디 세션에서 불러와 담기
		String userId = ((User) session.getAttribute("user")).getUserId();
		//현재 페이지 설정
		if(search.getCurrentPage()==0) {
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		search.setSearchKeyword(((User) session.getAttribute("user")).getUserId());
		//map에 친구 리스트 담기
		Map<String, Object> map = friendService.listFriend(search);
		System.out.println("Controller - listFriend:"+search);
		
		Friend friend;
		String[] str;
		
		List list = (List) map.get("list");
		
		for(int i = 0; i < list.size(); i++) {
			friend = (Friend) list.get(i);
			//문자열에 친구 맺은 날 담기
			str = friend.getCreatedDate().split("-");
			friend.setCreatedDate(str[0]+"년"+str[1]+"월");
			list.set(i, friend);
		}
		
		Page resultPage = new Page(search.getCurrentPage(), ((Integer) map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println(resultPage);
		//친구 추천 리스트화
		List<Friend> list2 = friendService.recommendFriend(userId);

		model.addAttribute("list", list);
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("recommendList", list2);
		request.setAttribute("countFriend",friendService.countFriend(userId));
		System.out.println("friendController - listFriend: "+list2);
		//내비게이션
		return "forward:/friend/listFriend.jsp";
	}
	
	//친구 조회(확인)
	@RequestMapping(value="getFriend", method=RequestMethod.POST)
	public String getFriend(@RequestParam(value="friendId",required=false)String friendId, Model model, HttpSession session) throws Exception{		
		System.out.println("friend/getFriend:POST");
		//친구 정보 가져오기
		Friend friend=friendService.getFriend(friendId);
		//친구 정보 모델에 담기
		model.addAttribute("friend",friend);
		//내비게이션
		return "forward:/friend/getFriend.jsp";
	}
	
	
	//친구 수정(변경)
	@RequestMapping(value="updateFriend", method=RequestMethod.GET)
	public String updateFriend(@RequestParam(value="friendId",required=false)String friendId,Model model)throws Exception{
		System.out.println("/friend/updateFriend:GET");
		//친구 정보 가져오기
		Friend friend=friendService.getFriend(friendId);
		//모델에 정보담기
		model.addAttribute("friend",friend);
		//내비게이션
		return "forward:/friend/updateFriend.jsp";
	}
	
}
