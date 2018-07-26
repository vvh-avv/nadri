package com.nadri.service.schedule.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.WayPoint;
import com.nadri.service.schedule.ScheduleDao;
import com.nadri.service.schedule.ScheduleService;

@Service("scheduleServiceImpl")
public class ScheduleServiceImpl implements ScheduleService{

	///Field
	@Autowired
	@Qualifier("scheduleDaoImpl")
	
	///Constructor
	private ScheduleDao scheduleDao;
	
	///Method
	public void setScheduleDao(ScheduleDao scheduleDao) {
		this.scheduleDao=scheduleDao;
	}
	
	///Constructor
	public ScheduleServiceImpl() {
		System.out.println(this.getClass());
	}
	
	// 1. 일정을 추가하기 위한 메서드
	@Override
	public void addSchedule(Schedule schedule) throws Exception {
		scheduleDao.addSchedule(schedule);
	}
	
	// 2. 경유지를 추가하기 위한 메서드
	@Override
	public void addWayPoint(WayPoint waypoint) throws Exception {
		scheduleDao.addWayPoint(waypoint);
	}

	// 3. 일정상세보기를 위한 메서드
	@Override
	public Schedule getSchedule(int scheduleNo) throws Exception {
		return scheduleDao.getSchedule(scheduleNo);
	}
	
	// 4. 일정상세보기를 위한 메서드(경유지)
	@Override
	public List<WayPoint> getWayPoint(int scheduleNo) throws Exception {
		return scheduleDao.getWayPoint(scheduleNo);
	}
	
	// 5. 일정생성후 일정에 해쉬태그를 추가해주기 위한 메서드
	@Override
	public void updateHashTag(String waypointTitle) throws Exception {
		scheduleDao.updateHashTag(waypointTitle);
	}
	
	// 6. 마이페이지 내 일정을 보기 위한 메서드
   @Override
   public List<Schedule> getMyScheduleList(String userId) throws Exception {
      return scheduleDao.getMyScheduleList(userId);
   }

   // 7. 게시판에서 일정복사 눌렀을 때 실행 할 메서드
   @Override
   public int checkSchedule(String scheduleImg, String userId) throws Exception {
      return scheduleDao.checkSchedule(scheduleImg, userId);
   }
   
   // 8. 일정 복사하기 위한 메서드
   @Override
   public void copySchedule(Schedule schedule) throws Exception{
      scheduleDao.copySchedule(schedule);
   }

   // 9. 일정을 삭제하는 메서드
   @Override
   public void deleteSchedule(int scheduleNo) throws Exception {
      scheduleDao.deleteSchedule(scheduleNo);
   }

}
