package com.nadri.service.notice;

import java.util.List;

import com.nadri.common.Search;
import com.nadri.service.domain.Notice;

public interface NoticeDao {
	
	public void addNotice(Notice notice) ;
	
	public void updateNotice(int noticeNo) ;
	
	public List<Notice> getNoticeList(Search search , String userId) ;
}
