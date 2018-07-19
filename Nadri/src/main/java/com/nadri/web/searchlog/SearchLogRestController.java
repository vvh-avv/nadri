package com.nadri.web.searchlog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.service.searchlog.SearchLogService;

@RestController
@RequestMapping("/restSearchLog/*")
public class SearchLogRestController {

	@Autowired
	@Qualifier("searchLogServiceImpl")
	private SearchLogService searchLogService;
	
	public SearchLogRestController() {
		System.out.println(this.getClass());
	}

}
