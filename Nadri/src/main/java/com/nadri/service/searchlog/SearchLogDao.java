package com.nadri.service.searchlog;

import java.util.List;

public interface SearchLogDao {
	
	public List<Object> getSearchResult(String searchKeyword);
}
