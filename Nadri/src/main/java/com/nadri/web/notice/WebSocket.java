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

@ServerEndpoint("/websocket/{userId}")
public class WebSocket {
    /***
     * 웹 소켓이 연결되면 호출되는 이벤트
     */
	  static Map<String, Session> map =Collections.synchronizedMap(new HashMap<String , Session>()) ;
	
    @OnOpen
    public void handleOpen(@PathParam("userId") String userId , Session session) {
    	System.out.println("123") ;
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
    	
    	for(int i = 0 ; i < userIdArray.length ; i++) {
    		if( map.get( userIdArray[i].substring( 0 , userIdArray[i].length() - 1 ) ) != null && userIdArray[i].substring(userIdArray[i].length() - 1 , userIdArray[i].length()).equals("0")  ) {
            	map.get( userIdArray[i].substring( 0 , userIdArray[i].length() - 1 ) ).getBasicRemote().sendText("서버로부터 받은 메시지.") ;
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
