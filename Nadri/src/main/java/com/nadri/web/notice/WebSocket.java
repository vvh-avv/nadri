package com.nadri.web.notice;
import java.io.IOException;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;

import javax.websocket.OnClose;
import javax.websocket.OnError;
import javax.websocket.OnMessage;
import javax.websocket.OnOpen;
import javax.websocket.Session;
import javax.websocket.server.PathParam;
import javax.websocket.server.ServerEndpoint;

import org.springframework.web.bind.annotation.RequestBody;

@ServerEndpoint("/websocket/{userId}")
public class WebSocket {
    /***
     * 웹 소켓이 연결되면 호출되는 이벤트
     */
	  static Map<String, Session> map =Collections.synchronizedMap(new HashMap<String , Session>()) ;
	
    @OnOpen
    public void handleOpen(@PathParam("userId") String userId , Session session) {
        map.put( userId  , session) ;
    }
    
    /**
     * 웹 소켓으로부터 메시지가 오면 호출되는 이벤트
     * @param message
     * @return
     * @throws IOException 
     */
    @OnMessage
    public void handleMessage( String userId  , Session session) throws IOException {
    	//세션 프로퍼티에 username이 없으면 username을 선언하고 해당 세션을으로 메시지를 보낸다.(json 형식이다.)
        //최초 메시지는 username설정
    	String[] userIdArray = userId.split(",") ;
    	System.out.println("userId : " + userId.toString() ) ;
    	System.out.println("마지막 글자 :" + userId.substring(userId.length() -1 , userId.length() )) ;
    	switch (userId.substring(userId.length() - 1 , userId.length() )) {
    	
    	//신고일 때
    	case "0" :
    		if( map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ) != null )  {
    			map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ).getBasicRemote().sendText("신고 메시지") ;
    		}
    		break ;
    	//좋아요일 때
    	case "1" :
    		if( map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ) != null )  {
    			map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ).getBasicRemote().sendText("좋아요 메시지.") ;
    		}
    		break ;
    	//친구요청일 때
    	case "2" :
    		if( map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ) != null )  {
    			map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ).getBasicRemote().sendText("친구요청 메시지.") ;
    		}
    		break ;
    	//테그했을 때
    	case "3" :
    		for(int i = 0 ; i < userIdArray.length ; i++) {
    			if( map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ) != null )  {
    				map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ).getBasicRemote().sendText("테크 메시지.") ;
    			}
    		}
    		break ;
    	
    	//댓글 남겼을 때
    	case "4" :
    		for(int i = 0 ; i < userIdArray.length ; i++) {
    			if( map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ) != null )  {
    				map.get( userIdArray[0].substring( 0 , userIdArray[0].length() - 1 ) ).getBasicRemote().sendText("댓글 메시지.") ;
    			}
    		}
    		break ;
    		
    	//채팅일 때
    	default :
    		for(int i = 0 ; i < userIdArray.length ; i++) {
        		if( map.get( userIdArray[i].substring( 0 , userIdArray[i].length() - 1 ) ) != null && userIdArray[i].substring(userIdArray[i].length() - 1 , userIdArray[i].length()).equals("5")  ) {
                	map.get( userIdArray[i].substring( 0 , userIdArray[i].length() - 1 ) ).getBasicRemote().sendText("채팅 메시지.") ;
        		}
        	}
    	}
    }
    /**
     * 웹 소켓이 닫히면 호출되는 이벤트
     */
    @OnClose
    public void handleClose() {
        
    }
    /**
     * 웹 소켓이 에러가 나면 호출되는 이벤트
     * @param t
     */
    @OnError
    public void handleError(Throwable t) {
        t.printStackTrace() ;
    }
}
