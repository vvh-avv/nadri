package com.nadri.web.spot;

import java.io.BufferedReader;
import java.io.FileInputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.nadri.service.domain.Spot;
import com.nadri.service.spot.SpotService;

//==> 장소와 관련된 메서드 Controller
@Controller
@RequestMapping("/spot/*")
public class SpotController {
	
	///Field
	@Autowired
	@Qualifier("spotServiceImpl")
	private SpotService spotService;

	public SpotController(){
		System.out.println(this.getClass());
	}
	
	///PAGENAVIGATION을 위한 프로퍼티 받아오기!
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	/*@RequestMapping( value="getSpotList",  method=RequestMethod.GET)
	public String getSpotList(Model model , HttpServletRequest request, @RequestParam("spotCode") int spotCode, Spot spot) throws Exception{
		
		System.out.println("/spot/getSpotList : GET / POST");
		
		JSONArray jsonArray = new JSONArray();
	
		// Model 과 View 연결
		model.addAttribute("list" , spotService.getSpotList(spotCode));
		
		return "forward:/spot/parkSpot.jsp";
	}*/
	
	@RequestMapping(value="getFestivalList" , method=RequestMethod.GET)
	public String getFestivalList( Model model) throws Exception{

		System.out.println("/getFestivalList");
		
		//현재 년도 월일
		SimpleDateFormat mSimpleDateFormat = new SimpleDateFormat ("yyyyMMdd");
		Date currentTime = new Date ();
		String mTime = mSimpleDateFormat.format ( currentTime );
		
		String apiURL = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=Vb0jmUo%2BoqFihhoFRCLFAblLhxt3%2FbySc4fVdPJU%2B1SmB3AXejpBHSazfVyQr232n7jNWjyUr3KtxKi0UJQuoA%3D%3D&MobileOS=ETC&areaCode=1&numOfRows=999&MobileApp=AppTest&arrange=A&listYN=Y&eventStartDate="+mTime+"&&_type=json";
		//String apiURL = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchFestival?serviceKey=Vb0jmUo%2BoqFihhoFRCLFAblLhxt3%2FbySc4fVdPJU%2B1SmB3AXejpBHSazfVyQr232n7jNWjyUr3KtxKi0UJQuoA%3D%3D&MobileOS=ETC&areaCode=1&numOfRows=999&MobileApp=AppTest&arrange=A&listYN=Y&eventStartDate=20180710&&_type=json";
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
        
        model.addAttribute("a", a);
        
        return "forward:/spot/festivalSpot.jsp";
	}
	
	@RequestMapping(value="getBikeList" , method=RequestMethod.GET)
	public String getBikeList( Model model) throws Exception{

		System.out.println("/getBikeList");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream("C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\spot\\bike.json"), "UTF8"));
		
		String inputLine;
		
		StringBuffer response = new StringBuffer();
		
		while ((inputLine = br.readLine()) != null)  {
        	response.append(inputLine);
        }
		
		 JSONParser parser = new JSONParser();
	     JSONObject bike = (JSONObject)parser.parse(response.toString());
	     
	     br.close();
		
	     model.addAttribute("bike", bike);
        
        return "forward:/spot/bikeSpot.jsp";
	}
	
	@RequestMapping(value="getRestaurantList" , method=RequestMethod.GET)
	public String getRestaurantList( Model model, @RequestParam("spotCode") int spotCode) throws Exception{

		System.out.println("/getSpotList");
		
		List<Spot> list = spotService.getSpotList(spotCode);
		JSONArray jsonArray = new JSONArray();
		
		for(Spot a : list) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("spotX", a.getSpotX());
			jsonObject.put("spotY", a.getSpotY());
			jsonObject.put("spotAddress", a.getSpotAddress());
			jsonObject.put("spotDetail", a.getSpotDetail());
			jsonObject.put("spotTitle", a.getSpotTitle());
			jsonObject.put("spotImg", a.getSpotImg());
			jsonArray.add(jsonObject);
		}
				
		model.addAttribute("list", spotService.getRestaurantList(spotCode));
		model.addAttribute("a", jsonArray);
		
        return "forward:/spot/suyoSpot.jsp";
        
	}//end of getRestaurantList
	
	@RequestMapping(value="getBabyList" , method=RequestMethod.GET)
	public String getBabyList( Model model) throws Exception{

		System.out.println("/getBabyList");
		
		List<Spot> list = spotService.getSpotList(30);
		JSONArray jsonArray = new JSONArray();
		
		for(Spot a : list) {
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("spotX", a.getSpotX());
			jsonObject.put("spotY", a.getSpotY());
			jsonObject.put("spotAddress", a.getSpotAddress());
			jsonObject.put("spotDetail", a.getSpotDetail());
			jsonObject.put("spotTitle", a.getSpotTitle());
			jsonObject.put("spotImg", a.getSpotImg());
			jsonObject.put("spotProvince", a.getSpotProvince());
			jsonArray.add(jsonObject);
		}
				
		model.addAttribute("list", spotService.getSpotList(30));
		model.addAttribute("a", jsonArray);
		
        return "forward:/spot/babySpot.jsp";
        
	}//end of getRestaurantList
	
	@RequestMapping( value="getSpot" , method=RequestMethod.GET)
    public String getProduct( @RequestParam("spotNo") int spotNo , Model model, HttpServletRequest request ) throws Exception {
      
      System.out.println("/product/getProduct : GET");
      
      //Business Logic
      Spot spot = spotService.getSpot(spotNo);
      
      spotService.updateSpotReadCnt(spot);
      
      // Model 과 View 연결
      model.addAttribute("spot", spot);
      
      return "forward:/spot/getSpot.jsp";
   }
		
}
