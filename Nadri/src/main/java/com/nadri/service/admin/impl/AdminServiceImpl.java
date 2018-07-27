package com.nadri.service.admin.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.admin.AdminDao;
import com.nadri.service.admin.AdminService;
import com.nadri.service.domain.Inquire;
import com.nadri.service.domain.Reward;
import com.nadri.service.domain.Spot;
import com.nadri.service.domain.User;
import com.nadri.service.domain.Weather;

@Service("adminServiceImpl")
public class AdminServiceImpl implements AdminService{
	
	@Autowired
	@Qualifier("adminDaoImpl")
	private AdminDao adminDao;
	
	public void setAdminDao(AdminDao adminDao) {
		this.adminDao = adminDao;
	}
	
	public AdminServiceImpl() {
		
	}

	@Override
	public void addInquire(Inquire inquire) {
		// TODO Auto-generated method stub
		adminDao.addInquire(inquire);
	}

	@Override
	public void updateInquire(Inquire inquire) {
		// TODO Auto-generated method stub
		System.out.println("get in updateInquire");
		adminDao.updateInquire(inquire);
	}

	@Override
	public Inquire getInquire(int inquireNo) {
		// TODO Auto-generated method stub
		return adminDao.getInquire(inquireNo);
	}

	@Override
	public void updateSpot(Spot spot) {
		// TODO Auto-generated method stub
		adminDao.updateSpot(spot);
	}

	@Override
	public Map<String, Object> getGraphLog(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		return adminDao.getGraphLog(map);
	}

	@Override
	public int blockUser(String userId) {
		// TODO Auto-generated method stub
		return adminDao.blockUser(userId);
	}

	@Override
	public List<User> latestRegUsers() {
		// TODO Auto-generated method stub
		return adminDao.latestRegUsers();
	}

	@Override
	public Map<String, Object> getUserList(Search search) {
		// TODO Auto-generated method stub
		return adminDao.getUserList(search);
	}

	@Override
	public Map<String, Object> getSpotList(Search search) {
		// TODO Auto-generated method stub
		return adminDao.getSpotList(search);
	}

	@Override
	public Map<String, Object> getInquireList(Search search) {
		// TODO Auto-generated method stub
		return adminDao.getInquireList(search);
	}

	@Override
	public void getReward(Reward reward) {
		// TODO Auto-generated method stub
		adminDao.getReward(reward);
	}

	@Override
	public void addWeather(Weather weather) {
		// TODO Auto-generated method stub
		adminDao.addWeather(weather);
	}

	@Override
	public String getWeather() {
		// TODO Auto-generated method stub
		return adminDao.getWeather();
	}
	
	


}
