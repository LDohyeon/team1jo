package ServletCalendar;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.*;
import org.json.simple.JSONArray;

import DAO.GroupDAO;
import DAO.ScheduleDAO;
import DTO.GroupDTO;
import DTO.ScheduleDTO;

@WebServlet("/scheduleSelect")
public class scheduleSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		String userKey = request.getParameter("userKey");
		
		ScheduleDAO sDAO = ScheduleDAO.getInstance();
		GroupDAO gDAO = GroupDAO.getInstance();
		
		List<GroupDTO> glist = gDAO.groupList(userKey);
		List<ScheduleDTO> slist= new ArrayList<ScheduleDTO>();
		JSONArray jsons = new JSONArray();
		
		for(int i = 0; i<glist.size(); i++) {
			
			JSONArray schedules = new JSONArray();
			
			JSONObject json = new JSONObject();
			slist=sDAO.scheduleList(glist.get(i));
			
			json.put("groupnum", glist.get(i).getGroupnum().toString());
			json.put("groupname", glist.get(i).getGroupname().toString());
			json.put("groupcolor", glist.get(i).getGroupcolor().toString());
			json.put("master", glist.get(i).getMaster().toString());
			json.put("searchable", glist.get(i).getSearchable().toString());
			json.put("members", glist.get(i).getMembers().toString());
			json.put("modifiers", glist.get(i).getModifiers().toString());
			
			for(int j = 0; j<slist.size(); j++) {
				JSONObject json1 = new JSONObject();
				json1.put("num", slist.get(j).getNum().toString());
				json1.put("title", slist.get(j).getTitle().toString());
				json1.put("start", slist.get(j).getStart().toString());
				json1.put("end", slist.get(j).getEnd().toString());
				json1.put("content", slist.get(j).getContent().toString());
				json1.put("writer", slist.get(j).getWriter().toString());
				json1.put("color", slist.get(j).getColor().toString());
				
				schedules.add(json1);
			}
			json.put("schedule", schedules);
			jsons.add(i, json);
		}
		
		response.setContentType("application/json");
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.print(jsons.toString());
		out.flush();
		
	}
}
