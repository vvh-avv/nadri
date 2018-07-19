package com.nadri.service.searchlog.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.service.searchlog.SearchLogDao;
import com.nadri.service.searchlog.SearchLogService;

@Service("searchLogServiceImpl")
public class SearchLogServiceImpl implements SearchLogService{
	
	@Autowired
	@Qualifier("searchLogDaoImpl")
	private SearchLogDao searchLogDao;
	
	public void setSearchLogDao(SearchLogDao searchLogDao) {
		this.searchLogDao = searchLogDao;
	}
	
	public SearchLogServiceImpl() {
		
	}

	@Override
	public List<Object> getSearchResult(String searchKeyword) {
		// TODO Auto-generated method stub
		return searchLogDao.getSearchResult(searchKeyword);
	}
}
