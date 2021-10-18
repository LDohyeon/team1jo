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

@WebServlet("/getGroup")
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
			info += getXmlTag("modifier", glist.get(i).getModifier());
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
		
		if(userKey.equals("DEMOUSER")) {
			xml.print(demoInfo());
		}
		else {
			xml.print(info);
		}
	}
	protected String getXmlTag(String tag, String inner) {
		String info = "<"+tag+">"+inner+"</"+tag+">";
		return info;
	}
	protected String getXmlTag(String tag, int inner) {
		String info = "<"+tag+">"+inner+"</"+tag+">";
		return info;
	}
	
	protected String demoInfo() {
		String info = 
		"<data>"
			+ "<group>"
				+ "<groupnum>1</groupnum>"
				+ "<groupname>DEMOUSER</groupname>"
				+ "<modifier>DEMOUSER</modifier>"
				+ "<schedule>"
					+ "<num>1</num>"
					+ "<title>뮤지컬 관람 하기</title>"
					+ "<start>2021-10-30 09:00:00</start>"
					+ "<end>2021-10-30 13:00:00</end>"
					+ "<content></content>"
					+ "<writer>DEMOUSER</writer>"
				+ "</schedule>"
			+ "</group>"
			+ "<group>"
				+ "<groupnum>2</groupnum>"
				+ "<groupname>DEMO1</groupname>"
				+ "<modifier>DEMOUSER</modifier>"
				+ "<schedule>"
					+ "<num>2</num>"
					+ "<title>휴대전화 요금 내기</title>"
					+ "<start>2021-10-01 12:00:00</start>"
					+ "<end>2021-10-03 18:00:00</end>"
					+ "<content></content>"
					+ "<writer>DEMOUSER</writer>"
				+ "</schedule>"
			+ "</group>"
			+ "<group>"
				+ "<groupnum>3</groupnum>"
				+ "<groupname>DEMO2</groupname>"
				+ "<modifier>DEMOUSER</modifier>"
				+ "<schedule>"
					+ "<num>3</num>"
					+ "<title>어머니한테 전화</title>"
					+ "<start>2021-10-02 12:00:00</start>"
					+ "<end>2021-10-02 13:00:00</end>"
					+ "<content></content>"
					+ "<writer>DEMOUSER</writer>"
				+ "</schedule>"
			+ "</group>"
			+ "<group>"
				+ "<groupnum>4</groupnum>"
				+ "<groupname>DEMO3</groupname>"
				+ "<modifier>DEMOUSER</modifier>"
				+ "<schedule>"
					+ "<num>4</num>"
					+ "<title>논물 읽고 과제</title>"
					+ "<start>2021-10-07 12:00:00</start>"
					+ "<end>2021-10-17 13:00:00</end>"
					+ "<content></content>"
					+ "<writer>DEMOUSER</writer>"
				+ "</schedule>"
				+ "<schedule>"
					+ "<num>5</num>"
					+ "<title>휴가</title>"
					+ "<start>2021-10-20 12:00:00</start>"
					+ "<end>2021-10-24 13:00:00</end>"
					+ "<content></content>"
					+ "<writer>DEMOUSER</writer>"
				+ "</schedule>"
			+ "</group>"
		+ "</data>";
		return info;
	}
}
