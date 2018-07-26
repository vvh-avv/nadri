package com.nadri.web.chatroom;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.RandomAccessFile;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.codehaus.jackson.map.ObjectMapper;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.nadri.common.Search;
import com.nadri.service.chatroom.ChatRoomService;
import com.nadri.service.domain.ChatRoom;
import com.nadri.service.domain.User;


@Controller
@RequestMapping("/chatRoom/*")
public class ChatRoomRestController {

	@Autowired
	@Qualifier("chatRoomServiceImpl")
	private ChatRoomService chatRoomService ;
		
	public ChatRoomRestController(){
		System.out.println(this.getClass()) ;
	}
	
	@Value("#{commonProperties['pageUnit']}")
	int pageUnit ;
	
	@Value("#{commonProperties['pageSize']}")
	int pageSize ;
	
	@ResponseBody
	@RequestMapping( value="json/addChatRoom", method=RequestMethod.POST )
	public ChatRoom addChat( @RequestBody ChatRoom ChatRoom ) throws Exception {
		
		System.out.println("json/addChatRoom POST  " + ChatRoom ) ;
		
		return ChatRoom ;
	}
	
	@ResponseBody
	@RequestMapping( value="json/getChatRoom" , method=RequestMethod.POST)
	synchronized public  Map<String, Object>[] getChatRoom(  Search search , HttpSession session) throws Exception {
		
		System.out.println("/json/getChatRoom  POST ") ; 
		int CHATROOMCOUNT = 5 ;
		
		// 해당 유저의 채팅방 List를 다 가져옴.
		List<ChatRoom> list = chatRoomService.getChatRoomList(search,  ((User)session.getAttribute("user")).getUserId() )  ;
		
		//각 채팅방 마지막 문자열을 가져옴.
		RandomAccessFile logfile = null ;
		int j = 0 ;
		Map<String, Object> map[] =  new HashMap[list.size()] ;
		Map<String, Object> temp =  new HashMap<String, Object>() ;
		
		for(ChatRoom i : list) {
			
			logfile = new RandomAccessFile(  "C:/Users/Bit/git/nadri/Nadri/WebContent/chatFiles/" + 
					((User)session.getAttribute("user")).getUserId() + "/" + i.getChatRoomNo() + ".json" , "r") ;
			long pos = logfile.length() - 1 ;
			
			while(true) {
				logfile.seek( pos ) ;
				if(logfile.readByte() == '\n') {
					break ;
				}
				pos-- ;
			}
			
			logfile.seek(pos + 1) ;
			JSONObject jsonObject = (JSONObject) new JSONParser().parse(new String(logfile.readLine().getBytes("ISO-8859-1") , "UTF-8").replace( ",",  "" )) ;
			map[j] = new ObjectMapper().readValue( jsonObject.toString() , HashMap.class ) ;
			map[j].put("chatRoom" , list.get(j)) ;
			list.get(j) ;
			j++ ;
		}

		//채팅방 순서대로 정렬 sending_date를 기준으로 정렬할 것임.		
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmss") ;
		Date date1 = new Date() ;
		Date date2 =  new Date() ;

		
		//채팅방 최대 5개만 가져옴.
		if(list.size() < CHATROOMCOUNT) {
			CHATROOMCOUNT = list.size() ;
		}
			
		for(int i = 0 ; i < CHATROOMCOUNT ; i++)  {
			date1 = format.parse( ((String) map[i].get("sending_date")) ) ;
			for( j = i + 1 ; j < list.size() ; j++) {
				date2 = format.parse( ((String) map[j].get("sending_date")) ) ;
				int compare = date1.compareTo(date2) ;
				if ( map[i].get("sending_date").equals("0000-00-00 00:00:00") ) {
					temp = map[j] ;
					map[j] = map[i] ;
					map[i] = temp ;
				} else if( compare > 0 && !map[j].get("sending_date").equals("0000-00-00 00:00:00")  ) {
					temp = map[j] ;
					map[j] = map[i] ;
					map[i] = temp ;
				}
			} //End of inner for
		} //End of outer for 

		
		//읽음, 안 읽음 유무 판단.
		int i = 0 ;
		while( i < map.length ) {
			int chatRoomCounter = 0 ;
			logfile = new RandomAccessFile(  "C:/Users/Bit/git/nadri/Nadri/WebContent/chatFiles/" + 
					((User)session.getAttribute("user")).getUserId() + "/" + ((ChatRoom)map[i].get("chatRoom")).getChatRoomNo() + ".json" , "r") ;
			long pos = logfile.length() - 1 ;
			byte readByte = 0 ;
			String log = "" ;
			while(true) {
				logfile.seek( pos ) ;
				if( (readByte = logfile.readByte()) == 'Y' || readByte == '['   ) {
					if( ( log = new String(logfile.readLine().getBytes("ISO-8859-1") , "UTF-8")).equals("\"}") ||
							log.equals(""))  {
						i++ ;
						break ;
					}
				} else if( readByte == 'N' ) {
					if( ( log = new String(logfile.readLine().getBytes("ISO-8859-1") , "UTF-8")).equals("\"}") )  {
						((ChatRoom)map[i].get("chatRoom")).setFlag(++chatRoomCounter) ;
					}
				}
				pos-- ;
			}
		}
		
		if( logfile != null) {
			logfile.close() ;
		}
		
		return map ;
	}
	
	@ResponseBody
	@RequestMapping( value="json/updateChat" , method=RequestMethod.GET)
	synchronized public  int updateChat( @RequestParam(value="chatRoomNo") int chatRoomNo,
																@RequestParam(value="senderId") String senderId , Search search ) throws Exception {
		
		System.out.println("json/updateChat GET") ;
		// flag:N이 나온 위치.
		int readPoint = 0 ;
		
		RandomAccessFile logfile = null ;
		logfile = new RandomAccessFile(  "C:/Users/Bit/git/nadri/Nadri/WebContent/chatFiles/" + 
				senderId + "/" + chatRoomNo + ".json" , "rw") ;
		long pos = logfile.length() - 1 ;
		
		byte readByte = 0 ;
		String log = "" ;
		
		while(true) {
			logfile.seek( pos ) ;
			if( (readByte = logfile.readByte()) == 'Y' || readByte == '['   ) {
				//Y , [ 이후에 공백 또는 }이냐 묻는 것.
				if( ( log = new String(logfile.readLine().getBytes("ISO-8859-1") , "UTF-8")).equals("\"}") ||
						log.equals(""))  {
					if( readByte == 'Y') {
						readPoint = (int) pos ;
					}
					break ;
				}
			} else if( readByte == 'N' ) {
				if( ( log = new String(logfile.readLine().getBytes("ISO-8859-1") , "UTF-8")).equals("\"}") )  {
					logfile.seek( pos ) ;
					logfile.write('Y') ;
				}
			}
			pos-- ;
		}
		if( logfile != null) {
			logfile.close() ;
		}
		return readPoint ;
	}
	
	@ResponseBody
	@RequestMapping( value="json/getChatRoom2" , method=RequestMethod.GET) 
	public ChatRoom getChatRoom2( @RequestParam(value="receiverId") String receiverId , HttpSession session) throws Exception{
		System.out.println(" getChatRoom2 POST 받은 데이터 : " + receiverId) ;		
		ChatRoom chatRoom = chatRoomService.getChatRoom2( ((User)session.getAttribute("user")).getUserId() , receiverId ) ;
		
		//채팅방 파일이 없을 경우. DB에도 없고.
		if( chatRoom.getChatRoomNo() == 0 ) {
			chatRoom.setUserId(  ((User)session.getAttribute("user")).getUserId() + ',' + receiverId ) ;
		
			chatRoomService.addChatRoom(chatRoom) ;
			chatRoom = chatRoomService.getChatRoom2( ((User)session.getAttribute("user")).getUserId() , receiverId ) ;
			
			//json 파일 만들기 내꺼
			File file = new File("C:/Users/Bit/git/nadri/Nadri/WebContent/chatFiles/" + ((User)session.getAttribute("user")).getUserId() + 
					"/" + chatRoom.getChatRoomNo() + ".json"	) ;
 			BufferedWriter bw = new BufferedWriter(new FileWriter(file)) ;
 			
 			long time = System.currentTimeMillis() ;
 			SimpleDateFormat dayTime = new SimpleDateFormat("YYYY-mm-dd hh:mm:ss") ;
 			String currentTime = dayTime.format(new Date( time )) ;
 			System.out.println("현재시간 : " + currentTime) ;
 			
 			//비어있는 기본값
			bw.write("{\r\n" + 
					"	\"chatList\" : \r\n" + 
					"				[\r\n" +
					"{\"protocol\":\"\", \"sender_id\" : \"\", \"receiver_id\" : \"\", \"message\" : \"\" , \"sending_date\" :\"" + currentTime + 
					"\",\"flag\":\"Y\"" + "}"
			) ;
			
			//json 파일 만들기 상대방 꺼			
			file = new File("C:/Users/Bit/git/nadri/Nadri/WebContent/chatFiles/" + receiverId + 
					"/" + chatRoom.getChatRoomNo() + ".json"	) ;
			if(bw != null) {
				bw.close() ; 
			}
			
			bw = new BufferedWriter(new FileWriter(file)) ;
			bw.write("{\r\n" + 
					"	\"chatList\" : \r\n" + 
					"				[\r\n" +
					"{\"protocol\":\"\", \"sender_id\" : \"\", \"receiver_id\" : \"\", \"message\" : \"\" , \"sending_date\" :\"" + currentTime + 
					"\",\"flag\":\"Y\"" + "}"
			) ;
			
			if(bw != null) {
				bw.close() ; 
			}
		}
		
		return chatRoom ;
	}
}












