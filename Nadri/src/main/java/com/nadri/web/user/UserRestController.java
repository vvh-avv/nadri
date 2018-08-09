package com.nadri.web.user;

import java.util.HashMap;
import java.util.Map;
import java.util.Properties;
import java.util.Random;

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

import org.json.simple.JSONObject;
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
	public JSONObject login( @RequestBody User user, HttpSession session, HttpServletResponse response ) throws Exception{
		System.out.println("/user/json/login : POST");
		
		User returnUser = userService.getUser(user.getUserId());
		System.out.println("returnUser: "+returnUser);
		
		String userStatus = "3";
		// status(0: 정상, 1: 차단, 2: 탈퇴)
		
		if(returnUser != null) {
			
			userStatus = returnUser.getStatus();
			if(userStatus.equals("1")) {
				userStatus = "1";								//차단된 유저
			}else if(userStatus.equals("2")) {
				userStatus = "2";								//탈퇴한 유저
			}else{
				if( user.getPassword().equals(returnUser.getPassword()) ){
					session.setAttribute("user", returnUser);
					userStatus = "0";
				}//정상 유저 로그인
			}
		}
		JSONObject jsonObject = new JSONObject();
		jsonObject.put("userStatus", userStatus);
		System.out.println("제이슨에 담긴 userstatus 값: "+jsonObject.toString());
		return jsonObject;
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
		String password = "nadritest9870";	
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
			
			message.setContent(multiPart, "text/html; charset=EUC-KR");
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
		
		/*System.out.println("RestController:: /json/findUserId : POST");
		
		//User user = new User();
		user = userService.findUserId(user);
		System.out.println("user rest controller - userid찾기 - 아이: "+user);
		
		String userId = user.getUserId();
		
		//제이슨 데이터는 맵이나 도메인으로 
		Map<String, String> map = new HashMap<String, String>();
		map.put("userId", userId);
		return map;*/
		
		System.out.println("RestController:: /json/findUserId : POST");
	      
	      //User user = new User();
	      user = userService.findUserId(user);

	      //제이슨 데이터는 맵이나 도메인으로 
	      Map<String, String> map = new HashMap<String, String>();
	      if(user==null) {
	         map.put("userId", null);
	      }else {
	         String userId = user.getUserId();
	         map.put("userId", userId);
	      }
	      
	      return map;
	}
	
	//회원 비밀번호 찾기
	@RequestMapping(value="json/findPassword", method=RequestMethod.POST)
	public boolean findUserPassword(@RequestBody User user)throws Exception{
		System.out.println("RestController:: /json/findPassword:POST");
		
		boolean check = false;
		
		//유저 이메일 담기
		String email = user.getEmail();
		
		//유저 서비스에서 유저 정보 가져오기 + 이메일 정보 가져오기
		user = userService.getUser(user.getUserId());
		if(user == null) {
			return false;
		}
		String email2 = user.getEmail();
		
		
		if(email.equals(email2)) {
			int passwordNo = createNo();
			user.setPassword(passwordNo+"");
			
			System.out.println("비밀번호 확인: "+user);
			userService.updateUser(user);
			System.out.println("변경된 비밀번호 확인 필요");
			
			boolean sendOk = sendEmail(email2, passwordNo);
			
			if(sendOk) {
				check = true;
			}
		}
		return check;
	}
	
	//비밀번호 이메일로 보내기
	public boolean sendEmail(String email2, int passwordNo) throws Exception{
		String host = "smtp.gmail.com";
		String user = "nadritest@gmail.com";
		String password = "nadritest9870";
		
		String receiver = email2;
		
		String emailHtml = "<HTML>"
									+ "<HEAD><TITLE></TITLE></HEAD>"
									+ "<BODY>"
									+ "<div style=\"background:url(https://66.media.tumblr.com/1532bff6c66f588d3fb279b7af8370be/tumblr_pd0mrrQvZJ1v6rnvho1_540.png) no-repeat center;\">"
									+ "<div style=\"text-align:center; margin-bottom: 60px; margin-top: 44px; color: #000000;\"><p style=\"padding-top:33px; margin-bottom: 13px;\">"
									+ "<h3>당신과 함께해서 더욱 즐거운 서울<br>너, 나들이에서 알려드립니다</h3>"
									+ "<h3>고객님이 요청하신 비밀번호 찾기에 의해 임시 비밀번호가 전송되었습니다</h3>"
									+ "<h4>임시 비밀번호는 다음과 같습니다</h4>"
									+ "<h4>임시 비밀번호: <b>"+passwordNo+"</b></h4>"
											+ "</p>"
											+ "<br><br/></div>"
											+ "</div>"
											+ "</BODY>"
											+ "</HTML>";
		
		 Properties props = new Properties();
		  props.put("mail.smtp.host", host);
		  props.put("mail.smtp.port", 587);
		  props.put("mail.smtp.auth", "true");
		  props.put("mail.smtp.starttls.enable", "true");
		  props.put("mail.transport.protocol", "smtp");
		  props.put("mail.smtp.socketFactory.fallback", "true");
		  props.put("mail.smtp.ssl.trust", "smtp.gmail.com");
		  
		  Session session = Session.getDefaultInstance(props, new javax.mail.Authenticator() {
			   protected PasswordAuthentication getPasswordAuthentication() {
				   return new PasswordAuthentication(user, password);
			   }
		  });
		  
		// Compose the message
		  try {
			   MimeMessage message = new MimeMessage(session);
			   message.setFrom(new InternetAddress(user));
			   message.addRecipient(Message.RecipientType.TO, new InternetAddress(receiver));
		  
			// Subject
		   message.setSubject("너, 나들이에서 임시 비밀번호를 알려드립니다");
		  
		   message.setContent(emailHtml	, "text/html; charset=EUC-KR");  
		
		// send the message
		   Transport.send(message);
		   System.out.println("message sent successfully...");

		  } catch (MessagingException e) {
		   e.printStackTrace();
		  }
		  return true;
	}
	
	//임시 비밀번호 만들기
	public int createNo() {
		Random ran = new Random();
		
		int passwordNo = ran.nextInt();
		passwordNo = Math.abs(passwordNo);
		
		String temp = passwordNo+"";
		
		temp = temp.substring(3);
		passwordNo = Integer.parseInt(temp);
		
		System.out.println("생성된 임시 비밀번호: "+passwordNo);
		return passwordNo;
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
	
	//회원탈퇴
	@RequestMapping(value="json/quitUser/{userId}", method=RequestMethod.POST)
   public void quitUser( @PathVariable("userId") String userId) throws Exception{
      System.out.println("RestController:: /user/json/quitUser : POST");
      
      userService.quitUser(userId);
   }
	
	
}
