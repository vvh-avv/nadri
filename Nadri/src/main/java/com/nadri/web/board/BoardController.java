package com.nadri.web.board;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpSession;

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
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

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

	@Value("#{commonProperties['pageSize']}")
	int pageSize;
	
	@Value("#{imgpathProperties['board']}")
	String imgPath;
	
	
	@RequestMapping(value="/board/addBoard", method=RequestMethod.GET)
	public synchronized String addBoard(HttpSession session) throws Exception{
		System.out.println("/board/addBoard : GET");
		
		if(session.getAttribute("user")==null) { //비회원이 접근하면 리스트로 보내기
			return "redirect:/board/listBoard";
		}else {
			//redirect 해도 되지만 URL 감추기 위해 사용!
			return "forward:/board/addBoard.jsp"; //회원일 경우 작성페이지로 들여보내주기
		}
	}
	
	@RequestMapping(value="/board/addBoard", method=RequestMethod.POST)
	public synchronized String addBoard(@ModelAttribute("board") Board board, @RequestParam("file") MultipartFile[] file,
									MultipartHttpServletRequest request, Model model,
									RedirectAttributes redirectAttributes) throws Exception{
		System.out.println("/board/addBoard : POST");
		
		String uploadPath = "C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\board\\posts\\"; //파일업로드 경로
		
		String fileOriginName=""; //각 원본파일명
		String fileMultiName=""; //최종 파일명(들)
		
		for(int i=0; i<file.length; i++) {
			fileOriginName = file[i].getOriginalFilename();
			
			//파일이 존재하지 않으면
			if(fileOriginName=="") {
				break;
			}
			
			System.out.println("기존 파일명 : "+fileOriginName);
			SimpleDateFormat formatter = new SimpleDateFormat("yyMMdd_HHmmss_"+i);
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
		if( fileMultiName.trim()=="" ) {
			board.setBoardImg(null);
		}else {
			board.setBoardImg(fileMultiName);
		}
		board.setUser( (User)request.getSession().getAttribute("user") );
		board.setBoardCode(0); //게시판에서 작성한건 0으로, 일정복사한건 1로(rest에서 1로 처리하면 됨)
		
		boardService.addBoard(board);
		
		//보상기능에 필요
		redirectAttributes.addAttribute("myBoardCnt", boardService.getMyCount("board", board.getUser().getUserId()));
		
		return "redirect:/board/listBoard";
	}
	
	@RequestMapping(value="updateBoard", method=RequestMethod.GET)
	public synchronized String updateBoard( @ModelAttribute Board board, Model model, HttpSession session ) throws Exception{
		System.out.println("/board/updateBoard : GET");
		
		User user = (User)session.getAttribute("user");
		Board bb = boardService.getBoard(board.getBoardNo());
		
		if(bb == null) { //존재하지 않는 게시물 일 경우
			return "forward:/mainError.jsp";
		}
		
		if( user==null ) { 														//비회원이라면 리스트로 보내버리기
			return "redirect:/board/listBoard";
		}else if( !user.getUserId().equals(bb.getUser().getUserId()) ) { //작성자가 요청한게 아닐 경우
			return "redirect:/board/listBoard";
		}else { 																//회원이면서 작성자가 요청한 경우
			model.addAttribute("board", bb);
			
			return "forward:/board/updateBoard.jsp";	
		}
	}
	
	@RequestMapping(value="updateBoard", method=RequestMethod.POST)
	public synchronized String updateBoard( @ModelAttribute Board board,
										MultipartHttpServletRequest request, @RequestParam("file") MultipartFile[] file) throws Exception{
		System.out.println("/board/updateBoard : POST");
		
		//String uploadPath = request.getRealPath(imgPath)+"\\"; //파일업로드 경로
		//String uploadPath = "C:\\Users\\Bitcamp\\git\\nadri\\Nadri\\WebContent\\images\\board\\posts\\"; //파일업로드 경로
		String uploadPath = "C:\\workspace\\.metadata\\.plugins\\org.eclipse.wst.server.core\\tmp0\\wtpwebapps\\Nadri\\images\\board\\posts\\"; //파일업로드 경로(바로보여주기)

		String fileOriginName=""; //각 원본파일명
		String fileMultiName=""; //최종 파일명(들)
		
		//업로드된 기존파일 삭제
		if( board.getBoardImg().contains(",") ) {
			for( String fileName : board.getBoardImg().split(",")) {
				new File(uploadPath+fileName).delete();
				System.out.println(fileName+" 삭제완료");
			}
		}else {
			new File(uploadPath+board.getBoardImg()).delete();
			System.out.println(board.getBoardImg()+" 삭제완료");
		}
		
		boolean fileFlag = true;
		for(int i=0; i<file.length; i++) {
			fileOriginName = file[i].getOriginalFilename();
			
			//파일이 존재하지 않으면
			if(fileOriginName=="") {
				fileFlag = false;
				break;
			}
			
			System.out.println("기존 파일명 : "+fileOriginName);
			SimpleDateFormat formatter = new SimpleDateFormat("yyMMdd_HHmmss_"+(i+1));
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
		
		//파일이 존재하지않으면 널스트링말고 널을 넣기위해서 //DB엔 그렇게 되어있어서 맞추려고
		if(!fileFlag) {
			System.out.println("파일이 존재하지 않아서 null로 들어갑니다.");
			board.setBoardImg(null);
		}else {
			System.out.println("최종 파일명(들) : "+fileMultiName);
			board.setBoardImg(fileMultiName);
		}

		board.setUser( (User)request.getSession().getAttribute("user") );
		boardService.updateBoard(board);
		
		return "forward:/board/listBoard";
	}
	
	@RequestMapping(value="getBoard")
	public synchronized String getBoard(@RequestParam("boardNo") int boardNo, Model model, HttpSession session) throws Exception{
		System.out.println("/board/getBoard : GET / POST");

		Board board = boardService.getBoard(boardNo);
		
		if( board==null ) { //해당 게시물이 존재하지 않을 때
			return "forward:/mainError.jsp";
		}
		System.out.println("@"+board.getOpenRange());
		System.out.println("@"+board.getUser().getUserId());
		if( board.getOpenRange()=="2" ) { //비공개 게시물인데
			if( board.getUser().getUserId()!=((User)session.getAttribute("user")).getUserId() ) { //본인이 아닌 경우
				return "forward:/lockError.jsp";
			}
		}
		
		User user = userService.getUser(board.getUser().getUserId());
		board.setUser(user);

		if(session.getAttribute("user")!=null) {
			int likeFlag = boardService.getLikeFlag(boardNo, ((User)session.getAttribute("user")).getUserId() );
			model.addAttribute("likeFlag", likeFlag);
		}
			
		//댓글이 있을 때만 수행
		if( board.getCommCnt()>0 ) {
			List<Comment> comment = commentService.getCommentList(boardNo);
			for( int i=0; i<comment.size(); i++) {
				comment.get(i).setUser( userService.getUser( (comment.get(i).getUser().getUserId()) ) );
			}
			board.setComment(comment);
			
			String commLastTime = (comment.get(comment.size()-1).getcommentTime()).toString().replace("-","").replace(":","").replace(" ","").substring(0,14);
			board.setCommLastTime(commLastTime);
		}
			
		model.addAttribute("board", board);
			
		return "forward:/board/getBoard.jsp";
	}
	
	@RequestMapping(value="listBoard")
	public synchronized String getBoardList( @ModelAttribute("search") Search search, Model model, HttpSession session,
										@RequestParam(value="myBoardCnt", defaultValue="0") int boardCnt) throws Exception{
		System.out.println("/board/getBoardList : GET / POST");
		
		if(search.getCurrentPage()==0 ){
			search.setCurrentPage(0);
		}
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
		
		model.addAttribute("list", list);
		model.addAttribute("search", search);
		//보상기능에 필요
		model.addAttribute("myBoardCnt", boardCnt);
		
		return "forward:/board/listBoard.jsp";
	}
	
	@RequestMapping(value="deleteBoard", method=RequestMethod.POST)
	public synchronized String deleteBoard(@RequestParam("boardNo") int boardNo) throws Exception{
		System.out.println("/board/deleteBoard : POST");
		
		boardService.deleteBoard(boardNo);
		
		return "redirect:/board/listBoard";
	}

	//마이페이지 작성한 글보기
	@RequestMapping(value="getMyBoardList")
	public synchronized String getMyBoardList(Model model, HttpSession session) throws Exception{
		System.out.println("/board/getMyBoardList : GET / POST");
		
		User user = (User)session.getAttribute("user");
		
		if(user==null) { //세션이 끊겼을 경우
			return "redirect:/";
		}
		List<Board> list = boardService.getMyBoardList(user.getUserId());
		
		model.addAttribute("list", list);
		
		return "forward:/user/mypageBoardList.jsp";
	}
	
}
