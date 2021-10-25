package ServletCalendar;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.*;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ScheduleDAO;
import DTO.GroupDTO;
import DTO.ScheduleDTO;

@WebServlet("/scheduleSelect")
public class scheduleSelect extends HttpServlet {
	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		response.setContentType("text/xml; charset=utf-8");
		
		String userKey = request.getParameter("userKey");
		PrintWriter xml = response.getWriter();
		String info = "<data>";
		
		ScheduleDAO sDAO = ScheduleDAO.getInstance();
		
		List<GroupDTO> glist = sDAO.groupList(userKey);
		
		List<ScheduleDTO> slist= new ArrayList<ScheduleDTO>();
		
		for(int i = 0; i<glist.size(); i++) {
			slist=sDAO.scheduleList(glist.get(i));
			info += "<group>";
			info += getXmlTag("groupnum", glist.get(i).getGroupnum());
			info += getXmlTag("groupname", glist.get(i).getGroupname());
			info += getXmlTag("groupmembers", glist.get(i).getMembers());
			info += getXmlTag("groupcolor", glist.get(i).getGroupcolor());
			info += getXmlTag("modifier", glist.get(i).getModifier());
			info += getXmlTag("master", glist.get(i).getMaster());
			info += getXmlTag("searchable", glist.get(i).getSearchable());
			
			for(int j = 0; j<slist.size(); j++) {
				info += "<schedule>";
				info += getXmlTag("num", slist.get(j).getNum());
				info += getXmlTag("title", slist.get(j).getTitle());
				info += getXmlTag("start", slist.get(j).getStart());
				info += getXmlTag("end", slist.get(j).getEnd());
				info += getXmlTag("content", slist.get(j).getContent());
				info += getXmlTag("writer", slist.get(j).getWriter());
				info += getXmlTag("color", slist.get(j).getColor());
				info += "</schedule>";
			}
			
			info += "</group>";
		}
		info += "<data>";
	
		xml.print(info);

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
