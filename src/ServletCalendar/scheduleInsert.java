package ServletCalendar;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ScheduleDAO;
import DTO.ScheduleDTO;

@WebServlet("/addSchedule")
public class scheduleInsert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
	
		String title = request.getParameter("title");
		String content = request.getParameter("content");
		String start=request.getParameter("start");
		String end=request.getParameter("end");
		String color=request.getParameter("color");
		String writer=request.getParameter("writer");
		String groupnum=request.getParameter("groupnum");
		
		ScheduleDTO sDTO = new ScheduleDTO();
		sDTO.setTitle(title);
		sDTO.setContent(content);
		sDTO.setStart(start);
		sDTO.setEnd(end);
		sDTO.setColor(color);
		sDTO.setWriter(writer);
		sDTO.setGroupnum(groupnum);
		
		ScheduleDAO sDAO = ScheduleDAO.getInstance();
		
		sDAO.scheduleInsert(sDTO);	
	}

}
