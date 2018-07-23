package com.nadri.web.spot;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

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
		
		map.put("spot", spotService.getAllSpotList(spotCode));
		
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
	
}