package com.nadri.web.searchlog;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.service.admin.AdminService;
import com.nadri.service.searchlog.SearchLogService;

@RestController
@RequestMapping("/restSearchLog/*")
public class SearchLogRestController {

	@Autowired
	@Qualifier("searchLogServiceImpl")
	private SearchLogService searchLogService;
	
	@Autowired
	@Qualifier("adminServiceImpl")
	private AdminService adminService;
	
	public SearchLogRestController() {
		System.out.println(this.getClass());
	}
	
	@RequestMapping(value ="getSearchLog/{userId}", method=RequestMethod.GET)
	public List getSearchLog(@PathVariable String userId) {
		System.out.println("userId = "+userId);
		List<String> list = adminService.getSearchLog(userId);
		return list;
	}
}
