package com.nadri.service.admin;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.nadri.common.Search;
import com.nadri.service.domain.Inquire;
import com.nadri.service.domain.Reward;
import com.nadri.service.domain.Spot;
import com.nadri.service.domain.User;
import com.nadri.service.domain.Weather;

public interface AdminDao {
	
	public void addInquire(Inquire inquire);
	
	public Map<String,Object> getInquireList(Search search);

	public void updateInquire(Inquire inquire);
	
	public Inquire getInquire(int inquireNo);
	
	public void updateSpot(Spot spot);
	
	public Map<String,Object> getGraphLog(HashMap<String, Object> map);
	
	public int blockUser(String userId);
	
	public List<User> latestRegUsers();
	
	public Map<String,Object> getUserList(Search search);
	
	public Map<String,Object> getSpotList(Search search);
	
	public void getReward(Reward reward);
	
	public void addWeather(Weather weather);
	
	public String getWeather();
	
	public int getTotalCount();
	
	public List<String> getSearchLog(String userId);

}