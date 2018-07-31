package com.nadri.service.searchlog.impl;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.service.searchlog.SearchLogDao;

@Repository("searchLogDaoImpl")
public class SearchLogDaoImpl implements SearchLogDao {
	
	@Autowired
	@Qualifier("sqlSessionTemplate")
	private SqlSession sqlSession;
	
	public void setSqlSession(SqlSession sqlSession) {
		this.sqlSession = sqlSession;
	}
	
	public SearchLogDaoImpl() {
		
	}

	@Override
	public List<Object> getSearchResult(String searchKeyword) {
		List<Object> board_list = sqlSession.selectList("SearchLogMapper.boardSearchResult", searchKeyword);
		List<Object> spot_list = sqlSession.selectList("SearchLogMapper.spotSearchResult", searchKeyword);
		List<Object> schedule_list = sqlSession.selectList("SearchLogMapper.scheduleSearchResult", searchKeyword);
		
		List<Object> list_all = new ArrayList<Object>();
		
		list_all.add(board_list);
		list_all.add(spot_list);
		list_all.add(schedule_list);
		
		return list_all;
	}


}
