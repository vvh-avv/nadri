package com.nadri.web.searchlog;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
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
	
	@RequestMapping(value ="getSearchLog/{userId}", method=RequestMethod.GET)
	public String getSearchLog(@PathVariable String userId) {
		System.out.println("userId = "+userId);
		return "return";
	}

}
