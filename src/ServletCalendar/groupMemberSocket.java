package ServletCalendar;

import java.io.*;
import java.util.*;
import javax.websocket.*;
import javax.websocket.server.*;

import javax.servlet.http.*;

@ServerEndpoint(value="/socketAlert", configurator=httpSessionJejang.class)
public class groupMemberSocket  {
	//private static List<Session> userList = Collections.synchronizedList(new ArrayList<>());
	private static Map<Session, HttpSession> sessionMap = new HashMap<Session, HttpSession>();
	
	@OnOpen
	public void skOpen(Session session, EndpointConfig confi) {
		HttpSession hsession=(HttpSession) confi.getUserProperties().get("UserHttpSession");
		sessionMap.put(session, hsession);
	}
	
	@OnMessage
	public void skCheckData(Session session, String changeUser) throws IOException {
		Iterator<Session> keys = sessionMap.keySet().iterator();

		while( keys.hasNext() ){ 
			Session key = keys.next(); 
			key.getBasicRemote().sendText(changeUser);
		}
	}
	
	@OnClose
	public void  skClose(Session session) {
		System.out.println("Socket Close: Client Close");
		sessionMap.remove(session);
	}
	
	@OnError
	public void skError(Throwable e) {
		System.out.println("Socket Error: "+e);
	}
	
}

