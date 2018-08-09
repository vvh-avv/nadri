package com.nadri.web.board;

import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.json.simple.JSONObject;
import org.json.simple.JSONValue;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.nadri.common.Search;
import com.nadri.service.board.BoardService;
import com.nadri.service.comment.CommentService;
import com.nadri.service.domain.Board;
import com.nadri.service.domain.Comment;
import com.nadri.service.domain.Schedule;
import com.nadri.service.domain.User;
import com.nadri.service.friend.FriendService;
import com.nadri.service.schedule.ScheduleService;
import com.nadri.service.user.UserService;

@RestController
@RequestMapping("/board/*")
public class BoardRestController {

	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;

	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("commentServiceImpl")
	private CommentService commentService;
	
	@Autowired
	@Qualifier("friendServiceImpl")
	private FriendService friendService;
	
	@Autowired
	@Qualifier("scheduleServiceImpl")
	private ScheduleService scheduleService;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;

	@Value("#{imgpathProperties['board']}")
	String imgPath;
	
	public BoardRestController() {
		System.out.println(this.getClass());
	}
	
	//게시물
	@RequestMapping(value="json/addBoard", method=RequestMethod.POST) //일반 게시물 작성 //안드로이드용
	public synchronized void addBoard( @RequestBody Board board ) throws Exception{
		System.out.println("/board/json/addBoard : POST");
		
		boardService.addBoard(board);
	}

	@RequestMapping(value="json/addBoard/{scheduleNo}", method=RequestMethod.POST) //일정 게시물 작성
	public synchronized int addBoard( @PathVariable int scheduleNo, HttpSession session) throws Exception{
		System.out.println("/board/json/addBoard/{scheduleNo} : POST");
		
		Schedule schedule = scheduleService.getSchedule(scheduleNo);
		User user = (User)session.getAttribute("user");
		user = userService.getUser(user.getUserId());
		
		Board board = new Board();
		board.setBoardTitle(schedule.getScheduleTitle());
		board.setBoardContent(schedule.getScheduleDetail());
		board.setBoardImg(schedule.getScheduleImg());
		board.setOpenRange(schedule.getOpenRange());
		board.setHashTag(schedule.getHashTag());
		board.setUser(user);
		board.setBoardCode(scheduleNo);
		
		boardService.addBoard(board);
		//보상에 필요
		return boardService.getMyCount("board", board.getUser().getUserId());
	}
	
	@RequestMapping(value="json/deleteBoard/{boardNo}", method=RequestMethod.POST)
	public synchronized void deleteBoard( @PathVariable int boardNo, HttpServletRequest request ) throws Exception{
		System.out.println("/board/json/deleteBoard : POST");
		
		Board board = boardService.getBoard(boardNo);
		
		String uploadPath = request.getRealPath(imgPath)+"\\"; //파일업로드 경로
		
		if( board.getBoardImg()!=null ) { //이미지가 존재할 때
			//업로드된 기존파일 삭제
			if( board.getBoardImg().contains(",") ) {
				for( String fileName : board.getBoardImg().split(",")) {
					new File(uploadPath+fileName).delete();
					System.out.println(fileName+" 삭제완료");
				}
			}
		}
		
		boardService.deleteBoard(boardNo);
	}
	
	@RequestMapping(value="json/getBoardList/{currentPage}", method=RequestMethod.POST)
	public synchronized List<Board> getBoardList( @PathVariable int currentPage, HttpSession session ) throws Exception{
		System.out.println("/board/json/getBoardList : POST");
		
		System.out.println("@넘어온 페이지 : "+ currentPage);
		
		Search search = new Search();
		search.setStartRowNum( (currentPage+1)*pageSize );
		search.setPageSize(pageSize);

		String userId="";
		if(session.getAttribute("user")!=null) { //비회원0, 회원1
			search.setMemberFlag(1);
			userId = ((User)session.getAttribute("user")).getUserId();
		}
		
		List<Board> list = boardService.getBoardList(search, userId);
		for( int i=0; i<list.size(); i++) {
			list.get(i).setUser( userService.getUser( (list.get(i).getUser().getUserId()) ) );
			//회원일 경우 session 으로 좋아요 여부 가져오기
			if(session.getAttribute("user")!=null) {
				list.get(i).setLikeFlag( boardService.getLikeFlag( list.get(i).getBoardNo(), ((User)session.getAttribute("user")).getUserId()) );	
			}
			//댓글이 있을 때만 수행
			System.out.println("=============댓글이 있음");
			if( list.get(i).getCommCnt()>0 ) {
				List<Comment> comment = commentService.getCommentList(list.get(i).getBoardNo());
				for( int j=0; j<comment.size(); j++) {
					System.out.println("======================"+comment.get(j).getUser().getUserId());
					comment.get(j).setUser( userService.getUser( (comment.get(j).getUser().getUserId()) ) );
					System.out.println("======================"+comment.get(j).getUser());
				}
				list.get(i).setComment(comment);
				String commLastTime = (comment.get(comment.size()-1).getcommentTime()).toString().replace("-","").replace(":","").replace(" ","").substring(0,14);
				list.get(i).setCommLastTime(commLastTime);
			}
		}

		return list;
	}
	
	@RequestMapping(value="json/checkBoard/{boardCode}", method=RequestMethod.POST)
	public synchronized int checkBoard( @PathVariable int boardCode, HttpSession session ) throws Exception{ //작성한 일정이 포스팅이 이미 됐는지 체크
		System.out.println("/board/json/checkBoard : POST");
		
		User user = (User)session.getAttribute("user");
		
		return boardService.checkBoard(boardCode, user.getUserId());
	}
	
	//좋아요
	@RequestMapping(value="json/addLike/{boardNo}", method=RequestMethod.POST)
	public synchronized Map<String, Object> addLike( @PathVariable int boardNo, HttpSession session ) throws Exception{
		System.out.println("/board/json/addLike : POST");
		
		User user = (User)session.getAttribute("user");
		boardService.addLike(boardNo, user.getUserId()); //추가하고

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("likeCnt", boardService.getLikeCount(boardNo)); //변경된 개수 리턴
		//보상에 필요
		map.put("myLikeCnt", boardService.getMyCount("like", user.getUserId()));
		
		return map;
	}

	@RequestMapping(value="json/deleteLike/{boardNo}", method=RequestMethod.POST)
	public synchronized int deleteLike( @PathVariable int boardNo, HttpSession session ) throws Exception{
		System.out.println("/board/json/deleteLike : POST");

		User user = (User)session.getAttribute("user");
		boardService.deleteLike(boardNo, user.getUserId());
		
		return boardService.getLikeCount(boardNo); //변경된 개수 리턴
	}
	
	//댓글
	@RequestMapping(value="json/addComment/{userId}", method=RequestMethod.POST) 
	public synchronized Map<String, Object> addComment( @RequestBody Comment comment, @PathVariable String userId ) throws Exception{
		System.out.println("/board/json/addComment : GET / POST");
		
		//* 알림시 사용
		String cc = comment.getCommentContent(); //넘어온 내용
		String returnFriend = "";
		if( cc.contains("@") ) { //친구소환
			String[] friend = cc.split("@");
			for( int i=1; i<friend.length; i++) { //여기서 알림추가
				returnFriend += friend[i].split(" ")[0]+",";
			}
		}
		
		System.out.println("==============");
		System.out.println(comment);
		
		comment.setUser( userService.getUser(userId) );
		commentService.addComment(comment);
		
		Comment returnComm = commentService.getComment(comment.getCommentNo());
		returnComm.setUser( userService.getUser( returnComm.getUser().getUserId() ) );

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("comment", returnComm);
		map.put("returnFriend", returnFriend);
		//보상에 필요
		map.put("myCommCnt", boardService.getMyCount("comment", userId));
		
		return map;
	}

	@RequestMapping(value="json/deleteComment/{boardNo}/{commentNo}", method=RequestMethod.POST) 
	public synchronized int deleteComment( @PathVariable int boardNo, @PathVariable int commentNo ) throws Exception{
		System.out.println("/board/json/deleteComment : POST");
		
		commentService.deleteComment(commentNo);
		
		return commentService.getCommentCount(boardNo); //변경된 개수 리턴
	}

	//메인화면 추천게시물 (비회원)
	@RequestMapping(value="recomBoard/{condition}")
	public synchronized String recomBoard(@PathVariable String condition, Model model) throws Exception{
		System.out.println("/board/recomBoard : GET / POST");
		
		Search search = new Search();
		if(condition=="new") {
			search.setSearchCondition("최신");
		}else if(condition=="day") {
			search.setSearchCondition("일간");
		}else if(condition=="week") {
			search.setSearchCondition("주간");
		}else if(condition=="month") {
			search.setSearchCondition("월간");
		}
		
		List<Board> list = boardService.getRecomBoard(search);
		
		model.addAttribute("recomBoard", list);
		
		return "forward:/";
	}
	//메인화면 추천게시물 (회원/친구좋아요)
	@RequestMapping(value="recomUserLike/{condition}")
	public synchronized String recomUserLike(@PathVariable String condition, Model model, HttpSession session) throws Exception{
		System.out.println("/board/recomUserLike : GET / POST");
		
		Search search = new Search();
		if(condition=="new") {
			search.setSearchCondition("최신");
		}else if(condition=="day") {
			search.setSearchCondition("일간");
		}else if(condition=="week") {
			search.setSearchCondition("주간");
		}else if(condition=="month") {
			search.setSearchCondition("월간");
		}
		
		User user = (User)session.getAttribute("user");
		List<Board> list = boardService.getRecomUserLike(search, user.getUserId());
		
		model.addAttribute("recomUserLike", list);
		
		return "forward:/";
	}
	//메인화면 추천게시물 (회원/작성글)
	@RequestMapping(value="recomUserBoard/{condition}")
	public synchronized String recomUserBoard(@PathVariable String condition, Model model, HttpSession session) throws Exception{
		System.out.println("/board/recomUserBoard : GET / POST");
		
		Search search = new Search();
		if(condition=="new") {
			search.setSearchCondition("최신");
		}else if(condition=="day") {
			search.setSearchCondition("일간");
		}else if(condition=="week") {
			search.setSearchCondition("주간");
		}else if(condition=="month") {
			search.setSearchCondition("월간");
		}
		
		User user = (User)session.getAttribute("user");
		List<Board> list = boardService.getRecomUserBoard(search, user.getUserId());
		
		model.addAttribute("recomUserBoard", list);
		
		return "forward:/";
	}
	
}
