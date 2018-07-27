package com.nadri.web.nadri;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.nadri.common.Search;
import com.nadri.service.admin.AdminService;
import com.nadri.service.board.BoardService;
import com.nadri.service.domain.Board;
import com.nadri.service.domain.User;
import com.nadri.service.domain.Weather;
import com.nadri.service.spot.SpotService;
import com.nadri.service.user.UserService;

@Controller
@RequestMapping(value = "/nadri")
public class NadriController {
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("adminServiceImpl")
	private AdminService adminService;

	@Autowired
	@Qualifier("spotServiceImpl")
	private SpotService spotService;
	
	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	@RequestMapping("/nadriIndex")
	public String getIndex(HttpSession session,HttpServletRequest request,Model model) throws Exception {
		System.out.println("main 구성하기위한 컨트롤러 진입");
		
		session = request.getSession(true);
		User user = (User)session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		Search search = new Search();
		
		search.setSearchCondition("주간");
		
		List<Board> board_list = boardService.getRecomBoard(search);
		List<Board> board_list2 = new ArrayList<Board>();
		
		for(Board board:board_list) {
			System.out.println(board);
			System.out.println("boardList 의 이미지 = "+board.getBoardImg());
			if(board.getBoardImg().equals("no_img")) {
				board.setBoardImg("no_image.jpg");
			}else {
				if (board.getBoardImg().contains(",")) {
					int comma = board.getBoardImg().indexOf(",");
					String imgSingle = board.getBoardImg().substring(0, comma);
					board.setBoardImg(imgSingle);
				}else {
					System.out.println("1개의 정상적 이미지만 가진 착한 게시물");
				}			
			}
		}
		
		System.out.println(board_list);
		System.out.println(board_list.size());
		
		String weatherName = adminService.getWeather();
		String videoName;
		
		if(weatherName.equals("normal")) {
			videoName = "video10";
		}else if(weatherName.equals("rain")) {
			videoName = "jy3";
		}else if(weatherName.equals("snow")) {
			videoName = "js2";
		}else {
			videoName = "js3";
		}
		
		model.addAttribute("boardList",board_list);
		model.addAttribute("videoName",videoName);
		model.addAttribute("nadriCounter",3785);
		
		return "/indexReal.jsp";
	}
	
	@PostConstruct
	@Scheduled(cron="0 0,30 * * * *")
	@RequestMapping(value="postSend.do", method={RequestMethod.GET, RequestMethod.POST})
	public void postSend() throws Exception {
		
		String URL = "http://api.openweathermap.org/data/2.5/weather?q=Seoul&appid=18ad3631f76213b184ed18274ec816fe";
		
		URL obj = new URL(URL);
		
		HttpURLConnection con = (HttpURLConnection) obj.openConnection();
	    // optional default is GET
	    con.setRequestMethod("GET");
	    //add request header
	    con.setRequestProperty("User-Agent", "Mozilla/5.0");
	    String returnMsg = con.getResponseMessage();
	    int responseCode = con.getResponseCode();
	    System.out.println("\nSending 'GET' request to URL : " + URL);
	    System.out.println("Response Code : " + responseCode+" "+returnMsg);
	    BufferedReader in = new BufferedReader(
	            new InputStreamReader(con.getInputStream()));
	    String inputLine;
	    StringBuffer response = new StringBuffer();
	    while ((inputLine = in.readLine()) != null) {
	    	response.append(inputLine);
	    }
	    in.close();
	    
	    System.out.println("response : "+response);
	    
	    JSONObject json = new JSONObject(response.toString());
	    
	    JSONArray weather = (JSONArray)json.get("weather");
	    
	    JSONObject weather_list = weather.getJSONObject(0);
	    
	 	int weather_code = weather_list.getInt("id");
	 		    
	    System.out.println("날씨 코드 : "+weather_code);
	    
	    Properties prop = new Properties();
	    ClassLoader clazzLoader = Thread.currentThread().getContextClassLoader();
	    InputStream s = clazzLoader.getResourceAsStream("/weatherCode.properties");
	     
	    try{
	        prop.load(s);
	    } catch (IOException e){
	        e.printStackTrace();
	    }
	      
	    String name = prop.getProperty(String.valueOf(weather_code));
	    
	    System.out.println("지금 날씨는 = "+name);
	    
	    Weather w = new Weather();
	    
	    w.setWeatherCode(weather_code);
	    w.setWeatherName(name);
	    
	    adminService.addWeather(w);
	}

}
