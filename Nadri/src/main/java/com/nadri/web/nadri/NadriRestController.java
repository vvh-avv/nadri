package com.nadri.web.nadri;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.common.Search;
import com.nadri.service.admin.AdminService;
import com.nadri.service.board.BoardService;
import com.nadri.service.comment.CommentService;
import com.nadri.service.domain.Board;
import com.nadri.service.domain.User;
import com.nadri.service.spot.SpotService;
import com.nadri.service.user.UserService;

@RestController
@RequestMapping("/nadriRest/*")
public class NadriRestController {
	
	@Autowired
	@Qualifier("adminServiceImpl")
	private AdminService adminService;

	@Autowired
	@Qualifier("spotServiceImpl")
	private SpotService spotService;

	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("commentServiceImpl")
	private CommentService commentService;

	public NadriRestController() {
		super();
		// TODO Auto-generated constructor stub
		System.out.println(this.getClass());
	}
	
	@RequestMapping( value="nadriIndex", method=RequestMethod.GET)
	public Map indexStruct(HttpServletRequest request) throws Exception {
		
		System.out.println("main 구성하기위한 rest컨트롤러 진입");
		
		HttpSession session = request.getSession(true);
		User user = (User)session.getAttribute("user");
		
		Map<String,Object> map = new HashMap<String, Object>();
		
		Search search = new Search();
		
		search.setSearchCondition("주간");
		
		List<Board> board_list = boardService.getRecomBoard(search);
		
		System.out.println(board_list);
		System.out.println(board_list.size());
		
		map.put("boardList",board_list);
		
		return map;
	}
	
	

}
