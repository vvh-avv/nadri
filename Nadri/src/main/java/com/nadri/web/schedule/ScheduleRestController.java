package com.nadri.web.schedule;

import java.awt.Toolkit;
import java.awt.datatransfer.Clipboard;
import java.awt.datatransfer.StringSelection;
import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.common.Search;
import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.Spot;
import com.nadri.service.domain.User;
import com.nadri.service.domain.WayPoint;
import com.nadri.service.schedule.ScheduleService;

//==> 장소관리 RestController
@RestController
@RequestMapping("/restschedule/*")
public class ScheduleRestController {
	
	///Field
	@Autowired
	@Qualifier("scheduleServiceImpl")
	private ScheduleService scheduleService;
		
	public ScheduleRestController(){
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="getTodayWeather",  method=RequestMethod.GET)
	public Map getTodayWeather() throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//현재 년도 월일
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyyMMdd");
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format ( currentTime );
		
		String apiURL = "http://newsky2.kma.go.kr/service/SecndSrtpdFrcstInfoService2/ForecastSpaceData?serviceKey=Vb0jmUo%2BoqFihhoFRCLFAblLhxt3%2FbySc4fVdPJU%2B1SmB3AXejpBHSazfVyQr232n7jNWjyUr3KtxKi0UJQuoA%3D%3D&base_date="+mTime+"&base_time=0500&nx=60&ny=127&numOfRows=100&pageSize=100&pageNo=1&startPage=1&_type=json";
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
        JSONObject weather = (JSONObject)parser.parse(response.toString());
        
        br.close();
        
        map.put("weather", weather);
		        
		return map;
	}
	
	@RequestMapping( value="getFineDust",  method=RequestMethod.GET)
	public Map getFineDust() throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		String apiURL = "http://openapi.airkorea.or.kr/openapi/services/rest/ArpltnInforInqireSvc/getCtprvnMesureLIst?serviceKey=Vb0jmUo%2BoqFihhoFRCLFAblLhxt3%2FbySc4fVdPJU%2B1SmB3AXejpBHSazfVyQr232n7jNWjyUr3KtxKi0UJQuoA%3D%3D&numOfRows=10&pageSize=10&pageNo=1&startPage=1&itemCode=PM10&dataGubun=HOUR&searchCondition=MONTH&_returnType=json";
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
        JSONObject finedust = (JSONObject)parser.parse(response.toString());
        
        br.close();
        
        map.put("finedust", finedust);
		        
		return map;
	}
	
	 //게시판에서 일정복사 눌렀을 때 실행 할 메서드
	   @RequestMapping( value="checkSchedule/{scheduleNo}", method=RequestMethod.POST)
	   public int checkSchedule( @PathVariable int scheduleNo, HttpSession session ) throws Exception{
	      System.out.println("/restschedule/checkSchedule : POST");
	      
	      User user = (User)session.getAttribute("user");
	      String scheduleImg = "copy_"+user.getUserId()+"_schedule"+scheduleNo;
	      System.out.println("@@@"+scheduleImg);
	      
	      return scheduleService.checkSchedule(scheduleImg, user.getUserId());
	   }
	   
	   //게시판에서 일정복사 요청이 들어왔을 때 실행 할 메서드
	   @RequestMapping( value="addSchedule/{scheduleNo}",  method=RequestMethod.POST ) 
	   public void addSchedule( @PathVariable int scheduleNo, HttpServletRequest request ) throws Exception{
	      System.out.println("/restschedule/addSchedule : POST");
	      
	      User user = (User)request.getSession().getAttribute("user");
	      Schedule schedule = scheduleService.getSchedule(scheduleNo);
	      schedule.setUserId(user.getUserId());
	      if( schedule.getTransportationCode()==null ) {
	         schedule.setTransportationCode("0");
	      }
	      
	      //스케줄이미지 복사
	      System.out.println("@1 이미지 복사 시작");
	      String fileName = "copy_"+user.getUserId()+"_schedule"+scheduleNo;
	      
	      System.out.println("@2 새로운 이미지 이름 : " + fileName);
	      //Path newFilePath = Paths.get(request.getRealPath("/images/schedule")+"\\"+fileName);
	      Path newFilePath = Paths.get("C:\\Users\\Bit\\git\\nadri\\Nadri\\WebContent\\images\\schedule\\"+fileName);
	      
	      System.out.println("@3 새로운 이미지 경로 : " + newFilePath);
	      //Path originFilePath = Paths.get(request.getRealPath("/images/schedule")+"\\"+schedule.getScheduleImg());
	      Path originFilePath = Paths.get("C:\\Users\\Bit\\git\\nadri\\Nadri\\WebContent\\images\\schedule\\"+schedule.getScheduleImg());
	      System.out.println("@4 원본 이미지 경로 : " + originFilePath);
	      Files.copy(originFilePath, newFilePath);
	      System.out.println("@5 이미지 복사 성공");

	      schedule.setScheduleImg( fileName );
	      
	      /*File newFile = new File("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\uploadFiles\\"+fileName);
	      MultipartFile multipartFile = (MultipartFile) newFile;
	      multipartFile.transferTo(newFile);*/

	      scheduleService.copySchedule(schedule);
	      
	      //경유지 복사 후 추가
	      List<WayPoint> waypoint = scheduleService.getWayPoint(scheduleNo);
	      for(int i=0; i<waypoint.size(); i++) {
	         waypoint.get(i).setScheduleNo(schedule.getScheduleNo());
	         scheduleService.addWayPoint(waypoint.get(i));
	      }
	   }

	   //일정을 삭제하는 메서드
	   @RequestMapping( value="deleteSchedule/{scheduleNo}",  method=RequestMethod.POST ) 
	   public void deleteSchedule( @PathVariable int scheduleNo ) throws Exception{
	      System.out.println("/restschedule/deleteSchedule : POST");
	      
	      scheduleService.deleteSchedule(scheduleNo);
	   }
	   
	   //단축 URL 생성 메서드
	   @RequestMapping( value="shortURL/{scheduleNo}", method=RequestMethod.POST )
	   public void shortURL( @PathVariable int scheduleNo ) throws Exception{
	      System.out.println("/restschedule/shortURL : POST");
	      
	      String shortURL = "";
	      
	      String clientId = "5AfhNVnshdE7BfTk171x";//애플리케이션 클라이언트 아이디값";
	        String clientSecret = "cPhvir9bp7";//애플리케이션 클라이언트 시크릿값";
	        try {
	            String text = "http://localhost:8080/schedule/getSchedule?scheduleNo="+scheduleNo;
	            String apiURL = "https://openapi.naver.com/v1/util/shorturl?url=" + text;
	            System.out.println("*"+apiURL);
	            URL url = new URL(apiURL);
	            HttpURLConnection con = (HttpURLConnection)url.openConnection();
	            con.setRequestMethod("GET");
	            con.setRequestProperty("X-Naver-Client-Id", clientId);
	            con.setRequestProperty("X-Naver-Client-Secret", clientSecret);
	            int responseCode = con.getResponseCode();
	            BufferedReader br;
	            if(responseCode==200) { // 정상 호출
	                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
	            } else {  // 에러 발생
	                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
	            }
	            String inputLine;
	            StringBuffer response = new StringBuffer();
	            while ((inputLine = br.readLine()) != null) {
	                response.append(inputLine);
	            }
	            br.close();
	            
	            //System.out.println("@넘어온 값 : "+response.toString());
	            
	            JSONObject jsonObj = (JSONObject)JSONValue.parse(response.toString());
	            shortURL = (String) ((JSONObject)jsonObj.get("result")).get("url");
	            
	            //클립보드 복사
	            StringSelection stringSelection = new StringSelection(shortURL);
	            Clipboard clpbrd = Toolkit.getDefaultToolkit().getSystemClipboard();
	            clpbrd.setContents(stringSelection, null);
	        } catch (Exception e) {
	            System.out.println(e);
	        }
	   }  
	   
	   // updateScheduleReview 리뷰를 업데이트 합니다!!
	   @RequestMapping(value="updateReview" , method=RequestMethod.POST)
	   public void updateReview(@RequestBody Schedule schedule) throws Exception{
		   
		   System.out.println(schedule);
		   
		   System.out.println("updateScheduleReview");
		   
		   scheduleService.updateScheduleReview(schedule);
	   }
	
}