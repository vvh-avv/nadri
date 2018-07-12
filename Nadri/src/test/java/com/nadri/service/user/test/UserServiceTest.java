package com.nadri.service.user.test;

import java.util.List;
import java.util.Map;

import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.nadri.common.Search;
import com.nadri.service.domain.User;
import com.nadri.service.user.impl.UserServiceImpl;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = { "classpath:config/context-common.xml", "classpath:config/context-aspect.xml",
												"classpath:config/context-mybatis.xml", "classpath:config/context-transaction.xml" })
public class UserServiceTest {

	@Autowired
	@Qualifier("userServiceImpl")
	private UserServiceImpl userService;

	//@Test
	public void testAddUser() throws Exception {
		
		User user = new User();
		user.setUserId("testUserId");
		user.setUserName("testUserName");
		user.setPassword("testPasswd");
/*		user.setSsn("1111112222222");
		user.setPhone("111-2222-3333");
		user.setAddr("경기도");*/
		user.setEmail("test@test.com");
		
		userService.addUser(user);
		
		user = userService.getUser("testUserId");

		//==> console 확인
		System.out.println("testAddUser() user : "+user);
		
		//==> API 확인
		Assert.assertEquals("testUserId", user.getUserId());
		Assert.assertEquals("testUserName", user.getUserName());
		Assert.assertEquals("testPasswd", user.getPassword());
/*		Assert.assertEquals("111-2222-3333", user.getPhone());
		Assert.assertEquals("경기도", user.getAddr());*/
		Assert.assertEquals("test@test.com", user.getEmail());
	}
	
	//@Test
	public void testGetUser() throws Exception {
		
		User user = new User();
		//==> 필요하다면...
//		user.setUserId("testUserId");
//		user.setUserName("testUserName");
//		user.setPassword("testPasswd");
//		user.setSsn("1111112222222");
//		user.setPhone("111-2222-3333");
//		user.setAddr("경기도");
//		user.setEmail("test@test.com");
		
		user = userService.getUser("testUserId");

		//==> console 확인
		System.out.println("testGetUser() user : "+user);
		
		//==> API 확인
		Assert.assertEquals("testUserId", user.getUserId());
		Assert.assertEquals("testUserName", user.getUserName());
		Assert.assertEquals("testPasswd", user.getPassword());
/*		Assert.assertEquals("111-2222-3333", user.getPhone());
		Assert.assertEquals("경기도", user.getAddr());*/
		Assert.assertEquals("test@test.com", user.getEmail());

		Assert.assertNotNull(userService.getUser("user02"));
		Assert.assertNotNull(userService.getUser("user05"));
	}
	
	//@Test
	 public void testUpdateUser() throws Exception{
		 
		User user = userService.getUser("testUserId");
		Assert.assertNotNull(user);
		
		Assert.assertEquals("testUserName", user.getUserName());
/*		Assert.assertEquals("111-2222-3333", user.getPhone());
		Assert.assertEquals("경기도", user.getAddr());*/
		Assert.assertEquals("test@test.com", user.getEmail());

		user.setUserName("change");
/*		user.setPhone("777-7777-7777");
		user.setAddr("change");*/
		user.setEmail("change@change.com");
		
		userService.updateUser(user);
		
		user = userService.getUser("testUserId");
		Assert.assertNotNull(user);
		
		//==> console 확인
		System.out.println("testUpdateUser() user : "+user);
			
		//==> API 확인
		Assert.assertEquals("change", user.getUserName());
/*		Assert.assertEquals("777-7777-7777", user.getPhone());
		Assert.assertEquals("change", user.getAddr());*/
		Assert.assertEquals("change@change.com", user.getEmail());
	 }
	 
	//@Test
	public void testCheckDuplication() throws Exception{

		//==> 필요하다면...
//		User user = new User();
//		user.setUserId("testUserId");
//		user.setUserName("testUserName");
//		user.setPassword("testPasswd");
//		user.setSsn("1111112222222");
//		user.setPhone("111-2222-3333");
//		user.setAddr("경기도");
//		user.setEmail("test@test.com");
//		
//		userService.addUser(user);
		
		//==> console 확인
		System.out.println("testCheckDuplication()1 : "+userService.checkDuplication("testUserId"));
		System.out.println("testCheckDuplication()2 : "+userService.checkDuplication("testUserId"+System.currentTimeMillis()) );
	 	
		//==> API 확인
		Assert.assertFalse( userService.checkDuplication("testUserId") );
	 	Assert.assertTrue( userService.checkDuplication("testUserId"+System.currentTimeMillis()) );
		 	
	}
	
	 //==>  주석을 풀고 실행하면....
	 @Test
	 public void testGetUserListAll() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	Map<String,Object> map = userService.getUserList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println("testGetUserListAll() list1 : "+list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println("testGetUserListAll() totalCount : "+totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("");
	 	map = userService.getUserList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
	 	//==> console 확인
	 	System.out.println("testGetUserListAll() list2 : "+list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 
	 //@Test
	 public void testGetUserListByUserId() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword("admin");
	 	Map<String,Object> map = userService.getUserList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(1, list.size());
	 	
		//==> console 확인
	 	System.out.println("testGetUserListByUserId() list1 : "+list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println("testGetUserListByUserId() totalCount : "+totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("0");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = userService.getUserList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	System.out.println("testGetUserListByUserId()2 list : "+list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println(totalCount);
	 }
	 
	 //@Test
	 public void testGetUserListByUserName() throws Exception{
		 
	 	Search search = new Search();
	 	search.setCurrentPage(1);
	 	search.setPageSize(3);
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword("SCOTT");
	 	Map<String,Object> map = userService.getUserList(search);
	 	
	 	List<Object> list = (List<Object>)map.get("list");
	 	Assert.assertEquals(3, list.size());
	 	
		//==> console 확인
	 	System.out.println("testGetUserListByUserName() list1 : "+list);
	 	
	 	Integer totalCount = (Integer)map.get("totalCount");
	 	System.out.println("testGetUserListByUserName() totalCount1 : "+totalCount);
	 	
	 	System.out.println("=======================================");
	 	
	 	search.setSearchCondition("1");
	 	search.setSearchKeyword(""+System.currentTimeMillis());
	 	map = userService.getUserList(search);
	 	
	 	list = (List<Object>)map.get("list");
	 	Assert.assertEquals(0, list.size());
	 	
		//==> console 확인
	 	System.out.println("testGetUserListByUserName() list2 : "+list);
	 	
	 	totalCount = (Integer)map.get("totalCount");
	 	System.out.println("testGetUserListByUserName() totalCount2 : "+totalCount);
	 }
	 
	 //@Test
	 public void testQuitUser() throws Exception{
		
//		userService.quitUser("123123", "테스트");
//		
//		User user = userService.getUser("123123");
//
//		//==> console 확인
//		System.out.println("testQuitUser() user : "+user);
//			
//		//==> API 확인
//		Assert.assertEquals("testUserId", user.getUserId()); //수정
//		Assert.assertEquals("testUserName", user.getUserName());
	 }
	 	
}