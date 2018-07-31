package com.nadri.service.searchlog.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.searchlog.SearchLogDao;
import com.nadri.service.searchlog.SearchLogService;

@Service("searchLogServiceImpl")
public class SearchLogServiceImpl implements SearchLogService{
	
	//field
	@Autowired
	@Qualifier("searchLogDaoImpl")
	private SearchLogDao searchLogDao;
	
	public void setSearchLogDao(SearchLogDao searchLogDao) {
		this.searchLogDao = searchLogDao;
	}
	
	
	//constructor method
	public SearchLogServiceImpl() {
		
	}

	//method
	@Override
	public List<Object> getSearchResult(Search search) {
		// TODO Auto-generated method stub
		return searchLogDao.getSearchResult(search);
	}

	
}
