package ServletCalendar;

import java.io.BufferedReader;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import DAO.ScheduleDAO;
import DTO.ScheduleDTO;

@WebServlet("/scheduleUpdate")
public class scheduleUpdate extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String json = readJSON(request);
		System.out.println(json); 
		JSONObject data = objJSON(json);

		String title=(String) data.get("title");
		String content=(String) data.get("content");
		String start=(String) data.get("start");
		String end=(String) data.get("end");
		String color=(String) data.get("color");
		String writer=(String) data.get("writer");
		String groupnum=(String) data.get("groupnum");
		
		ScheduleDTO sDTO = new ScheduleDTO();
		sDTO.setTitle(title);
		sDTO.setContent(content);
		sDTO.setStart(start);
		sDTO.setEnd(end);
		sDTO.setColor(color);
		sDTO.setWriter(writer);
		sDTO.setGroupnum(groupnum);
		
		if(groupnum.equals("")){
			System.out.println("인설트");
		}
		else {
			System.out.print("업뎃");
		}
		
		ScheduleDAO sDAO = ScheduleDAO.getInstance();
		
		// 그룹 넘버 가 아닌 넘버 기준으로 해야함// 수정 필요 
		if(groupnum.equals("")) {
			sDAO.scheduleInsert(sDTO);	
		}
		else {
			sDAO.scheduleUpdate(sDTO);
		}
	}
	
	protected String readJSON(HttpServletRequest request) { 
		StringBuffer json = new StringBuffer(); 
		String line = null;
		
		try { 
			BufferedReader reader=request.getReader();

			while((line=reader.readLine())!=null){ 
				json.append(line); 
			}
		}
		catch(Exception e) {
			System.out.println("JSON 파일을 읽어오던 중 오류 발생");
		}
		return json.toString(); 
	}
	
	protected JSONObject objJSON(String str) {
		Object obj=null;
		JSONObject json=null;
		System.out.println(str);
		try {
			JSONParser parser = new JSONParser();
			obj=parser.parse(str);
			json=(JSONObject)obj;
		}
		catch(Exception e) {
			System.out.println("JSON 변환 중 오류 발생: "+e);
		}
		return json;
	}
}
