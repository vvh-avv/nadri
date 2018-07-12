package com.nadri.web.board;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.nadri.common.Search;
import com.nadri.service.board.BoardService;
import com.nadri.service.comment.CommentService;
import com.nadri.service.domain.Board;
import com.nadri.service.domain.Comment;
import com.nadri.service.domain.User;
import com.nadri.service.user.UserService;

@Controller
@RequestMapping("/board/*")
public class BoardController {

	@Autowired
	@Qualifier("boardServiceImpl")
	private BoardService boardService;
	
	@Autowired
	@Qualifier("userServiceImpl")
	private UserService userService;
	
	@Autowired
	@Qualifier("commentServiceImpl")
	private CommentService commentService;
	
	public BoardController() {
		System.out.println(this.getClass());
	}

	@Value("#{imgpathProperties['board']}")
	String imgPath;
	
	
	@RequestMapping(value="/board/addBoard", method=RequestMethod.GET)
	public String addBoard() throws Exception{
		System.out.println("/board/addBoard : GET");
		
		return "redirect:/board/addBoard.jsp";
	}
	
	@RequestMapping(value="/board/addBoard", method=RequestMethod.POST)
	public String addBoard(@ModelAttribute("board") Board board,
									MultipartHttpServletRequest request, @RequestParam("file") MultipartFile[] file) throws Exception{
		System.out.println("/board/addBoard : POST");
		
		String uploadPath = request.getRealPath(imgPath)+"\\"; //파일업로드 경로
		
		String fileOriginName=""; //각 원본파일명
		String fileMultiName=""; //최종 파일명(들)
		
		for(int i=0; i<file.length; i++) {
			fileOriginName = file[i].getOriginalFilename();
			
			//파일이 존재하지 않으면
			if(fileOriginName=="") {
				break;
			}
			
			System.out.println("기존 파일명 : "+fileOriginName);
			SimpleDateFormat formatter = new SimpleDateFormat("YYMMDD_HHMMSS_"+i);
			Calendar now = Calendar.getInstance();
			
			String extension = fileOriginName.split("\\.")[1]; //확장자명
			fileOriginName = formatter.format(now.getTime())+"."+extension;
			System.out.println("변경된 파일명 : "+fileOriginName);
			
			File f = new File(uploadPath+fileOriginName);
			file[i].transferTo(f);
			
			if(i==0) {
				fileMultiName += fileOriginName;
			}else {
				fileMultiName += ","+fileOriginName;
			}
		}
		
		System.out.println("최종 파일명(들) : "+fileMultiName);
		board.setBoardImg(fileMultiName);
			
		boardService.addBoard(board);
		
		return "forward:/board/listBoard.jsp";
	}
	
	@RequestMapping(value="updateBoard", method=RequestMethod.GET)
	public String updateBoard( @ModelAttribute Board board, Model model ) throws Exception{
		System.out.println("/board/updateBoard : GET");
		System.out.println("*보드 : " + board);
		
		//Board boardVO = (Board) (boardService.getBoard(boardNo)).get("board");
		
		//model.addAttribute("board", boardVO);
		
		return "redirect:/board/updateBoard.jsp";
	}
	
	@RequestMapping(value="updateBoard", method=RequestMethod.POST)
	public String updateBoard( @ModelAttribute Board board,
										MultipartHttpServletRequest request, @RequestParam("file") MultipartFile[] file) throws Exception{
		System.out.println("/board/updateBoard : POST");
		
		String uploadPath = request.getRealPath(imgPath)+"\\"; //파일업로드 경로
		
		String fileOriginName=""; //각 원본파일명
		String fileMultiName=""; //최종 파일명(들)
		
		//업로드된 기존파일 삭제
		if(board.getBoardImg().contains(",")) {
			for( String fileName : board.getBoardImg().split(",")) {
				new File(uploadPath+fileName).delete();
				System.out.println(fileName+" 삭제완료");
			}
		}else {
			new File(uploadPath+board.getBoardImg()).delete();
			System.out.println(board.getBoardImg()+" 삭제완료");
		}
		
		for(int i=0; i<file.length; i++) {
			fileOriginName = file[i].getOriginalFilename();
			
			//파일이 존재하지 않으면
			if(fileOriginName=="") {
				break;
			}
			
			System.out.println("기존 파일명 : "+fileOriginName);
			SimpleDateFormat formatter = new SimpleDateFormat("YYMMDD_HHMMSS_"+(i+1));
			Calendar now = Calendar.getInstance();
			
			String extension = fileOriginName.split("\\.")[1]; //확장자명
			fileOriginName = formatter.format(now.getTime())+"."+extension;
			System.out.println("변경된 파일명 : "+fileOriginName);
			
			File f = new File(uploadPath+fileOriginName);
			file[i].transferTo(f);
			
			if(i==0) {
				fileMultiName += fileOriginName;
			}else {
				fileMultiName += ","+fileOriginName;
			}
		}
		
		System.out.println("최종 파일명(들) : "+fileMultiName);
		board.setBoardImg(fileMultiName);
			
		boardService.updateBoard(board);
		
		return "forward:/board/listBoard.jsp";
	}
	
	@RequestMapping(value="getBoard")
	public String getBoard(@RequestParam("boardNo") int boardNo, Model model) throws Exception{
		System.out.println("/board/getBoard : GET / POST");

		Map<String,Object> map = boardService.getBoard(boardNo);
		int likeFlag = boardService.getLikeFlag(boardNo,"user05");
		
		User user = userService.getUser(((Board)map.get("reBoard")).getUser().getUserId());
		int commentCount = commentService.getCommentCount(boardNo);
		
		model.addAttribute("user", user);
		model.addAttribute("board", map.get("reBoard"));
		model.addAttribute("commentCount", commentCount);
		model.addAttribute("likeFlag", likeFlag);
		model.addAttribute("likeCount", map.get("reLikeCnt"));
		
		return "forward:/board/getBoard.jsp";
	}
	
	@RequestMapping(value="getBoardList")
	public String getBoardList(@ModelAttribute("search") Search search, Model model) throws Exception{
		System.out.println("/board/getBoardList : GET / POST");
		
		List<Board> list = boardService.getBoardList(search);
		
		model.addAttribute("list", list);
		model.addAttribute("search", search);
		
		return "forward:/board/listBoard.jsp";
	}
	
	@RequestMapping(value="deleteBoard", method=RequestMethod.POST)
	public String deleteBoard(@RequestParam("boardNo") int boardNo) throws Exception{
		System.out.println("/board/deleteBoard : POST");
		
		boardService.deleteBoard(boardNo);
		
		return "redirect:/board/listBoard.jsp";
	}
}
