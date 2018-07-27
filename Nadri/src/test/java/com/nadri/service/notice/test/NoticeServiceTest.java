package com.nadri.service.notice.test;

import java.util.Map;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nadri.common.Search;
import com.nadri.service.domain.Notice;
import com.nadri.service.domain.User;
import com.nadri.service.notice.NoticeService;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-common.xml", "classpath:config/context-aspect.xml",
												"classpath:config/context-mybatis.xml", "classpath:config/context-transaction.xml" })
public class NoticeServiceTest {
	@Autowired
	@Qualifier("noticeServiceImpl")
	NoticeService noticeService ; 
	
	@Value("#{noticeProperties}")
	Map<String , Object> noticeCode ;

	
	//@Test
	public void addNotice() {
		Notice notice = new Notice() ;
//		notice.setContent("¾Ë¸²") ;
		notice.setNoticeCode(1) ;
		notice.setReceiverId("user01") ;
		notice.setSenderId("user02") ;
		notice.setOtherPk( 3 ) ;
		
//		notice.setOtherPk(otherPk) ;
//		notice.setNoticeCode( noticeCode ) ;
//		notice.setReceiverId(receiverId) ;
//		notice.setSenderId( ((User)session.getAttribute("user")).getUserId() );
		
		noticeService.addNotice(notice) ;
	}
	
	
	@Test
	public void getNoticeList() {

		Notice notice = new Notice() ;
		Search search = new Search() ;
		for(Notice i : noticeService.getNoticeList(search, "user01") ) {
			System.out.println( i ) ;
		}
	}
	
	//@Test
	public void updateNotice() {
		noticeService.updateNotice( 6 ) ;
	}
		
}