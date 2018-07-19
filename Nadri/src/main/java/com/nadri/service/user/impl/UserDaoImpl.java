package com.nadri.service.user.impl;

import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import com.nadri.common.Search;
import com.nadri.service.domain.User;
import com.nadri.service.user.UserDao;

//회원관리Dao CRUD 구현
@Repository("userDaoImpl")
public class UserDaoImpl implements UserDao{
	
	//field
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	//Constructor method
	public UserDaoImpl() {
		System.out.println(this.getClass());
	}

	///Method
	public void addUser(User user) throws Exception {
		sqlSession.insert("UserMapper.insertUser", user);
	}

	public User getUser(String userId) throws Exception {
		return sqlSession.selectOne("UserMapper.findUser", userId);
	}
	
	public void updateUser(User user) throws Exception {
		sqlSession.update("UserMapper.updateUser", user);
	}

	public List<User> getUserList(Search search) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("search", search);
		
		return sqlSession.selectList("UserMapper.getUserList", search);
	}

	// 게시판 Page 처리를 위한 전체 Row(totalCount)  return
	public int getTotalCount(Search search) throws Exception {
		return sqlSession.selectOne("UserMapper.getTotalCount", search);
	}

	//회원 탈퇴
	@Override
	public void quitUser(String userId) throws Exception {
		// TODO Auto-generated method stub
		sqlSession.update("UserMapper.quitUser", userId);
	}
	
	//회원 아이디 찾기
	@Override
	public User findUserId(User user) throws Exception {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("UserMapper.findUserId", user);
	}

	@Override
	public Map<String, Object> getRewardList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getBoardList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getScheduleList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getCartList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Map<String, Object> getUserReportList(Search search) throws Exception {
		// TODO Auto-generated method stub
		return null;
	}


	


	
	
	////////////////////180712 예지 추가///////////////////////
	public Map<String, Object> getUserLog(String userId,int number,String duration) {
		// TODO Auto-generated method stub
		
		Map<String,Object> condition = new HashMap<String,Object>();		
		condition.put("userId", userId);
		condition.put("duration", duration);
		condition.put("number", number);
		Map<String, Object> map = new LinkedHashMap<String, Object>();
		System.out.println("dao로 연결된 userID = "+userId);
		List<Object> board_list = sqlSession.selectList("UserMapper.getBoardLog", condition);		
		System.out.println("dao에서 확인하는 board로그 : "+board_list);
		List<Object> comment_list = sqlSession.selectList("UserMapper.getCommentLog", condition);
		System.out.println("dao에서 확인하는 comment로그 : "+comment_list);
		List<Object> likes_list = sqlSession.selectList("UserMapper.getLikesLog", condition);
		System.out.println("dao에서 확인하는 likes로그 : "+likes_list);
		List<Object> inquire_list = sqlSession.selectList("UserMapper.getInquireLog", condition);
		System.out.println("dao에서 확인하는 inquire로그 : "+inquire_list);
		List<Object> report_list = sqlSession.selectList("UserMapper.getReportedLog", condition);
		System.out.println("dao에서 확인하는 report로그 : "+report_list);
		
		map.put("작성글", board_list.size());
		map.put("작성댓글", comment_list.size());
		map.put("좋아요", likes_list.size());
		map.put("문의", inquire_list.size());
		map.put("누적신고", report_list.size());
		return map;
	}





	

	
	
	
	
}