package com.nadri.service.schedule.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
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
	
	// 6. 마이페이지 내 일정을 보기 위한 메서드
   @Override
   public Map<String,Object> getMyScheduleList(Search search) throws Exception{
	   Map<String,Object> map = new HashMap<String,Object>();
	   List<Schedule> list = sqlSession.selectList("ScheduleMapper.getMyScheduleList", search);
	   int count = sqlSession.selectOne("ScheduleMapper.getTotalCount", search);
	   map.put("list", list);
	   map.put("totalCount", count);
	   return map;
   }

   // 7. 게시판에서 일정복사 눌렀을 때 실행 할 메서드
   @Override
   public int checkSchedule(String scheduleImg, String userId) throws Exception {
      Map<String, Object> map = new HashMap<String, Object>();
      map.put("scheduleImg", scheduleImg);
      map.put("userId", userId);
      
      return sqlSession.selectOne("ScheduleMapper.checkSchedule", map);
   }
   
   // 8. 일정 복사하기 위한 메서드
   @Override
   public void copySchedule(Schedule schedule) throws Exception {
      sqlSession.insert("ScheduleMapper.copySchedule", schedule);
   }

   // 9. 일정을 삭제하는 메서드
   @Override
   public void deleteSchedule(int scheduleNo) throws Exception {
      System.out.println("-----일정삭제");
      sqlSession.delete("ScheduleMapper.deleteSchedule", scheduleNo);
      System.out.println("-----글삭제");
      sqlSession.delete("BoardMapper.deleteBoardSchedule", scheduleNo);
      System.out.println("-----끝");
   }
   
   // 10. 일정의 review를 업데이트 합니다.
   public void updateScheduleReview(Schedule schedule) throws Exception {
	   sqlSession.update("ScheduleMapper.updateScheduleReview", schedule);
   }
	
}
