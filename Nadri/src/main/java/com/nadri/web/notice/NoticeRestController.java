package com.nadri.web.notice;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nadri.common.Search;
import com.nadri.service.domain.Notice;
import com.nadri.service.domain.User;
import com.nadri.service.notice.NoticeService;

@Controller
@RequestMapping("/notice/*")
public class NoticeRestController {
	
	@Autowired
	@Qualifier("noticeServiceImpl")
	NoticeService noticeService ;

	@Value("#{noticeProperties}")
	Map<String , Object> noticeMap ;
	
	@ResponseBody
	@RequestMapping( value="json/addNotice", method=RequestMethod.POST  )
	public void addNotice( @RequestBody Notice notice ) {
		System.out.println("json/addNotice 받은 데이터 : " + notice) ;
		noticeService.addNotice( notice ) ;
	}
	
	@ResponseBody
	@RequestMapping( value="json/getNoticeList", method=RequestMethod.POST )
	public Map<String , Object> getNoticeList( Search search , HttpSession session) {
		
		System.out.println( "json/getNoticeList" ) ;
		
		List<Notice> noticeList = noticeService.getNoticeList(search, ((User)session.getAttribute("user")).getUserId()) ;
		Map<String , Object> notice = new HashMap<String , Object>() ;
		
		for(int i = 0 ; i < noticeList.size() ; i++) {
			noticeList.get(i).setContent( noticeList.get(i).getSenderId() + noticeMap.get( noticeList.get( i ).getNoticeCode() + "") ) ;
		}
		
		notice.put("noticeList" , noticeList) ;
		notice.put("noticeMap" , noticeMap) ;
		
		return notice ;
	}
}