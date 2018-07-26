package com.nadri.web.board;

import java.io.File;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

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
	public void addBoard( @RequestBody Board board ) throws Exception{
		System.out.println("/board/json/addBoard : POST");
		
		boardService.addBoard(board);
	}

	@RequestMapping(value="json/addBoard/{scheduleNo}", method=RequestMethod.POST) //일정 게시물 작성
	public void addBoard( @PathVariable int scheduleNo, HttpSession session ) throws Exception{
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
	}
	
	@RequestMapping(value="json/deleteBoard/{boardNo}", method=RequestMethod.POST)
	public void deleteBoard( @PathVariable int boardNo, HttpServletRequest request ) throws Exception{
		System.out.println("/board/json/deleteBoard : POST");
		
		Board board = boardService.getBoard(boardNo);
		
		String uploadPath = request.getRealPath(imgPath)+"\\"; //파일업로드 경로
				
		//업로드된 기존파일 삭제
		if( board.getBoardImg().contains(",") ) {
			for( String fileName : board.getBoardImg().split(",")) {
				new File(uploadPath+fileName).delete();
				System.out.println(fileName+" 삭제완료");
			}
		}
		
		boardService.deleteBoard(boardNo);
	}
	
	@RequestMapping(value="json/getBoardList/{currentPage}", method=RequestMethod.POST)
	public List<Board> getBoardList( @PathVariable int currentPage, HttpSession session ) throws Exception{
		System.out.println("/board/json/getBoardList : POST");
		
		Search search = new Search();
		search.setStartRowNum( (currentPage+1)*pageSize );
		search.setPageSize(pageSize);

		if(session.getAttribute("user")!=null) { //비회원0, 회원1
			search.setMemberFlag(1);
		}
		
		List<Board> list = boardService.getBoardList(search);
		for( int i=0; i<list.size(); i++) {
			list.get(i).setUser( userService.getUser( (list.get(i).getUser().getUserId()) ) );
			//회원일 경우 session 으로 좋아요 여부 가져오기
			if(session.getAttribute("user")!=null) {
				list.get(i).setLikeFlag( boardService.getLikeFlag( list.get(i).getBoardNo(), ((User)session.getAttribute("user")).getUserId()) );	
			}
			//댓글이 있을 때만 수행
			if( list.get(i).getCommCnt()>0 ) {
				List<Comment> comment = commentService.getCommentList(list.get(i).getBoardNo());
				for( int j=0; j<comment.size(); j++) {
					comment.get(j).setUser( userService.getUser( (comment.get(j).getUser().getUserId()) ) );
				}
				list.get(i).setComment(comment);
				String commLastTime = (comment.get(comment.size()-1).getcommentTime()).toString().replace("-","").replace(":","").replace(" ","").substring(0,14);
				list.get(i).setCommLastTime(commLastTime);
			}
		}

		return list;
	}
	
	@RequestMapping(value="json/checkBoard/{boardCode}", method=RequestMethod.POST)
	public int checkBoard( @PathVariable int boardCode, HttpSession session ) throws Exception{ //작성한 일정이 포스팅이 이미 됐는지 체크
		System.out.println("/board/json/checkBoard : POST");
		
		User user = (User)session.getAttribute("user");
		
		return boardService.checkBoard(boardCode, user.getUserId());
	}
	
	//좋아요
	@RequestMapping(value="json/addLike/{boardNo}", method=RequestMethod.POST)
	public int addLike( @PathVariable int boardNo, HttpSession session ) throws Exception{
		System.out.println("/board/json/addLike : POST");
		
		User user = (User)session.getAttribute("user");
		boardService.addLike(boardNo, user.getUserId()); //추가하고

		return boardService.getLikeCount(boardNo); //변경된 개수 리턴
	}

	@RequestMapping(value="json/deleteLike/{boardNo}", method=RequestMethod.POST)
	public int deleteLike( @PathVariable int boardNo, HttpSession session ) throws Exception{
		System.out.println("/board/json/deleteLike : POST");

		User user = (User)session.getAttribute("user");
		boardService.deleteLike(boardNo, user.getUserId());
		
		return boardService.getLikeCount(boardNo); //변경된 개수 리턴
	}
	
	//댓글
	@RequestMapping(value="json/addComment/{userId}", method=RequestMethod.POST) 
	public Comment addComment( @RequestBody Comment comment, @PathVariable String userId ) throws Exception{
		System.out.println("/board/json/addComment : POST");
		
		/* 알림시 사용
		String cc = comment.getCommentContent(); //넘어온 내용
		if( cc.contains("@") ) { //친구소환
			String[] friend = cc.split("@");
			for( int i=1; i<friend.length; i++) { //여기서 알림추가
				String friendId = friend[i].split(" ")[0];
				comment.setFriend( userService.getUser(friendId) );
			}
		}else { //친구소환X
			System.out.println("@친구소환X");
		}
		//*/
		
		comment.setUser( userService.getUser(userId) );
		commentService.addComment(comment);
		
		Comment returnComm = commentService.getComment(comment.getCommentNo());
		returnComm.setUser( userService.getUser( returnComm.getUser().getUserId() ) );
		
		return returnComm;
	}

	@RequestMapping(value="json/deleteComment/{boardNo}/{commentNo}", method=RequestMethod.POST) 
	public int deleteComment( @PathVariable int boardNo, @PathVariable int commentNo ) throws Exception{
		System.out.println("/board/json/deleteComment : POST");
		
		commentService.deleteComment(commentNo);
		
		return commentService.getCommentCount(boardNo); //변경된 개수 리턴
	}

	//메인화면 추천게시물 (최신)
	@RequestMapping(value="recomBoardNew")
	public String recomBoardNew(Model model) throws Exception{
		System.out.println("/board/recomBoardNew : GET / POST");
		
		Search search = new Search();
		search.setSearchCondition("최신");
		List<Board> list = boardService.getRecomBoard(search);
		
		model.addAttribute("recomBoardNew", list);
		
		return "forward:/index.jsp";
	}
	//메인화면 추천게시물 (일간)
	@RequestMapping(value="recomBoardDay")
	public String recomBoardDay(Model model) throws Exception{
		System.out.println("/board/recomBoardDay : GET / POST");
		
		Search search = new Search();
		search.setSearchCondition("일간");
		List<Board> list = boardService.getRecomBoard(search);
		
		model.addAttribute("recomBoardDay", list);
		
		return "forward:/index.jsp";
	}
	//메인화면 추천게시물 (주간)
	@RequestMapping(value="recomBoardWeek")
	public String recomBoardWeek(Model model) throws Exception{
		System.out.println("/board/recomBoardWeek : GET / POST");
		
		Search search = new Search();
		search.setSearchCondition("주간");
		List<Board> list = boardService.getRecomBoard(search);
		
		model.addAttribute("recomBoardWeek", list);
		
		return "forward:/index.jsp";
	}
	//메인화면 추천게시물 (월간)
	@RequestMapping(value="recomBoardMonth")
	public String recomBoardMonth(Model model) throws Exception{
		System.out.println("/board/recomBoardMonth : GET / POST");
		
		Search search = new Search();
		search.setSearchCondition("월간");
		List<Board> list = boardService.getRecomBoard(search);
		
		model.addAttribute("recomBoardMonth", list);
		
		return "forward:/index.jsp";
	}
}
