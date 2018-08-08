package com.nadri.web.spot;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.math.BigDecimal;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.common.Search;
import com.nadri.service.domain.Spot;
import com.nadri.service.spot.SpotService;

//==> 장소관리 RestController
@RestController
@RequestMapping("/restspot/*")
public class SpotRestController {
	
	///Field
	@Autowired
	@Qualifier("spotServiceImpl")
	private SpotService spotService;
		
	public SpotRestController(){
		System.out.println(this.getClass());
	}
	
	///PAGENAVIGATION을 위한 프로퍼티 받아오기!
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@RequestMapping( value="getSpotList/{spotCode}",  method=RequestMethod.GET)
	public Map getSpotList(@PathVariable int spotCode) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("spot", spotService.getSpotList(spotCode));
		
		return map;
	}
	
	@RequestMapping( value="getRiverList/{spotCode}",  method=RequestMethod.GET)
	public Map getRiverList(@PathVariable int spotCode) throws Exception{
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		map.put("spot", spotService.getRiverList(spotCode));
		
		return map;
	}
		
	@RequestMapping(value="/infinityscrollDown" , method=RequestMethod.POST)
	public @ResponseBody List<Spot> infinityscrollDown(@RequestBody Spot spot) throws Exception{

		System.out.println("/infinityscrollDown");
	
		return spotService.infiniteScrollDown(spot);
	}//end of infinityscroll
	
	@RequestMapping(value="/searchAround" , method=RequestMethod.POST)
	public @ResponseBody List<Spot> searchAround(@RequestBody Spot spot) throws Exception{

		System.out.println("/searchAround");
			
		return spotService.searchAround(spot);
	}//end of searchArround
	
	@RequestMapping(value="/searchAroundRestaurant" , method=RequestMethod.POST)
	public @ResponseBody List<Spot> searchAroundRestaurant(@RequestBody Spot spot) throws Exception{

		System.out.println("/searchAroundRestaurant");
			
		return spotService.searchAroundRestaurant(spot);
	}//end of searchArround
	
	@RequestMapping(value="/getSearchSpotList" , method=RequestMethod.POST)
	public @ResponseBody List<Spot> getSearchSpotList(@RequestBody Search search) throws Exception{

		System.out.println("/getSearchSpotList");
	
		return spotService.getSearchSpotList(search);
	}//end of getSearchSpotList
	
	@RequestMapping(value="/searchAroundRest" , method=RequestMethod.GET)
	public @ResponseBody List<Spot> searchAroundRest(HttpServletRequest request) throws Exception{
		
		BigDecimal spotX = new BigDecimal(request.getParameter("spotX"));
		BigDecimal spotY = new BigDecimal(request.getParameter("spotY"));
		
		//spot을 만들어 줍니다.
		Spot spot = new Spot();
		spot.setSpotX(spotX);
		spot.setSpotY(spotY);
			
		return spotService.searchAround(spot);
	}//end of searchArround
	
	@RequestMapping(value="/getSpotListRest", method=RequestMethod.GET)
	public List<Spot> getSpotListRest(HttpServletRequest request )throws Exception{
		
		System.out.println("/getSpotRest: GET");
		
		String searchCondition = request.getParameter("searchCondition");
		String searchKeyword = request.getParameter("searchKeyword");
		int searchSpot = Integer.parseInt(request.getParameter("searchSpot"));
		
		// searh에 담아 줍니다.
		Search search = new Search();
		search.setSearchCondition(searchCondition);
		search.setSearchKeyword(searchKeyword);
		search.setSearchSpot(searchSpot);
		
		return spotService.getSpotListRest(search);
	}
	
	@RequestMapping(value="/getSpotRest/{spotNo}", method=RequestMethod.GET)
	public Spot getSpotRest(@PathVariable int spotNo)throws Exception{
		
		System.out.println("/getSpotRest: GET");
		
		return spotService.getSpot(spotNo);
	}
	
	@RequestMapping(value="getFestivalListRest" , method=RequestMethod.GET)
	public JSONArray getFestivalList() throws Exception{

		System.out.println("/getFestivalList");
		
		//현재 년도 월일
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyyMMdd");
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format ( currentTime );
		
		String apiURL = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=Vb0jmUo%2BoqFihhoFRCLFAblLhxt3%2FbySc4fVdPJU%2B1SmB3AXejpBHSazfVyQr232n7jNWjyUr3KtxKi0UJQuoA%3D%3D&MobileOS=ETC&areaCode=1&numOfRows=999&MobileApp=AppTest&arrange=B&listYN=Y&eventStartDate="+mTime+"&&_type=json";
		//String apiURL = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=Vb0jmUo%2BoqFihhoFRCLFAblLhxt3%2FbySc4fVdPJU%2B1SmB3AXejpBHSazfVyQr232n7jNWjyUr3KtxKi0UJQuoA%3D%3D&MobileOS=ETC&areaCode=1&numOfRows=999&MobileApp=AppTest&arrange=B&listYN=Y&eventStartDate=20180710&&_type=json";
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
        JSONObject a = (JSONObject)parser.parse(response.toString());
        br.close();
      
        return  (JSONArray) (((JSONObject) ((JSONObject) ((JSONObject) a.get("response")).get("body")).get("items"))).get("item");
	}
	
	@RequestMapping(value="getFestivalRest/{spotNo}" , method=RequestMethod.GET)
	public JSONObject getFestival(@PathVariable int spotNo) throws Exception{

		System.out.println("/getFestival");
		
		String apiURL = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/detailCommon?ServiceKey=Vb0jmUo%2BoqFihhoFRCLFAblLhxt3%2FbySc4fVdPJU%2B1SmB3AXejpBHSazfVyQr232n7jNWjyUr3KtxKi0UJQuoA%3D%3D&contentId="+spotNo+"&defaultYN=Y&addrinfoYN=Y&overviewYN=Y&mapinfoYN=Y&firstImageYN=Y&MobileOS=ETC&MobileApp=AppTest&_type=json";
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
        JSONObject a = (JSONObject)parser.parse(response.toString());
        
        br.close();
                
        return (JSONObject) ((JSONObject) ((JSONObject) ((JSONObject) a.get("response")).get("body")).get("items")).get("item")	;
	}
	
}