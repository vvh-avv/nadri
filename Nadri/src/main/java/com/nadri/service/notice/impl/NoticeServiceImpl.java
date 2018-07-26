package com.nadri.service.notice.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import com.nadri.common.Search;
import com.nadri.service.chatroom.ChatRoomDao;
import com.nadri.service.chatroom.impl.ChatRoomDaoImpl;
import com.nadri.service.domain.Notice;
import com.nadri.service.notice.NoticeDao;
import com.nadri.service.notice.NoticeService;

@Service("noticeServiceImpl")
public class NoticeServiceImpl implements NoticeService {
	
	@Autowired
	@Qualifier("noticeDaoImpl")
	NoticeDao noticeDao ;
	
	@Override
	public void addNotice(Notice notice) {
		// TODO Auto-generated method stub
		noticeDao.addNotice(notice) ;
	}

	@Override
	public void updateNotice(int noticeNo) {
		// TODO Auto-generated method stub
		noticeDao.updateNotice(noticeNo) ;
	}

	@Override
	public List<Notice> getNoticeList(Search search , String userId) {
		// TODO Auto-generated method stub
		return noticeDao.getNoticeList(search , userId) ; 
	}
}
