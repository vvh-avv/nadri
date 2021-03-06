package com.nadri.web.schedule;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.apache.ibatis.annotations.Param;
import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.nadri.common.Page;
import com.nadri.common.Search;
import com.nadri.common.SuffixParsing;
import com.nadri.service.admin.AdminService;
import com.nadri.service.cart.CartService;
import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.Spot;
import com.nadri.service.domain.User;
import com.nadri.service.domain.WayPoint;
import com.nadri.service.schedule.ScheduleService;
import com.nadri.service.spot.SpotService;

//==> 일정과 관련된 메서드 Controller
@Controller
@RequestMapping("/schedule/*")
public class ScheduleController {
		
	///Field
	@Autowired
	@Qualifier("scheduleServiceImpl")
	private ScheduleService scheduleService;
	
	@Autowired
	@Qualifier("cartServiceImpl")
	private CartService cartService;
	
	@Autowired
	@Qualifier("spotServiceImpl")
	private SpotService spotService;
	
	@Autowired
	@Qualifier("adminServiceImpl")
	private AdminService adminService;

	public ScheduleController(){
		System.out.println(this.getClass());
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	int pageSize = 8;
	
	
	// addSchedule에 접근하기 위한 GET 메서드 입니다.
	@RequestMapping( value="addSchedule", method=RequestMethod.GET)
	public String addSchedule(@RequestParam("transportationCode") int transportationCode, Model model, HttpSession session, @ModelAttribute("user") User user, @ModelAttribute("search") Search search, @ModelAttribute("spot") Spot spot, @Param("date") Date date ) throws Exception{
		
		System.out.println( "/addSchedule : GET");
		
	      user = (User)session.getAttribute("user");
	      	
	      if(user==null) { //세션이 끊겼을 경우
	    	 System.out.println("session is gone");
	         return "redirect:/";
	      }
		
		// 세션에서 userId 를 가져옵니다!
		String userId=((User) session.getAttribute("user")).getUserId();
		System.out.println("session id = "+userId);
		
	      Map<String, Object> keyword = new HashMap<String , Object>() ;
	      String s = adminService.getSearchLog2(((User)session.getAttribute("user")).getUserId() ) ;
	      SuffixParsing suffixParsing = new SuffixParsing() ;
	      ArrayList<String> list = suffixParsing.parsing( s ) ;
	      if(list.size() < 2) {
	         keyword.put("keyword1"  , list.get( 0 ) ) ;
	         System.out.println( "keyword값 : " + list.get( 0 ) ) ;
	      } else {
	         for(int i = 0 ; i < 2 ; i++) {
	            keyword.put("keyword" + ( i + 1 )  , list.get( i ) ) ;
	         }
	      }
	      
	     keyword.put("size", keyword.size()) ;
	     System.out.println("size : " + keyword.get("size"));
	     
	     List<Spot> list2 = spotService.getRecommandSpotList(keyword) ;
//	      System.out.println("======================================");
//	      for(Spot i : list2) {
//	         System.out.println( i ) ;
//	      }
//	      System.out.println("======================================");
	     ArrayList<Spot> result = new ArrayList<>() ;
	      if( ((int)keyword.get("size")) == 1 ) {
	         int flag = 0 ;
	         for(int i = 0  ; i < list2.size()  ; i++) {
	            if(result.size() == 9) {
	               break ;
	            }
	            if( i == list2.size() -1) {
	               i = 0 ;
	            }
	            if(flag <= list2.size()) {
	               if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword1") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotTitle().indexOf(( (String)keyword.get("keyword1") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotTitle().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword1") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword1") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword1") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword1") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               }
	               flag++ ;
	            } else {
	               if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 || 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword2") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 || 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword2") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword2") )) != -1 || 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword1") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 || 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword2") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               }
	            }//End of else
	         }
	      } else {
	         int flag = 0 ;
	         for(int i = 0  ; i < list2.size()  ; i++) {
	            if(result.size() == 9) {
	               break ;
	            }
	            if( i == list2.size() -1) {
	               i = 0 ;
	            }
	            if(flag <= list2.size() ) {
	               if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword2") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotTitle().indexOf(( (String)keyword.get("keyword2") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotTitle().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword2") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword2") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 && 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword2") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword2") )) != -1 && 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword1") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword2") )) != -1 && 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword1") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               }
	               flag++ ;
	            }
	            else {
	               if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 || 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword2") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 || 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword2") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword2") )) != -1 || 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword1") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	               } else if( list2.get(i).getSpotAddress().indexOf(( (String)keyword.get("keyword1") )) != -1 || 
	                     list2.get(i).getSpotDetail().indexOf(( (String)keyword.get("keyword2") )) != -1 ) {
	                  result.add( list2.get(i) ) ;
	            }
	      }
	         }//End of for
	      }     
	     
		
		
		// model에 담습니다!
		model.addAttribute("cart", cartService.getSpotCartList(userId));
		model.addAttribute("recommand", result);
	    model.addAttribute("date", date);

		if (transportationCode == 1) { 
			return "forward:/schedule/addSchedulePedestrian.jsp";
		} else if (transportationCode == 2) {
			return "forward:/schedule/addScheduleTransit.jsp";
		} else {
			return "forward:/schedule/addScheduleCar.jsp";
		}
	}
	
	// addSchedule을 실행하기 위한 POST 메서드 입니다.
	@RequestMapping( value="addSchedule",  method=RequestMethod.POST)
	public String addSchedule(Model model , @ModelAttribute WayPoint waypoint , @ModelAttribute Schedule schedule, @RequestParam("file") MultipartFile multipartFile, HttpSession session) throws Exception{
		
		System.out.println( "/addSchedule : POST");
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyMMddHHmmss");
		Calendar now = Calendar.getInstance();
		String format = formatter.format(now.getTime());
		long fileSize = multipartFile.getSize();

		String fileName="";
		
		if ( fileSize <= 0) {
			//Business Logic
			schedule.setScheduleImg(fileName);
		} else {
			
			// 확장자 구하기
			int pos = multipartFile.getOriginalFilename().lastIndexOf( "." );
			fileName = format+"."+multipartFile.getOriginalFilename().substring( pos + 1 );

			//기존 파일 삭제 (혹여나 모를 상황 대비)
			new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+fileName).delete();
			
			// 파일 객체 생성
			File file = new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+fileName);
			multipartFile.transferTo(file);
			
			//Business Logic
			schedule.setScheduleImg(fileName);
		}
		

		
		// 일정 등록하는 부분
		scheduleService.addSchedule(schedule);
		
		
		// 경유지 등록하는 부분
		for(int i = 0; i < schedule.getWayPoints().size() ; i++) {
			if(schedule.getWayPoints().get(i).getWayPointTitle() == null || schedule.getWayPoints().get(i).getWayPointTitle().equals("") ) {
				break;
			} else {
				System.out.println("시작되는중 번호 :"+i);
				schedule.getWayPoints().get(i).setWayPointNo(i);
				scheduleService.addWayPoint(schedule.getWayPoints().get(i));
				scheduleService.updateHashTag(schedule.getWayPoints().get(i).getWayPointTitle());
			}
		}
		
		//가장 최근 데이터 가져옵니다.
		int maxSchedule = scheduleService.maxScheduleNo();
		
		return "redirect:/schedule/getSchedule?scheduleNo="+maxSchedule;
	}
	
	// getSchedule을 실행하기 위한 GET 메서드 입니다.
	@RequestMapping( value="getSchedule",  method=RequestMethod.GET)
	public String getSchedule(@RequestParam("scheduleNo") int scheduleNo, Model model) throws Exception{
		
		System.out.println( "/getSchedule");

		// Model 과 View 연결
		model.addAttribute("schedule", scheduleService.getSchedule(scheduleNo));
		model.addAttribute("waypoint", scheduleService.getWayPoint(scheduleNo));
		
		return "forward:/schedule/getSchedule.jsp";
	}
	
		//마이페이지 내 일정을 보기 위한 메서드 입니다.
	   @RequestMapping(value="getMyScheduleList")
	   public String getMyScheduleList(Model model, HttpSession session, @ModelAttribute("search") Search search) throws Exception{
	      System.out.println("/schedule/getMyScheduleList : GET / POST");
	      
	      User user = (User)session.getAttribute("user");
	           
	      if(user==null) { //세션이 끊겼을 경우
	         return "redirect:/";
	      }
	     
	        //페이지네비게이션 해주는 logic..
	        if(search.getCurruntPage() <= 1 ){
	         search.setCurruntPage(0);
	         search.setStartRowNum(0);
	      }else {
	         search.setStartRowNum((search.getCurruntPage()-1)*pageSize);
	      }
	      search.setPageSize(pageSize);
	        
	      search.setUserId(user.getUserId());

	       // Business logic 수행
	       Map<String, Object> map = scheduleService.getMyScheduleList(search);
	         
	      Page resultPage = new Page( search.getCurruntPage(), ((Integer)map.get("totalCount")).intValue(), pageUnit, 6);
	      System.out.println(resultPage);

	      // Model 과 View 연결
	      model.addAttribute("list", map.get("list"));
	      model.addAttribute("resultPage", resultPage);
	      model.addAttribute("search", search);
	      
	      
	      List<Schedule> list = (List<Schedule>)map.get("list");
	      
	      JSONArray jsonArray = new JSONArray();
	      for(Schedule schedule : list) {
	         JSONObject jsonObject = new JSONObject();
	         jsonObject.put("id", Integer.toString(schedule.getScheduleNo()));
	         jsonObject.put("title", schedule.getScheduleTitle());
	         jsonObject.put("start", new SimpleDateFormat("yyyy-MM-dd").format(schedule.getScheduleDate())+"T"+schedule.getStartHour());
	         jsonObject.put("className", "generalDay");
	         jsonArray.add(jsonObject);
	      }
	      
	      //월마다 반복
	      for(int i=1; i<=12; i++) {
	         String apiURL = "";
	         if(i<10) {
	            apiURL = "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo?ServiceKey=moTkip2aUv1fT8FhacDtyaJcKXWF000hyP1Iotjf%2FNyc3p%2FUTMNo8UFbsJgx0Uf4yunT7BDDSpf3d5pamt%2Fqvg%3D%3D&solYear=2018&solMonth=0"+i+"&_type=json";
	         }else {
	            apiURL = "http://apis.data.go.kr/B090041/openapi/service/SpcdeInfoService/getHoliDeInfo?ServiceKey=moTkip2aUv1fT8FhacDtyaJcKXWF000hyP1Iotjf%2FNyc3p%2FUTMNo8UFbsJgx0Uf4yunT7BDDSpf3d5pamt%2Fqvg%3D%3D&solYear=2018&solMonth="+i+"&_type=json";
	         }
	         URL url = new URL(apiURL);
	         HttpURLConnection con = (HttpURLConnection)url.openConnection();
	         con.setRequestMethod("GET");
	           int responseCode = con.getResponseCode();
	           BufferedReader br;
	           if(responseCode==200) { //정상호출
	              br = new BufferedReader(new InputStreamReader(con.getInputStream() , "UTF-8"));
	           } else { //에러발생
	              br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	           }
	           String inputLine;
	           StringBuffer response = new StringBuffer();
	           while ((inputLine = br.readLine()) != null)  {
	              response.append(inputLine);
	           }
	           JSONParser parser = new JSONParser();
	           JSONObject holiday = (JSONObject)parser.parse(response.toString()); //가져온 json 값
	           //String holidayString = (((JSONObject)((JSONObject)holiday.get("response")).get("body")).get("items")).toString(); //원하는 값만 파싱하여 String으로 전환
	           //JSONObject jsonObj = (JSONObject)parser.parse(holidayString); //
	           //JSONArray holidayArray = (JSONArray)jsonObj.get("item");
	           Long chkHolidayCnt = (Long)((JSONObject)((JSONObject)holiday.get("response")).get("body")).get("totalCount");
	           if(chkHolidayCnt==0) {
	              System.out.println("==쉬는날없엉~");
	              continue;
	           }
	           
	           JSONObject chkHoliday = (JSONObject)((JSONObject)((JSONObject)holiday.get("response")).get("body")).get("items");
	           System.out.println("**"+chkHoliday);
	           
	           if( chkHolidayCnt==1 ) {
	              JSONObject aloneHoliday = (JSONObject) chkHoliday.get("item");
	              JSONObject jsonObject3 = new JSONObject();
	             jsonObject3.put("id", "0");
	             jsonObject3.put("title", aloneHoliday.get("dateName"));
	             String tempDate = aloneHoliday.get("locdate").toString();
	             tempDate = tempDate.substring(0, 4)+"-"+tempDate.substring(4, 6)+"-"+tempDate.substring(6);
	             jsonObject3.put("start", tempDate);
	             jsonObject3.put("className", "specialDay");
	             jsonObject3.put("allDay", true);
	            jsonArray.add(jsonObject3);
	           }else {
	              JSONArray holidayArray = (JSONArray)(chkHoliday.get("item")); //원하는 값만 파싱해서 array로 만듦

	              for(int j=0 ; j<holidayArray.size() ; j++){
	                  JSONObject tempObj = (JSONObject) holidayArray.get(j);
	                JSONObject jsonObject3 = new JSONObject();
	                jsonObject3.put("id", "0");
	                jsonObject3.put("title", tempObj.get("dateName"));
	                String tempDate = tempObj.get("locdate").toString();
	                tempDate = tempDate.substring(0, 4)+"-"+tempDate.substring(4, 6)+"-"+tempDate.substring(6);
	                jsonObject3.put("start", tempDate);
	                jsonObject3.put("className", "specialDay");
	                jsonObject3.put("allDay", true);
	               jsonArray.add(jsonObject3);
	              }
	           }
	      } //월 반복 끝
	      
	        System.out.println("===============");
	        System.out.println(jsonArray.toString());
	      model.addAttribute("events_array", jsonArray.toString());
	            
	      return "forward:/user/mypageScheduleList.jsp";
	   }
   
   // updateSchedule을 실행하기 위한 GET 메서드 입니다.
	@RequestMapping( value="updateSchedule",  method=RequestMethod.GET)
	public String updateSchedule(@RequestParam("scheduleNo") int scheduleNo, Model model, HttpSession session) throws Exception{
		
		System.out.println( "/updateSchedule : GET");
		
		Schedule schedule = scheduleService.getSchedule(scheduleNo);
		int transportationCode = Integer.parseInt(schedule.getTransportationCode());
		
		
		// 세션에서 userId 를 가져옵니다!
		String userId=((User) session.getAttribute("user")).getUserId();
		
		

	      Map<String, Object> keyword = new HashMap<String , Object>() ;
	      String s = adminService.getSearchLog2(((User)session.getAttribute("user")).getUserId() ) ;
	      SuffixParsing suffixParsing = new SuffixParsing() ;
	      ArrayList<String> list = suffixParsing.parsing( s ) ;
	      if(list.size() < 2) {
	         keyword.put("keyword1"  , list.get( 0 ) ) ;
	         System.out.println( "keyword값 : " + list.get( 0 ) ) ;
	      } else {
	         for(int i = 0 ; i < 2 ; i++) {
	            keyword.put("keyword" + ( i + 1 )  , list.get( i ) ) ;
	         }
	      }
	      
	     keyword.put("size", keyword.size()) ;
	     System.out.println("size : " + keyword.get("size"));
		
		// Model 과 View 연결
		model.addAttribute("schedule", scheduleService.getSchedule(scheduleNo));
		model.addAttribute("waypoint", scheduleService.getWayPoint(scheduleNo));
		model.addAttribute("cart", cartService.getSpotCartList(userId));
		model.addAttribute("recommand", spotService.getRecommandSpotList(keyword));

		if (transportationCode == 0 ) {
			return "forward:/schedule/updateScheduleCar.jsp";
		} else if ( transportationCode == 1) {
			return "forward:/schedule/updateSchedulePedestrian.jsp";
		} else {
			return "forward:/schedule/updateScheduleTransit.jsp";
		}
	}
	
	// updateSchedule을 실행하기 위한 GET 메서드 입니다.
	@RequestMapping( value="updateSchedule",  method=RequestMethod.POST)
	public String updateSchedule(Model model , @ModelAttribute WayPoint waypoint , @ModelAttribute Schedule schedule, @RequestParam("file") MultipartFile multipartFile, HttpSession session) throws Exception{
		
	      User user = (User)session.getAttribute("user");
      	
	      if(user==null) { //세션이 끊겼을 경우
	         return "redirect:/";
	      }
		
		System.out.println( "/updateSchedule : POST");
		
		// 이전 스케쥴을 삭제합니다.
		scheduleService.deleteSchedule(schedule.getScheduleNo());
			
		SimpleDateFormat formatter = new SimpleDateFormat("yyMMddHHmmss");
		Calendar now = Calendar.getInstance();
		String format = formatter.format(now.getTime());
		//long fileSize = multipartFile.getSize();

		String fileName="";
		
		if ( multipartFile.isEmpty()) {
			//Business Logic
	    	 // new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+schedule.getScheduleImg()).delete();
	    	  //File file = new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+schedule.getScheduleImg());
	    	  //multipartFile.transferTo(file);
			fileName = schedule.getScheduleImg();
		} else {
			//fileName = format+multipartFile.getOriginalFilename();
			//기존 파일 삭제 (혹여나 모를 상황 대비)
			new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+fileName).delete();
			
			// 확장자 구하기
			int pos = multipartFile.getOriginalFilename().lastIndexOf( "." );
			fileName = format+"."+multipartFile.getOriginalFilename().substring( pos + 1 );
			
			// 파일 객체 생성
			File file = new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+fileName);
			multipartFile.transferTo(file);
			
			
			//Business Logic
			schedule.setScheduleImg(fileName);
		}
		
		// 일정 등록하는 부분
		scheduleService.addSchedule(schedule);
		
		// 경유지 등록하는 부분
		for(int i = 0; i < schedule.getWayPoints().size() ; i++) {
			System.out.println("시작되는중 번호 :"+i);
			schedule.getWayPoints().get(i).setWayPointNo(i);
			scheduleService.addWayPoint(schedule.getWayPoints().get(i));
			scheduleService.updateHashTag(schedule.getWayPoints().get(i).getWayPointTitle());
		}
		
		//가장 최근 데이터 가져옵니다.
		int maxSchedule = scheduleService.maxScheduleNo();
		
		return "redirect:/schedule/getSchedule?scheduleNo="+maxSchedule;
	}
}