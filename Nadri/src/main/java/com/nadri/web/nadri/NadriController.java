package com.nadri.web.nadri;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.nadri.service.admin.AdminService;
import com.nadri.service.board.BoardService;
import com.nadri.service.spot.SpotService;
import com.nadri.service.user.UserService;

@Controller
@RequestMapping(value = "/index")
public class NadriController {
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("adminServiceImpl")
	private AdminService adminService;

	@Autowired
	@Qualifier("spotServiceImpl")
	private SpotService spotService;
	
	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	@RequestMapping(".nadri")
	public String getIndex(HttpSession session) {
		System.out.println("getIndex IN!!!");
		return "/indexReal.jsp";
	}

}
