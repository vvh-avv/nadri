package com.nadri.service.searchlog.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import com.nadri.common.Search;
import com.nadri.service.domain.Board;
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
	public List<Object> getSearchResult(Search search) {
		
		List<Board> board_list = new ArrayList<Board>();
		List<Board> board_open = sqlSession.selectList("SearchLogMapper.boardSearchResult", search);
		
		if(search.getMemberFlag() == 0) {
	         
	         int isit = sqlSession.insert("SearchLogMapper.insertKeyword", search);
	         
	         System.out.println("insert work = "+isit);
	         /*board_list.add(sqlSession.selectList("SearchLogMapper.boardSearchResultUser", search));
	         board_list.add(sqlSession.selectList("SearchLogMapper.boardSearchResultSelf", search));*/
	         
	         List<Board> boards_1 = sqlSession.selectList("SearchLogMapper.boardSearchResultUser", search);
	         List<Board> boards_2 = sqlSession.selectList("SearchLogMapper.boardSearchResultSelf", search);
	         
	         board_list = Stream.concat(boards_1.stream(), boards_2.stream()).collect(Collectors.toList());
	         
	         board_list = Stream.concat(board_list.stream(), board_open.stream()).collect(Collectors.toList());
	         
	         System.out.println("뽑아낸 리스트 : "+board_list);
	         
	         /*int i = 0;
	         for(Object list : board_list) {
	            
	            if(list.toString().equals("[]")) {
	               board_list.remove(i);
	            }
	            i++;
	         }*/

	      }else {
	         board_list = Stream.concat(board_list.stream(), board_open.stream()).collect(Collectors.toList());
	      }
		
		List<Object> spot_list = sqlSession.selectList("SearchLogMapper.spotSearchResult", search.getSearchKeyword());
		List<Object> schedule_list = sqlSession.selectList("SearchLogMapper.scheduleSearchResult", search.getSearchKeyword());
		
		List<Object> list_all = new ArrayList<Object>();
		
		list_all.add(board_list);
		list_all.add(spot_list);
		list_all.add(schedule_list);
		
		return list_all;
	}


}
