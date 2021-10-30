package ServletCalendar;

import javax.servlet.http.*;
import javax.websocket.*;
import javax.websocket.server.*;

public class httpSessionJejang extends ServerEndpointConfig.Configurator{
	public void modifyHandshake(ServerEndpointConfig sec, HandshakeRequest request, HandshakeResponse response ) {
		HttpSession session = (HttpSession) request.getHttpSession();
		
		if(session!=null) {
			sec.getUserProperties().put("UserHttpSession", session);
		}
	}
}
