package com.nadri.web.user;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;

import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Multipart;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.common.Page;
import com.nadri.common.Search;
import com.nadri.service.domain.User;
import com.nadri.service.user.UserService;
import com.nadri.common.util.sendingMail;

@RestController
@RequestMapping("/user/*")
public class UserRestController {

	//field
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	//constructor method
	public UserRestController() {
		System.out.println(this.getClass());
	}
	
	//method
	//rest 로그인: post
	@RequestMapping(value="json/login", method=RequestMethod.POST)
	public User login( @RequestBody User user, HttpSession session ) throws Exception{
		System.out.println("/user/json/login : POST");
		
		User returnUser = userService.getUser(user.getUserId());
		
		if(returnUser==null) {
			returnUser = new User();
			returnUser.setUserId("none");
		}
		if( user.getPassword().equals(returnUser.getPassword()) ){
			session.setAttribute("user", returnUser);
		}
		return returnUser;
	}
	
	//rest 유저 정보 가져오기
	@RequestMapping(value="json/getUser/{userId}", method=RequestMethod.GET)
	public User getUser( @PathVariable String userId ) throws Exception{
		System.out.println("/user/json/getUser : GET");
		
		return userService.getUser(userId);
	}
	
	//rest 유저 회원 가입: sns로그인에서 사용
	@RequestMapping(value="json/addUser", method=RequestMethod.POST)
	public User addUser( @RequestBody User user ) throws Exception{
		System.out.println("/user/json/addUser : POST");
		System.out.println("sns계정 가입자 정보: "+user);

		userService.addUser(user);
		System.out.println("/////////////////////////");
		System.out.println("sns계정 가입자 정보: "+user);
		System.out.println("/////////////////////////");
		return userService.getUser(user.getUserId());
	}

	
	@RequestMapping(value="json/updateUser", method=RequestMethod.POST)
	public User updateUser( @RequestBody User user ) throws Exception{
		System.out.println("/user/json/updateUser : POST");
		
		userService.updateUser(user);

		return userService.getUser(user.getUserId());
	}
	
	//rest 회원 아이디 중복 여부
	@RequestMapping(value="json/checkDuplication/{userId}", method=RequestMethod.GET)
	public boolean checkDuplication( @PathVariable String userId ) throws Exception{
		System.out.println("/user/json/checkDuplication : GET");
		System.out.println("아이디 중복 여부 체크: 해당 아이디 - "+userId);
		
		boolean result = userService.checkDuplication(userId);
		System.out.println("boolean 값 : "+result);
		
		return result;
	}
	
	//rest 유저 목록
	@RequestMapping(value="json/listUser/{sort}", method=RequestMethod.POST)
	public Map<String, Object> listUser( @RequestBody Search search, @PathVariable String sort ) throws Exception{
		System.out.println("/user/json/listUser : GET / POST");
		
		Map<String, Object> map = userService.getUserList(search);
		Page resultPage = new Page( search.getCurrentPage(), ((Integer)map.get("totalCount")).intValue(), 5, search.getPageSize());
		
		map.put("list", map.get("list"));
		map.put("resultPage", resultPage);
		map.put("search", search);
		map.put("sort", sort);
		
		return map; 
	}
	
	//이메일 인증
	@RequestMapping( value="json/sendMail/{userId}/{email}/{emailCode}", method=RequestMethod.GET)
	public boolean mailTest(@PathVariable String userId,
							@PathVariable String email,
							@PathVariable String emailCode) throws Exception{
		boolean check = false;
		String host = "smtp.google.com";
		String user = "nadritest@google.com";
		String password = "nadritest3";	
		String receiveMail = email;
		String code = emailCode;
		String nextUrl="http://localhost:8080/user/checkUserMail?user="+userId+"&code="+emailCode;
		
		Properties props = new Properties();
		props.put("mail.smtp.host", host);
		props.put("mail.smtp.port", 587);
		props.put("mail.smtp.auth", true);
		
		Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() { 
			protected PasswordAuthentication getPasswordAuthentication() { 
				return new PasswordAuthentication(user, password); 
			} 
		});
		
		try { 
			MimeMessage message = new MimeMessage(session); 
			message.setFrom(new InternetAddress(user)); 
			message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiveMail));
			message.setSubject("가입 인증 메일입니다.");   		// 메일 제목 
			
			Multipart multiPart = new MimeMultipart();
			MimeBodyPart multBodyPart = new MimeBodyPart();

			
			multBodyPart.setContent("회원가입을 축하합니다.<br>아래 링크를 클릭하여 가입 절차를 마무리하세요.<br><br>"
					+ "<a href="+nextUrl+" target=\"_self\" style=\"cursor: pointer; white-space: pre;\">확인</a>", "text/html;charset=euc-kr");
			
			multiPart.addBodyPart(multBodyPart);
			
			message.setContent(multiPart, "text/html;charset=euc-kr");
			///////////////////////////////////////////////////////////////////
			
			Transport.send(message); 
			System.out.println("메시지 보내기 성공"); 
			check = true;
		} catch (MessagingException e) { 
			e.printStackTrace();
		}
		return check;
	}
	

	//회원 아이디 찾기
	@RequestMapping(value="json/findUserId", method=RequestMethod.POST)
	public Map<String, String> findUserId(@RequestBody User user) throws Exception{
		
		System.out.println("RestController:: /json/findUserId : POST");
		
		//User user = new User();
		user = userService.findUserId(user);
		
		
		String userId = user.getUserId();
		
		//제이슨 데이터는 맵이나 도메인으로 
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		return map;
	}
	
	
	
	//회원가입 시 이메일 전송
	@RequestMapping( value="json/emailCheck", method=RequestMethod.POST )
	public String emailCheck( Model model, HttpServletRequest request, HttpServletResponse response) throws Exception{
		
		String userEmail = request.getParameter("userEmail") ;
		
		int authenticationNumber = new sendingMail().Sending(userEmail) ;
		System.out.println("/emailCheck POST " + authenticationNumber );
		model.addAttribute("authenticationNumber", (new Integer(authenticationNumber) ))  ;
		//세션 호출 + 인증번호 심기
		HttpSession session = request.getSession() ;
		session.setAttribute("authenticationNumber", authenticationNumber);
		return "forward:/common/True.jsp" ;
	}
		
	//회원가입 시 이메일 전송 후 승인번호 확인
	@RequestMapping( value="json/emailCheck2", method=RequestMethod.POST )
	public String emailCheck2(HttpServletRequest request) {
		String qualifiedNumber = request.getParameter("qulifiedNumber") ;
		System.out.println("/emailCheck2 POST " + qualifiedNumber ) ;
		System.out.println("/emailCheck2 POST " + request.getParameter("authenticationNumber") ) ;
		
		if(qualifiedNumber.equals(request.getParameter("authenticationNumber")) ) {
			System.out.println("true") ;
			return "0" ;
		} else {
			System.out.println("false") ;
			return "1" ;
		}
	}
	
	
}
