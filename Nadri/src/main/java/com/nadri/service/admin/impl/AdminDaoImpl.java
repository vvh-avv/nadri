package com.nadri.service.admin.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.admin.AdminDao;
import com.nadri.service.domain.Inquire;
import com.nadri.service.domain.Reward;
import com.nadri.service.domain.Spot;
import com.nadri.service.domain.User;
import com.nadri.service.domain.Weather;

@Repository("adminDaoImpl")
public class AdminDaoImpl implements AdminDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public AdminDaoImpl() {
		
	}

	@Override
	public void addInquire(Inquire inquire) {
		// TODO Auto-generated method stub
		sqlSession.insert("AdminMapper.insertInquire", inquire);
	}

	@Override
	public void updateInquire(Inquire inquire) {
		// TODO Auto-generated method stub
		System.out.println("get in updateInquire Dao");
		sqlSession.update("AdminMapper.updateInquire", inquire);
	}

	@Override
	public Inquire getInquire(int inquireNo) {
		// TODO Auto-generated method stub
		System.out.println("get in getInquire Dao");
		return sqlSession.selectOne("AdminMapper.getInquire", inquireNo);
	}

	@Override
	public void updateSpot(Spot spot) {
		// TODO Auto-generated method stub
		sqlSession.update("SpotMapper.updateSpot", spot);
	}

	@Override
	public Map<String, Object> getGraphLog(HashMap<String, Object> map) {
		// TODO Auto-generated method stub
		((Map<String, Object>) map.get("one")).put("duration","day");
		((Map<String, Object>) map.get("two")).put("duration","day");
		((Map<String, Object>) map.get("three")).put("duration","day");
		((Map<String, Object>) map.get("four")).put("duration","day");
		
		List<Date> list_board_day = sqlSession.selectList("AdminMapper.getCount", map.get("one"));
		List<Date> list_comment_day = sqlSession.selectList("AdminMapper.getCount", map.get("two"));
		List<Date> list_inquire_day = sqlSession.selectList("AdminMapper.getCount", map.get("three"));
		List<Date> list_schedule_day = sqlSession.selectList("AdminMapper.getCount", map.get("four"));
		
		((Map<String, Object>) map.get("one")).replace("duration","week");
		((Map<String, Object>) map.get("two")).replace("duration","week");
		((Map<String, Object>) map.get("three")).replace("duration","week");
		((Map<String, Object>) map.get("four")).replace("duration","week");
		
		List<Date> list_board_week = sqlSession.selectList("AdminMapper.getCount", map.get("one"));
		List<Date> list_comment_week = sqlSession.selectList("AdminMapper.getCount", map.get("two"));
		List<Date> list_inquire_week = sqlSession.selectList("AdminMapper.getCount", map.get("three"));
		List<Date> list_schedule_week = sqlSession.selectList("AdminMapper.getCount", map.get("four"));
		
		((Map<String, Object>) map.get("one")).replace("duration","month");
		((Map<String, Object>) map.get("two")).replace("duration","month");
		((Map<String, Object>) map.get("three")).replace("duration","month");
		((Map<String, Object>) map.get("four")).replace("duration","month");
		
		List<Date> list_board_month = sqlSession.selectList("AdminMapper.getCount", map.get("one"));
		List<Date> list_comment_month = sqlSession.selectList("AdminMapper.getCount", map.get("two"));
		List<Date> list_inquire_month = sqlSession.selectList("AdminMapper.getCount", map.get("three"));
		List<Date> list_schedule_month = sqlSession.selectList("AdminMapper.getCount", map.get("four"));
		
		Map<String,Object> returnmap = new HashMap<String,Object>();

		returnmap.put("list_board_day", list_board_day);
		System.out.println("check day list = "+list_board_day);
		returnmap.put("list_comment_day", list_comment_day);
		returnmap.put("list_inquire_day", list_inquire_day);
		returnmap.put("list_schedule_day", list_schedule_day);
		
		returnmap.put("list_board_week", list_board_week);
		System.out.println("check week list = "+list_board_week);
		returnmap.put("list_comment_week", list_comment_week);
		returnmap.put("list_inquire_week", list_inquire_week);
		returnmap.put("list_schedule_week", list_schedule_week);
		
		returnmap.put("list_board_month", list_board_month);
		System.out.println("list board list = "+list_board_month);
		returnmap.put("list_comment_month", list_comment_month);
		returnmap.put("list_inquire_month", list_inquire_month);
		returnmap.put("list_schedule_month", list_schedule_month);
		
		return returnmap;
	}

	@Override
	public int blockUser(String userId) {
		// TODO Auto-generated method stub
		return sqlSession.update("AdminMapper.blockUser", userId);		
	}

	@Override
	public List<User> latestRegUsers() {
		// TODO Auto-generated method stub
		List<User> list = sqlSession.selectList("AdminMapper.latestRegUser");
		return list;
	}

	@Override
	public Map<String, Object> getUserList(Search search) {
		// TODO Auto-generated method stub
		Map<String,Object> map= new HashMap<String,Object>();
		List<User> list = sqlSession.selectList("AdminMapper.getUserList", search);
		int count = sqlSession.selectOne("AdminMapper.getTotalCount", search);
		map.put("list", list);
		map.put("totalCount", count);
		return map;
	}

	@Override
	public Map<String, Object> getSpotList(Search search) {
		// TODO Auto-generated method stub
		Map<String,Object> map= new HashMap<String,Object>();
		List<Spot> list = sqlSession.selectList("AdminMapper.getSpotList", search);
		int count = sqlSession.selectOne("AdminMapper.getSpotCount", search);
		map.put("list", list);
		map.put("totalCount", count);
		return map;
	}

	@Override
	public Map<String, Object> getInquireList(Search search) {
		// TODO Auto-generated method stub
		Map<String,Object> map= new HashMap<String,Object>();
		List<Spot> list = sqlSession.selectList("AdminMapper.getInquireList", search);
		int count = sqlSession.selectOne("AdminMapper.getInquireCount", search);
		map.put("list", list);
		map.put("totalCount", count);
		return map;
	}

	@Override
	public void getReward(Reward reward) {
		// TODO Auto-generated method stub
		sqlSession.insert("AdminMapper.getReward", reward);
	}

	@Override
	public void addWeather(Weather weather) {
		// TODO Auto-generated method stub
		sqlSession.insert("AdminMapper.addWeather", weather);
	}

	@Override
	public String getWeather() {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("AdminMapper.getWeather");
	}

	@Override
	public int getTotalCount() {
		// TODO Auto-generated method stub
		int a = sqlSession.selectOne("SearchLogMapper.spotCount");
		int b = sqlSession.selectOne("SearchLogMapper.boardCount");
		int c = sqlSession.selectOne("SearchLogMapper.scheduleCount");
		return a+b+c;
	}

	@Override
	public List<String> getSearchLog(String userId) {
		// TODO Auto-generated method stub
		return sqlSession.selectList("SearchLogMapper.getSearchLog", userId);
	}


}