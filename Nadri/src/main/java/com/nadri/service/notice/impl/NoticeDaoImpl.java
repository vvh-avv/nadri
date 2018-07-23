package com.nadri.service.notice.impl;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.domain.ChatRoom;
import com.nadri.service.domain.Notice;
import com.nadri.service.notice.NoticeDao;

@Repository("noticeDaoImpl")
public class NoticeDaoImpl implements NoticeDao{
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession ;
	
	public NoticeDaoImpl() {
	
	}
	
	public NoticeDaoImpl(SqlSession sqlSession) {
		this.sqlSession = sqlSession ;
		System.out.println(sqlSession.getClass());
	}
	
	public SqlSession getSqlSession() {
		return sqlSession;
	}

	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}

	@Override
	public void addNotice(Notice notice) {
		// TODO Auto-generated method stub
		sqlSession.insert("NoticeMapper.addNotice", notice) ;
	}

	@Override
	public void updateNotice(int noticeNo) {
		// TODO Auto-generated method stub
		sqlSession.update("NoticeMapper.updateNotice", noticeNo) ;
	}

	@Override
	public List<Notice> getNoticeList(Search search , String userId) {
		// TODO Auto-generated method stub
		HashMap<String , Object> map = new HashMap<String , Object>() ;
		map.put("userId", userId) ;
		map.put("search" , search) ;
		return sqlSession.selectList("NoticeMapper.getNoticeList", map) ;
	}

}
