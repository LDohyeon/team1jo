package ServletCalendar;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import DAO.ScheduleDAO;
import DTO.ScheduleDTO;

@WebServlet("/scheduleDelete")
public class scheduleDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String num = request.getParameter("num");
		
		ScheduleDAO sDAO = ScheduleDAO.getInstance();
		ScheduleDTO sDTO = new ScheduleDTO();
		sDTO.setNum(num);
		
		sDAO.scheduleDelete(sDTO);
	}
}
