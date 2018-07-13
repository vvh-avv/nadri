package com.nadri.web.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.nadri.service.board.BoardService;

@RestController
@RequestMapping("/board/*")
public class BoardRestController {

	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	public BoardRestController() {
		System.out.println(this.getClass());
	}
	
	//게시물
	@RequestMapping(value="json/deleteBoard/{boardNo}", method=RequestMethod.POST)
	public void deleteBoard( @PathVariable int boardNo ) throws Exception{
		System.out.println("/board/json/deleteBoard : POST");
		boardService.deleteBoard(boardNo);
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
}
