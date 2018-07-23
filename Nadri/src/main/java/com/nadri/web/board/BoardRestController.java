package com.nadri.web.board;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.common.Search;
import com.nadri.service.board.BoardService;
import com.nadri.service.comment.CommentService;
import com.nadri.service.domain.Board;
import com.nadri.service.domain.Comment;
import com.nadri.service.domain.User;
import com.nadri.service.friend.FriendService;
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
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	public BoardRestController() {
		System.out.println(this.getClass());
	}
	
	//게시물
	@RequestMapping(value="json/deleteBoard/{boardNo}", method=RequestMethod.POST)
	public void deleteBoard( @PathVariable int boardNo ) throws Exception{
		System.out.println("/board/json/deleteBoard : POST");
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
	
	//좋아요
	@RequestMapping(value="json/addLike/{boardNo}", method=RequestMethod.POST)
	public int addLike( @PathVariable int boardNo ) throws Exception{
		System.out.println("/board/json/addLike : POST");
		boardService.addLike(boardNo, "user05"); //추가하고

		return boardService.getLikeCount(boardNo); //변경된 개수 리턴
	}

	@RequestMapping(value="json/deleteLike/{boardNo}", method=RequestMethod.POST)
	public int deleteLike( @PathVariable int boardNo ) throws Exception{
		System.out.println("/board/json/deleteLike : POST");
		
		boardService.deleteLike(boardNo, "user05");
		
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
}
