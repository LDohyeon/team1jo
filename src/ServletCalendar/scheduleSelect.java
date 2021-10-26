package ServletCalendar;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.json.simple.JSONObject;

import DAO.ScheduleDAO;
import DTO.GroupDTO;
import DTO.ScheduleDTO;

@WebServlet("/scheduleSelect")
public class scheduleSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	@SuppressWarnings("unchecked")
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml; charset=utf-8");
		
		String userKey = request.getParameter("userKey");
		
		ScheduleDAO sDAO = ScheduleDAO.getInstance();
		
		List<GroupDTO> glist = sDAO.groupList(userKey);
		List<ScheduleDTO> slist= new ArrayList<ScheduleDTO>();
		List<JSONObject> jsons = new ArrayList<JSONObject>();
		
		for(int i = 0; i<glist.size(); i++) {
			
			List<JSONObject> schedules = new ArrayList<JSONObject>();
			JSONObject json = new JSONObject();
			slist=sDAO.scheduleList(glist.get(i));
			json.put("groupnum", glist.get(i).getGroupnum());
			json.put("groupname", glist.get(i).getGroupname());
			json.put("groupmembers", glist.get(i).getMembers());
			json.put("groupcolor", glist.get(i).getGroupcolor());
			json.put("modifier", glist.get(i).getModifier());
			json.put("master", glist.get(i).getMaster());
			json.put("searchable", glist.get(i).getSearchable());
			
			for(int j = 0; j<slist.size(); j++) {
				JSONObject json1 = new JSONObject();
				json1.put("num", slist.get(j).getNum());
				json1.put("title", slist.get(j).getTitle());
				json1.put("start", slist.get(j).getStart());
				json1.put("end", slist.get(j).getEnd());
				json1.put("content", slist.get(j).getContent());
				json1.put("writer", slist.get(j).getWriter());
				json1.put("color", slist.get(j).getColor());
				
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
	protected String getXmlTag(String tag, String inner) {
		String info = "<"+tag+">"+inner+"</"+tag+">";
		return info;
	}
	protected String getXmlTag(String tag, int inner) {
		String info = "<"+tag+">"+inner+"</"+tag+">";
		return info;
	}
}
