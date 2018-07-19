package com.nadri.service.schedule.impl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.WayPoint;
import com.nadri.service.schedule.ScheduleDao;

@Repository("scheduleDaoImpl")
public class ScheduleDaoImpl implements ScheduleDao{
	
	///Field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	///Constructor
	public ScheduleDaoImpl() {
		System.out.println(this.getClass());
	}
	
	// 1. 일정을 추가하기 위한 메서드
	@Override
	public void addSchedule(Schedule schedule) throws Exception {
		sqlSession.insert("ScheduleMapper.addSchedule", schedule);
	}
	
	// 2. 경유지를 추가하기 위한 메서드
	@Override
	public void addWayPoint(WayPoint waypoint) throws Exception {
		sqlSession.insert("ScheduleMapper.addWayPoint", waypoint);
	}
	
	// 3. 일정상세보기를 위한 메서드
	@Override
	public Schedule getSchedule(int scheduleNo) throws Exception {
		return sqlSession.selectOne("ScheduleMapper.getSchedule", scheduleNo);
	}
	
	// 4. 일정상세보기를 위한 메서드(경유지)
	public List<WayPoint> getWayPoint(int scheduleNo) throws Exception {
		return sqlSession.selectList("ScheduleMapper.getWayPoint", scheduleNo);
	}
	
	// 5. 일정생성후 일정에 해쉬태그를 추가해주기 위한 메서드
	public void updateHashTag(String waypointTitle) throws Exception {
		sqlSession.update("ScheduleMapper.updateHashTag", waypointTitle);
	}
	
}
