package com.nadri.service.board.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nadri.service.board.impl.BoardServiceImpl;
import com.nadri.service.domain.Board;
import com.nadri.service.domain.User;

import junit.framework.Assert;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-common.xml", "classpath:config/context-aspect.xml",
												"classpath:config/context-mybatis.xml", "classpath:config/context-transaction.xml" })
public class BoardServiceTest {

	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardServiceImpl boardService;
	
	@Test
	public void addBoard() throws Exception{
		Board board = new Board();
		User user = new User();
		
		user.setUserId("testId");
		user.setUserName("testName");
		board.setUser(user);
		board.setBoardTitle("testTitle");
		board.setBoardContent("testContent");
		board.setBoardImg("test.jpg");
		board.setOpenRange("0");
		board.setHashTag("#test");
		board.setBoardCode(1);
		
		boardService.addBoard(board);
		System.out.println("testAddBoard() board : "+board);
		
		Assert.assertEquals("testTitle", board.getBoardTitle());
		Assert.assertEquals("testCode", board.getBoardCode());
	}
}
