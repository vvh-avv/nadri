package com.nadri.service.user.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.domain.User;
import com.nadri.service.user.UserDao;
import com.nadri.service.user.UserService;
import com.nadri.web.mail.MailHandler;
import com.nadri.web.mail.TempKey;

//회원관리 서비스 구현
@Service("userServiceImpl")
public class UserServiceImpl implements UserService{
	
	@Autowired
	@Qualifier("userDaoImpl")
	private UserDao userDao;
	public void setUserDao(UserDao userDao) {
		this.userDao = userDao;
	}
	
		
	/*@Autowired
	private JavaMailSender mailSender;*/
	
	//Constructor method
	public UserServiceImpl() {
		System.out.println(this.getClass());
	}
	
	
	///Method
	public void addUser(User user) throws Exception {
		userDao.addUser(user);
		
		/*String key = new TempKey().getKey(50, false); 			// 인증키 생성
		
		userDao.createAuthKey(user.getEmail(), key);	// 인증키 DB에 저장
		
		MailHandler sendMail = new MailHandler(mailSender);
		sendMail.setSubject("nadri 이메일 인증]");
		sendMail.setText(
				new StringBuffer().append("<h1>메일인증</h1>").append("<a href='http://localhost/user/emailConfirm?user_email=").append(user.getEmail()).append("&key=").append(key).append("' target='_blenk'>이메일 인증 확인</a>").toString());
		sendMail.setFrom("nadritest3@gmail.com", "너나들이테스트");
		sendMail.setTo(user.getEmail());
		sendMail.send();*/
	}
		


	public User getUser(String userId) throws Exception {
		return userDao.getUser(userId);
	}

	public Map<String, Object> getUserList(Search search) throws Exception {
		List<User> list= (List<User>) userDao.getUserList(search);
		int totalCount = userDao.getTotalCount(search);
		
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("list", list );
		map.put("totalCount", new Integer(totalCount));
		
		return map;
	}

	public void updateUser(User user) throws Exception {
		userDao.updateUser(user);
	}

	public boolean checkDuplication(String userId) throws Exception {
		boolean result=true;
		User user=userDao.getUser(userId);
		if(user != null) {
			result=false;
		}
		return result;
	}


	@Override
	public Map<String, Object> getRewardList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getBoardList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getScheduleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getCartList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getUserReportList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	//회원 탈퇴
	@Override
	public void quitUser(User user) throws Exception {
		// TODO Auto-generated method stub
		userDao.quitUser(user);
	}

	@Override
	public User findUserId(User user) throws Exception {
		// TODO Auto-generated method stub
		return userDao.findUserId(user);
	}

	@Override
	public void findPassword(User user) throws Exception {
		// TODO Auto-generated method stub
		/*//임시 비밀번호 생성	    
	    String password = userDao.randomNumber(5);
	    
	    user=userDao.getUser(user.getUserId());
	    
	    user.setPassword(password);
	    userDao.updateUser(user);
	    
	    System.out.println("비밀번호 바뀐 유저의 정보::" + user);
	  
	    //String content = "\n\n test :: 임시비밀번호보내기\n\n임시비밀번호는 \"" + password + "\" 입니다.\n반드시 로그인 후 비밀번호를 수정해주세요!";
	    
	    try {
	      MimeMessage message = mailSender.createMimeMessage();
	      MimeMessageHelper messageHelper 
	                        = new MimeMessageHelper(message, true, "UTF-8");
	 
	      messageHelper.setFrom(setFrom); 												//보내는 사람
	      messageHelper.setTo(user.getUserId());     
	      messageHelper.setSubject(subject);											 //메일제목
	      messageHelper.setText(contentPwd +password+content2);  	//메일 내용
	     
	      mailSender.send(message);
	    } catch(Exception e){
	     
	    	System.out.println(e);
	    }*/
	}

	/*@Override
	public void userAuth(String email) throws Exception {
		// TODO Auto-generated method stub
		userDao.userAuth(email);
	}*/


	@Override
	public void updateStatusCode(User user) throws Exception {
		// TODO Auto-generated method stub
		userDao.updateStatusCode(user);
	}

}