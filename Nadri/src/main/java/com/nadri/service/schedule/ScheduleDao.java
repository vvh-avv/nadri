package com.nadri.service.schedule;

import java.util.List;

import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.WayPoint;

public interface ScheduleDao {
	
	// 1. 일정을 추가하기 위한 메서드
	public void addSchedule(Schedule schedule) throws Exception; 
	
	// 2. 경유지를 추가하기 위한 메서드
	public void addWayPoint(WayPoint waypoint) throws Exception;
	
	// 3. 일정상세보기를 위한 메서드(일정)
	public Schedule getSchedule(int scheduleNo) throws Exception;
	
	// 4. 일정상세보기를 위한 메서드(경유지)
	public List<WayPoint> getWayPoint(int scheduleNo) throws Exception;
	
	// 5. 일정생성후 일정에 해쉬태그를 추가해주기 위한 메서드
	public void updateHashTag(String waypointTitle) throws Exception;

}
