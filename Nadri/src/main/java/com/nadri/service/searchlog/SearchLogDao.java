package com.nadri.service.searchlog;

import java.util.List;

import com.nadri.common.Search;

public interface SearchLogDao {
	
	public List<Object> getSearchResult(Search search);
}
