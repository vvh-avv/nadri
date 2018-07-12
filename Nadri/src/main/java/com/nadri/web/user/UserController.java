package com.nadri.web.user;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nadri.common.Page;
import com.nadri.common.Search;
import com.nadri.service.domain.User;
import com.nadri.service.user.UserService;

@Controller
@RequestMapping("/user/*")
public class UserController {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	public UserController(){
		System.out.println(this.getClass());
	}

	@Value("#{commonProperties['pageUnit']}")
	//@Value("#{commonProperties['pageUnit'] ?: 3}")
	int pageUnit;
		
	@Value("#{commonProperties['pageSize']}")
	//@Value("#{commonProperties['pageSize'] ?: 2}")
	int pageSize;
	
	//유저 가입: get방식
	@RequestMapping(value="addUser", method=RequestMethod.GET)
	public String addUser() throws Exception {
		
		System.out.println("/user/addUser : GET");
		
		return "redirect:/user/addUserView.jsp";
	}
	
	//유저 가입: post방식
	@RequestMapping(value="addUser", method=RequestMethod.POST)
	public String addUser( @ModelAttribute("user") User user ) throws Exception {
		
		System.out.println("/user/addUser : POST");
		
		userService.addUser(user);
		
		return "redirect:/user/loginView.jsp";
	}
	
	/*//이메일 인증코드 생성
	@RequestMapping(value = "addUser", method = RequestMethod.POST)
	public String addUser(User user, Model model, RedirectAttributes rttr) throws Exception{
    
		System.out.println("addUser 진입 ");
    	userService.addUser(user);
        rttr.addFlashAttribute("msg" , "가입시 사용한 이메일로 인증해주세요");
		return "redirect:/";
	}*/
	
	//유저 정보 조회
	@RequestMapping(value="getUser", method=RequestMethod.GET)
	public String getUser( @RequestParam("userId") String userId , Model model ) throws Exception {
		System.out.println("/user/getUser : GET");
		
		User user = userService.getUser(userId);
		
		model.addAttribute("user", user);
			
		return "forward:/user/getUser.jsp";
	}
	
	//유저 정보 수정: get방식
	@RequestMapping(value="updateUser", method=RequestMethod.GET)
	public String updateUser( @RequestParam("userId") String userId , Model model ) throws Exception{
		System.out.println("/user/updateUser : GET");
		
		User user = userService.getUser(userId);
		
		model.addAttribute("user", user);
		
		return "forward:/user/updateUser.jsp";
	}
	
	//유저 정보 수정: post방식
	@RequestMapping(value="updateUser", method=RequestMethod.POST)
	public String updateUser( @ModelAttribute("user") User user , Model model , HttpSession session) throws Exception{
		System.out.println("/user/updateUser : POST");
		
		userService.updateUser(user);
		
		String sessionId=((User)session.getAttribute("user")).getUserId();
		if(sessionId.equals(user.getUserId())){
			session.setAttribute("user", user);
		}
		
		return "redirect:/user/getUser?userId="+user.getUserId();
	}
	
	//로그인: get방식
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String login() throws Exception{
		System.out.println("/user/login : GET");

		return "redirect:/user/loginView.jsp";
	}
	
	//로그인: post방식
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login( @ModelAttribute("user") User user , HttpSession session ) throws Exception{
		
		System.out.println("/user/login : POST");
		
		//Business Logic
		System.out.println("userId : "+user.getUserId());
		System.out.println("getPassword : "+user.getPassword());
		User dbUser=userService.getUser(user.getUserId());
		
				
		//입력한 회원정보가 없을 때
		if(dbUser==null) {
			return "redirect:/user/loginView.jsp";
		}
		
		//입력한 비밀번호가 일치한 경우 인덱스 화면으로
		if( user.getPassword().equals(dbUser.getPassword()) ){
			session.setAttribute("user", dbUser);
		}
		return "redirect:/index.jsp";
	}
	
	//sns 로그인
	@RequestMapping(value="snsLogin/{userId}")
	public String snsLogin( @PathVariable String userId, HttpSession session ) throws Exception{
		System.out.println("/user/snsLogin : GET / POST");
		
		User dbUser = userService.getUser(userId);
		
		session.setAttribute("user", dbUser);
		
		return "redirect:/index.jsp";
	}
	
	//로그아웃
	@RequestMapping(value="logout", method=RequestMethod.GET)
	public String logout( HttpSession session ) throws Exception{
		System.out.println("/user/logout : GET");
		
		session.invalidate();
		
		return "redirect:/index.jsp";
	}
	
	//유저 아이디 중복 체크
	@RequestMapping(value="checkDuplication", method=RequestMethod.POST)
	public String checkDuplication( @RequestParam("userId") String userId , Model model ) throws Exception{
		System.out.println("/user/checkDuplication : POST");
		//비즈니스 로직
		boolean result=userService.checkDuplication(userId);
		//모델과 뷰 연결
		model.addAttribute("result", new Boolean(result));
		model.addAttribute("userId", userId);

		return "forward:/user/checkDuplication.jsp";
	}
	
	//유저 목록
	@RequestMapping(value="listUser")
	public String listUser( @ModelAttribute("search") Search search, @RequestParam(value="sort", required=false, defaultValue="asc") String sort,
								Model model , HttpServletRequest request) throws Exception{
		
		System.out.println("/user/listUser : GET / POST");
		
		if(search.getCurrentPage()==0 ){
			search.setCurrentPage(1);
		}
		search.setPageSize(pageSize);
		
		// Business logic 수행
		Map<String , Object> map=userService.getUserList(search);
		
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, pageSize);
		System.out.println("listUser :: resultPage :: "+resultPage);
		
		// Model 과 View 연결
		model.addAttribute("list", map.get("list"));
		model.addAttribute("resultPage", resultPage);
		model.addAttribute("search", search);
		model.addAttribute("sort", sort);
		
		return "forward:/user/listUser.jsp";
	}
	


	//이메일 코드 검증
	/*//이메일인증
	@RequestMapping(value = "/emailConfirm", method = RequestMethod.GET)
	public String emailConfirm(String email, Model model) throws Exception {
		userService.userAuth(email);
		model.addAttribute("email", email);

		return "/user/emailConfirm";
	}*/
	
	//이메일 체크
	@RequestMapping( value="checkUserMail", method=RequestMethod.GET )
	public String checkMail(@RequestParam("user") String userId, @RequestParam("code") String emailCode, Model model) throws Exception{
		System.out.println(userId + "/" + emailCode);
		User user = new User();
		user = userService.getUser(userId);
		
		if(user != null && user.getEmailCode() != null) {
			//이메일 코드가 동일하거나 상태 코드가 3일 경우 "1"로 바꾸고 담아서 전송
			if(user.getEmailCode().equals(emailCode) && user.getUserStatusCode().equals("3")) {
				user.setUserStatusCode("1");									
				userService.updateStatusCode(user);
				model.addAttribute("checkUserMail", true);
				
				return "forward:/index.jsp";
			}
		}
		return "redirect:/index.jsp";
	}
	
/*	//회원탈퇴
	@RequestMapping(value="quitUser", method=RequestMethod.POST)
	public String quitUser(@RequestParam("userId") String userId) throws Exception{
		
		System.out.println("/user/quitUser:POST");
		quitReason.
		
		
		
		
		return userId;
	}*/
	
	
}
