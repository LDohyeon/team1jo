package ServletCalendar;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import DAO.GroupDAO;
import DAO.ScheduleDAO;
import DTO.GroupDTO;
import DTO.MemberDTO;
import DTO.ScheduleDTO;

@WebServlet("/scheduleSearch")
public class scheduleSearch extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String userKey = request.getParameter("userKey");
		String word = request.getParameter("word");
		
		MemberDTO mDTO = new MemberDTO();
		mDTO.setId(userKey);
		
		ScheduleDAO sDAO = ScheduleDAO.getInstance();
		GroupDAO gDAO = GroupDAO.getInstance();
		List<GroupDTO> glist = gDAO.groupList(mDTO.getId());
		List<ScheduleDTO> slist= new ArrayList<ScheduleDTO>();
		JSONArray schedules = new JSONArray();
		
		for(int i = 0; i<glist.size(); i++) {	
			
			slist=sDAO.scheduleListSearch(glist.get(i), word);
			
			for(int j = 0; j<slist.size(); j++) {
				JSONObject json = new JSONObject();
				json.put("num", slist.get(j).getNum().toString());
				json.put("title", slist.get(j).getTitle().toString());
				json.put("start", slist.get(j).getStart().toString());
				json.put("end", slist.get(j).getEnd().toString());
				json.put("content", slist.get(j).getContent().toString());
				json.put("color", slist.get(j).getColor().toString());
				json.put("groupnum", glist.get(i).getGroupnum().toString());
				json.put("groupname", glist.get(i).getGroupname().toString());
				schedules.add(json);
			}
		}
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.print(schedules.toString());
		out.flush();
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
