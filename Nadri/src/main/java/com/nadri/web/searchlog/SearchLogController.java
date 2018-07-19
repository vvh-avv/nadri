package com.nadri.web.searchlog;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.nadri.service.domain.Insta;
import com.nadri.service.searchlog.SearchLogService;

@Controller
@RequestMapping("/searchLog/*")
public class SearchLogController {
	
	@Autowired
	@Qualifier("searchLogServiceImpl")
	private SearchLogService searchLogService;
	
	public SearchLogController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value="listSearchLog")
	public String getSearchList(@RequestParam("searchKeyword")String searchKeyword, Model model) throws Exception {

		System.out.println("listSearchLog -> controller 들어옴");
		
		List<ArrayList> list = new ArrayList<ArrayList>();

		//instagram info
		List<Insta> insta_list = new ArrayList<Insta>();
		
		String URL = "https://www.instagram.com/explore/tags/";

		String subURL = searchKeyword;

		String thirdURL = "/?__a=1";

		subURL =  URLEncoder.encode(subURL, "UTF-8");
		
		URL = URL + subURL + thirdURL;
		
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
	    
	    JSONObject json = new JSONObject(response.toString());
	    		
		JSONObject counter = (JSONObject) ((JSONObject) ((JSONObject) (json.get("graphql"))).get("hashtag")).get("edge_hashtag_to_media");
		
		int count = counter.getInt("count");
		
		JSONArray graphql;
		
		if(count == 0) {
			graphql = (JSONArray) ((JSONObject) ((JSONObject) ((JSONObject) (json.get("graphql"))).get("hashtag"))
					.get("edge_hashtag_to_top_posts")).get("edges");
		}else {
			graphql = (JSONArray) ((JSONObject) ((JSONObject) ((JSONObject) (json.get("graphql"))).get("hashtag"))
					.get("edge_hashtag_to_media")).get("edges");
			
		}
		
		for(int i = 0; i < 12; i++) {
			Insta insta = new Insta();
			JSONObject node = (JSONObject) graphql.getJSONObject(i).get("node");
			JSONObject likeCount = node.getJSONObject("edge_liked_by");
			insta.setImg((node.getString("thumbnail_src")));
			insta.setShortLink(node.getString("shortcode"));
			int likeCounter = likeCount.getInt("count");
			insta.setLikes(Integer.toString(likeCounter));
			int xi = node.getInt("taken_at_timestamp");
			String x = Integer.toString(xi);
			long foo = Long.parseLong(x)*1000;
			Date date = new Date(foo);
			DateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			insta.setDate(formatter.format(date));
			insta_list.add(insta);
		}
		
		System.out.println("인스타 리스트의 결과 : "+insta_list);
		
		// board & spot result
		
		List<Object> list_all = searchLogService.getSearchResult(searchKeyword);
		
		List<Object> list_board = (List<Object>) list_all.get(0);
		List<Object> list_spot = (List<Object>) list_all.get(1);
		List<Object> list_schedule = (List<Object>) list_all.get(2);
		
		List<List> array = new ArrayList<List>();
		int i = 0;
		for(Object obj2:list_spot) {
			array.add(new ArrayList<Object>());
			HashMap<String,Object> json2 = (HashMap<String, Object>) obj2;
			array.get(i).add("'"+json2.get("spot_title")+"'");
			array.get(i).add(json2.get("spot_y"));
			array.get(i).add(json2.get("spot_x"));
			array.get(i).add("'"+json2.get("spot_detail")+"'");
			array.get(i).add("'"+json2.get("spot_img")+"'");
			i++;
		}
		
		System.out.println("가져온 스팟 리스트의 결과 : "+array);
		
		model.addAttribute("insta_list", insta_list);
		model.addAttribute("list_board", list_board);
		model.addAttribute("list_spot", list_spot);
		model.addAttribute("list_schedule", list_schedule);
		model.addAttribute("spot_location", array);
		
		return "/search/totalSearchView.jsp";
	}

}
