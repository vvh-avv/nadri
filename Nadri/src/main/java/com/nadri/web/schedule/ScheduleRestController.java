package com.nadri.web.schedule;

import java.io.BufferedReader;
import java.io.File;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.nadri.service.domain.Comment;
import com.nadri.service.domain.Schedule;
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
	public void addSchedule( @PathVariable int scheduleNo, HttpSession session ) throws Exception{
		System.out.println("/restschedule/addSchedule : POST");
		
		User user = (User)session.getAttribute("user");
		Schedule schedule = scheduleService.getSchedule(scheduleNo);
		schedule.setUserId(user.getUserId());
		if( schedule.getTransportationCode()==null ) {
			schedule.setTransportationCode("0");
		}
		
		//스케줄이미지 복사
		String fileName = "copy_"+user.getUserId()+"_schedule"+scheduleNo;
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
}