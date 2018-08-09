package com.nadri.web.notice;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nadri.common.Search;
import com.nadri.service.domain.Notice;
import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.User;
import com.nadri.service.notice.NoticeService;
import com.nadri.service.schedule.ScheduleService;
import com.nadri.service.user.UserService;

@Controller
@RequestMapping("/notice/*")
public class NoticeRestController {
	
	@Autowired
	@Qualifier("noticeServiceImpl")
	NoticeService noticeService ;

	@Autowired
	@Qualifier("scheduleServiceImpl")
	private ScheduleService scheduleService;

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Value("#{noticeProperties}")
	Map<String , Object> noticeMap ;
	
	@ResponseBody
	@RequestMapping( value="json/addNotice", method=RequestMethod.GET  )
	public Notice addNotice( @RequestParam(value="receiverId") String receiverId , 
										@RequestParam(value="otherPk") int otherPk ,
										@RequestParam(value="noticeCode") int noticeCode , HttpSession session , Notice notice ) {
		System.out.println("json/addNotice GET") ;
		
		notice.setOtherPk(otherPk) ;
		notice.setNoticeCode( noticeCode ) ;
		notice.setReceiverId(receiverId) ;
		notice.setSenderId( ((User)session.getAttribute("user")).getUserId() ) ;
		
		System.out.println("json/addNotice 받은 데이터 : " + notice) ;
		noticeService.addNotice( notice ) ;
		return notice ;
	}
	
	@ResponseBody
	@RequestMapping( value="json/getNoticeList", method=RequestMethod.POST )
	public Map<String , Object> getNoticeList( Search search , HttpSession session) {
		
		System.out.println( "json/getNoticeList" ) ;
		if( (User)session.getAttribute("user") != null) {
			List<Notice> noticeList = noticeService.getNoticeList(search, ((User)session.getAttribute("user")).getUserId()) ;
			Map<String , Object> notice = new HashMap<String , Object>() ;
			
			for(int i = 0 ; i < noticeList.size() ; i++) {
				noticeList.get(i).setContent( noticeList.get(i).getSenderId() + noticeMap.get( noticeList.get( i ).getNoticeCode() + "") ) ;
			}
			
			notice.put("noticeList" , noticeList) ;
			notice.put("noticeMap" , noticeMap) ;
			
			return notice ;
		} else {
			return null ;
		}
		
	}
	
	@ResponseBody
	@RequestMapping( value="json/updateNotice", method=RequestMethod.GET )
	public String updateNotice( @RequestParam(value="noticeNo") String noticeNo ) {
		System.out.println(noticeNo);
		noticeService.updateNotice( Integer.parseInt( noticeNo ) ) ;
		
		return "Success" ;
	}
	

	@PostConstruct
	@Scheduled(cron="0 0 8 * * *")
	@RequestMapping( value="json/getFirebaseAlarm", method=RequestMethod.GET )
	public void getAlarm( ) throws Exception{
		System.out.println("/notice/json/getFirebaseAlerm");

		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd" );
		Date currentDate =  mSimpleDateFormat.parse( mSimpleDateFormat.format( new Date() ) );
		
		Search search = new Search();
		Map<String, Object> userMap = userService.getUserList(search);
		List<User> userList = (List<User>)userMap.get("list");
		
		for( User user : userList ) {
			if( user.getToken()!=null ) { //토큰이 있는 유저만 해당
				search.setUserId( user.getUserId() );
				Map<String, Object> scheduleMap = scheduleService.getMyScheduleList(search);
				List<Schedule> scheduleList = (List<Schedule>)scheduleMap.get("list");
				for( Schedule schedule : scheduleList ) {
					
					Date memDelStartDate = mSimpleDateFormat.parse( schedule.getScheduleDate().toString() );
					long lCurTime = memDelStartDate.getTime();
					memDelStartDate = new java.util.Date(lCurTime+(1000*60*60*24*-1));

					System.out.println("**************"+user.getUserId()+", "+memDelStartDate+","+currentDate+"*******************");

					int compare = currentDate.compareTo( memDelStartDate ); // 날짜비교
					if( compare==0 ) { //나들이 가기 하루 전이면
						
						System.out.println("**************"+user.getUserId()+"에게 "+schedule.getScheduleNo()+"일정 알림 보냄**********************");
						
						String url = "https://fcm.googleapis.com/fcm/send";

						URL httpUrl = new URL(url);
						HttpURLConnection con = (HttpURLConnection)httpUrl.openConnection();
						con.setRequestMethod("POST");
						con.setRequestProperty("Content-Type", "application/json; UTF-8");
						con.setRequestProperty("Authorization", "key=AIzaSyALyxpRaHC2u61QfBO87SHsyGUIzXUvFVw");
						con.setDoOutput(true);
						con.setDoInput(true);

						String input = "{\"notification\" : {\"title\" : \"너,나들이~알림도착~★\", \"body\" : \"계획하신 "+schedule.getScheduleTitle()+"일정이 드디어 내일이에요!\"}, \"to\":\""+user.getToken()+"\"}";
						
				        OutputStream os = con.getOutputStream();
				        
				        //한글 깨질까봐 UTF-8로 인코딩
				        os.write(input.getBytes("UTF-8"));
				        os.flush();
				        os.close();

				        int responseCode = con.getResponseCode();
				        System.out.println("\nSending 'POST' request to URL : " + url);
				        System.out.println("Post parameters : " + input);
				        System.out.println("Response Code : " + responseCode);
				        
				        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
				        String inputLine;
				        StringBuffer response = new StringBuffer();

				        while ((inputLine = in.readLine()) != null) {
				            response.append(inputLine);
				        }
				        in.close();
				        
				        System.out.println(response.toString());
					}
				}
			}
		}
		
	} //e.o.getAlarm
	
	/*
	@PostConstruct
	@Scheduled(cron="0 0,01 * * * *")
	@RequestMapping( value="json/getFirebaseAlarm/{token}/{userId}", method=RequestMethod.GET )
	public void getAlarm( @PathVariable String token, @PathVariable String userId ) throws Exception{
		System.out.println("/notice/json/getFirebaseAlerm/{token}/{userId} : GET");
		
		//먼저 토큰으로 
		
		//여기서 해당 유저의 일정을 가져오고
		Search search = new Search();
		
		if(search==null) {
			return;
		}
		
		search.setUserId(userId);
		Map<String, Object> map = scheduleService.getMyScheduleList(search);
		List<Schedule> list = (List<Schedule>)map.get("list");

		System.out.println("==========");
		System.out.println("token : "+token);
		System.out.println(list);
		
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ( "yyyy-MM-dd" );
		Date currentDate =  mSimpleDateFormat.parse( mSimpleDateFormat.format( new Date() ) );

		for( Schedule ss : list ) {
			Date memDelStartDate = mSimpleDateFormat.parse( ss.getScheduleDate().toString() );
			long lCurTime = memDelStartDate.getTime();
			memDelStartDate = new java.util.Date(lCurTime+(1000*60*60*24*-1));
			//String scheduleDDayOne = mSimpleDateFormat.format(memDelStartDate); 
					
			//int compare = currentDate.compareTo( memDelStartDate ); // 날짜비교
			if( currentDate == memDelStartDate ) { //나들이 가기 하루 전이면
				String url = "https://fcm.googleapis.com/fcm/send";

				URL httpUrl = new URL(url);
				HttpURLConnection con = (HttpURLConnection)httpUrl.openConnection();
				con.setRequestMethod("POST");
				con.setRequestProperty("Content-Type", "application/json; UTF-8");
				con.setRequestProperty("Authorization", "key=AIzaSyALyxpRaHC2u61QfBO87SHsyGUIzXUvFVw");
				con.setDoOutput(true);
				con.setDoInput(true);

				String input = "{\"notification\" : {\"title\" : \"너,나들이~알림도착~★\", \"body\" : \"계획하신 "+ss.getScheduleTitle()+"일정이 드디어 내일이에요!\"}, \"to\":\"/topics/ALL\"}";
				
		        OutputStream os = con.getOutputStream();
		        
		        // 서버에서 날려서 한글 깨지는 사람은 아래처럼  UTF-8로 인코딩해서 날려주자
		        os.write(input.getBytes("UTF-8"));
		        os.flush();
		        os.close();

		        int responseCode = con.getResponseCode();
		        System.out.println("\nSending 'POST' request to URL : " + url);
		        System.out.println("Post parameters : " + input);
		        System.out.println("Response Code : " + responseCode);
		        
		        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
		        String inputLine;
		        StringBuffer response = new StringBuffer();

		        while ((inputLine = in.readLine()) != null) {
		            response.append(inputLine);
		        }
		        in.close();
		        
		        System.out.println(response.toString());
			}
		}
	}*/

	
	
}